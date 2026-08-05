#!/bin/bash

# ========== handle parameters part ==========

set -e

usage() {
cat <<EOF
Usage: $0 [--dns DNSNAME] [--ip IPADDRESS] [--uri URI] [--pkcs12-password PASSWORD]

Options:
  --dns   DNS.1 entry for subject alternative names
  --ip    IP.1 entry for subject alternative names
  --uri   URI.1 entry for subject alternative names
  --pkcs12-password Password for the PKCS#12 container (if omitted, prompted; if prompt left blank, no password)

Description:
  This script generates a self-signed X.509 certificate with subject alternative names (SAN) for DNS, IP, and URI,
  and bundles it with its private key in a PKCS#12 (.p12) file.

  Any of --dns, --ip, --uri, or the password may be omitted to be prompted interactively.
  Press ENTER at a prompt to use the displayed default (which is empty for DNS, URI).
  The Common Name (CN) in the certificate will default to 'localhost' if no DNS name is provided.
  If you skip the password or press just ENTER at the prompt, the certificate will be created without a password.

Examples:
  $0 --pkcs12-password MySecretPassword
      # Prompts for DNS, IP, and URI with empty defaults, uses MySecretPassword.

  $0 --dns server01 --ip 10.0.0.42 --uri urn:siemens:opcua:server01 --pkcs12-password MySecretPassword
      # Uses all values given, does not prompt.

  $0
      # Prompts for everything, using empty defaults for DNS, IP, URI.
      # CN will be 'localhost' if DNS is left empty.
EOF
exit 0
}

# === ABSOLUTE EARLY HELP CHECK; NO SHIFTS OR PARSES YET ===
for arg in "$@"; do
  if [[ "$arg" == "-h" || "$arg" == "--help" ]]; then
    usage
  fi
done

# --- Now do argument parsing safely! ---
# Default values for prompts - these are the values that will be suggested
# if the user just presses Enter at the prompt.
# For DNS, IP, URI, we want them to be empty by default if not provided.
DEFAULT_DNS=""
DEFAULT_IP="192.168.0.1"
DEFAULT_URI=""

# Variables to store the actual values after parsing and prompting
DNS_VALUE=""
IP_VALUE=""
URI_VALUE=""
PKCS12_PASS="" # This will store the actual password if provided, or remain empty if user opts for no password

# Flags to track if an option was provided on the command line
DNS_PROVIDED=false
IP_PROVIDED=false
URI_PROVIDED=false
PKCS12_PASS_PROVIDED_VIA_ARG=false # New flag to track if password was given via --pkcs12-password

# Temporary array to hold positional arguments
declare -a POSITIONAL_ARGS

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dns)
            shift
            DNS_VALUE="$1"
            DNS_PROVIDED=true
            shift
            ;;
        --ip)
            shift
            IP_VALUE="$1"
            IP_PROVIDED=true
            shift
            ;;
        --uri)
            shift
            URI_VALUE="$1"
            URI_PROVIDED=true
            shift
            ;;
        --pkcs12-password)
            shift
            PKCS12_PASS="$1"
            PKCS12_PASS_PROVIDED_VIA_ARG=true # Set flag
            shift
            ;;
        *)
            # Collect other arguments that are not recognized options
            POSITIONAL_ARGS+=("$1")
            shift
            ;;
    esac
done

