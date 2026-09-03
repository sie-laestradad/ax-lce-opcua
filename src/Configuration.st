USING LBC;

{OpcUa.NodeGenerator.IdType = AutoIncrement}
CONFIGURATION MyConfiguration
    TASK Main(Interval := T#50ms, Priority := 1);
    PROGRAM P1 WITH Main: LBCexample;

    VAR_GLOBAL

        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstAnalogInput     : LBC_typeAnalogInputInterface;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstAchn            : LBC_typeAnalogScaleInterface;
                
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstDsig            : LBC_typeDigitalSignalInterface;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstTwoWay          : LBC_typeTwoWayActuatorInterface;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstThreeWay        : LBC_typeThreeWayActuatorInterface;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstMotorStarter    : LBC_typeMotorStarterInterface;

    END_VAR
END_CONFIGURATION
