USING LBC;

{OpcUa.NodeGenerator.IdType = AutoIncrement}
CONFIGURATION MyConfiguration
    TASK Main(Interval := T#50ms, Priority := 1);
    PROGRAM P1 WITH Main: LBCexample;

    VAR_GLOBAL
        
        {OpcUa.accesslevel=Read}
        {S7.extern=Read}
        myInput AT %IW10 : INT;

        simInput : INT;
        simMode : BOOL := TRUE;
        qualityBit : BOOL := TRUE;
        resetBit : BOOL;

        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        InstAnalogInput: LBC_typeAnalogInputInterface;

        AI1 : LBC_AnalogInput;
        
    END_VAR
END_CONFIGURATION