# Process positional arguments. Assume the last one is PKCS12_PASS if not set by --pkcs12-password.
if ! $PKCS12_PASS_PROVIDED_VIA_ARG && [[ ${#POSITIONAL_ARGS[@]} -gt 0 ]]; then
    # Only consider the last positional arg as password if it's not empty
    if [[ -n "${POSITIONAL_ARGS[-1]}" ]]; then
        PKCS12_PASS="${POSITIONAL_ARGS[-1]}"
        PKCS12_PASS_PROVIDED_VIA_ARG=true # Set flag as password was provided
        unset 'POSITIONAL_ARGS[${#POSITIONAL_ARGS[@]}-1]' # Remove it from positional args
    fi
fi

# Check for any remaining unexpected positional arguments
if [[ ${#POSITIONAL_ARGS[@]} -gt 0 ]]; then
    echo "Unexpected arguments: ${POSITIONAL_ARGS[*]}"
    usage
fi

# Interactive prompts if values were not provided via command line
if ! $DNS_PROVIDED; then
  read -p "Enter DNS.1 value [${DEFAULT_DNS}]: " USER_INPUT
  DNS_VALUE="${USER_INPUT:-$DEFAULT_DNS}" # Use user input or default
fi

if ! $IP_PROVIDED; then
  read -p "Enter IP.1 value. Default ip: [${DEFAULT_IP}]: " USER_INPUT
  IP_VALUE="${USER_INPUT:-$DEFAULT_IP}" # Use user input or default
fi

if ! $URI_PROVIDED; then
  read -p "Enter URI.1 value [${DEFAULT_URI}]: " USER_INPUT
  URI_VALUE="${USER_INPUT:-$DEFAULT_URI}" # Use user input or default
fi

# Determine the Common Name (CN) for the certificate.
# CN cannot be empty, so provide a default if DNS_VALUE is empty after all checks.
COMMON_NAME="$DNS_VALUE"
if [[ -z "$COMMON_NAME" ]]; then
    COMMON_NAME="localhost" # Default CN if no DNS name is provided
fi

# --- Password Handling Logic ---
PKCS12_PASS_ARG="" # Argument for -passout
PKCS12_PASS_IN_ARG="" # Argument for -passin

if ! $PKCS12_PASS_PROVIDED_VIA_ARG; then
  # Password was not provided via command line, so prompt the user
  read -s -p "Enter PKCS12 password (leave empty for no password): " USER_PROMPT_PASS
  echo # Newline after silent input

  if [[ -z "$USER_PROMPT_PASS" ]]; then
    # User left prompt blank, meaning no password
    echo "As no password is provided, certificate will not be protected by a password."
    PKCS12_PASS="" # Ensure PKCS12_PASS is empty
    PKCS12_PASS_ARG="-passout pass:"
    PKCS12_PASS_IN_ARG="-passin pass:"
  else
    # User entered a password via prompt
    PKCS12_PASS="$USER_PROMPT_PASS"
    PKCS12_PASS_ARG="-passout pass:$PKCS12_PASS"
    PKCS12_PASS_IN_ARG="-passin pass:$PKCS12_PASS"
  fi
else
  # Password was provided via command line, use it
  PKCS12_PASS_ARG="-passout pass:$PKCS12_PASS"
  PKCS12_PASS_IN_ARG="-passin pass:$PKCS12_PASS"
fi

# ========== generate certificate part ==========

mkdir -p certificate

cat <<EOF > server_cert_ext.cnf
[ req ]
default_bits       = 2048
default_md         = sha256
distinguished_name = dn
x509_extensions    = v3_req
prompt             = no

[ dn ]
C  = XX
ST = Bavaria
L  = Erlangen
O  = Siemens AG
OU = hwcn@ax
CN = $COMMON_NAME

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = critical, digitalSignature, nonRepudiation, keyCertSign, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth,clientAuth
subjectAltName = @alt_names
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always

[ alt_names ]
# These entries will be included. OpenSSL handles empty values for SANs gracefully.
DNS.1 = $DNS_VALUE
IP.1 = $IP_VALUE
URI.1 = $URI_VALUE
EOF

echo "Step1 of PKCS12 file creation STARTED: generating private key"
openssl genrsa -out privateKey.pem 2048
echo "Step1 of PKCS12 file creation COMPLETED: privateKey.pem is generated"

echo "Step2 of PKCS12 file creation STARTED: generating self-signed certificate"
openssl req -new -x509 -days 3650 -key privateKey.pem -out server.cert.pem -config server_cert_ext.cnf -extensions v3_req
echo "Step2 of PKCS12 file creation COMPLETED: server.cert.pem is generated"

echo "Step3 of PKCS12 file creation STARTED: export certificate in pkcs12 format"
# Use the dynamically generated PKCS12_PASS_ARG
openssl pkcs12 -export -in server.cert.pem -inkey privateKey.pem -out containerWithPublicAndPrivateKeys_x509.p12 $PKCS12_PASS_ARG
echo "Step3 of PKCS12 file creation COMPLETED: export certificate in pkcs12 format"

echo "Certificate with public key creation STARTED"
# Use the dynamically generated PKCS12_PASS_IN_ARG
openssl pkcs12 -in containerWithPublicAndPrivateKeys_x509.p12 -out reference_x509.crt -nokeys $PKCS12_PASS_IN_ARG
echo "Certificate with public key creation COMPLETED"

mv reference_x509.crt certificate
mv containerWithPublicAndPrivateKeys_x509.p12 certificate
rm privateKey.pem
rm server.cert.pem
rm server_cert_ext.cnf

echo "All done! See the 'certificate' folder."