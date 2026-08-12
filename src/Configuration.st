//Change to SymbolName and use the SymbolName TIA project for proper mappings with string nodeIds
{OpcUa.NodeGenerator.IdType = AutoIncrement}
CONFIGURATION MyConfiguration
    TASK Main(Interval := T#50ms, Priority := 1);
    PROGRAM P1 WITH Main: WaterTank;

    VAR_GLOBAL
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        tank: Tank;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.Extern=ReadWrite}
        {resource=alarming?refid:dd62150c}
        highLevelAlarm : Siemens.Simatic.Alarming.ProgramAlarm;
        
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        toPLC: DWORD;
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        fromPLC: LAF_typeButtons1;
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        Config: DWORD;
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        History: ARRAY[0..8] OF LAF_typeHistoryRecord1;
        
    END_VAR
END_CONFIGURATION
