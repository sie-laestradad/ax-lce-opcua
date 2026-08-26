USING Siemens.Simatic.Clocks;

TYPE
    {S7.extern=ReadWrite}
    LAF_typeButtons: STRUCT
        operatorControlAllowed: DWORD;
        active: DWORD;
    END_STRUCT;
END_TYPE

TYPE
    {S7.extern=ReadWrite}
    LAF_typeHistoryRecord: STRUCT
        mode: DINT;
        state: DINT;
        duration: LREAL;
        started: DATE_AND_TIME;
    END_STRUCT;
END_TYPE

PROGRAM LBCinterface
    VAR_EXTERNAL

    END_VAR

    VAR

    END_VAR

    VAR_TEMP
        temp:REAL;
    END_VAR
 ;

END_PROGRAM
