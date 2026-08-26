USING LBC;

{OpcUa.NodeGenerator.IdType = AutoIncrement}
CONFIGURATION MyConfiguration
    TASK Main(Interval := T#50ms, Priority := 1);
    PROGRAM P1 WITH Main: LBCinterface;

    VAR_GLOBAL

        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstAnalogInput: LBC_typeAnalogInputInterface;
        
    END_VAR
END_CONFIGURATION
