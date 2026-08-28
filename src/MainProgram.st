USING LBC;

PROGRAM LBCexample
    VAR_EXTERNAL
        myInput : INT;
        simInput : INT;
        simMode : BOOL;
        qualityBit : BOOL;
        resetBit : BOOL;
        InstAnalogInput: LBC_typeAnalogInputInterface;
        AI1 : LBC_AnalogInput;
    END_VAR

    VAR

    END_VAR

    VAR_TEMP

    END_VAR
;

AI1.enable := TRUE;
AI1.parentReferenceDesignator := InstAnalogInput.config.referenceDesignator;
AI1.analogValue := myInput;
AI1.simulatedAnalogValue := simInput;
AI1.simulation := simMode;
AI1.reset := resetBit;
AI1.quality := qualityBit;

AI1(config := InstAnalogInput.config, moduleInterface := InstAnalogInput);

//dummy := AI1.valid;
//dummy := AI1.busy;
//dummy := AI1.error;
//dummy := AI1.status;
//dummy := AI1.processValue;
//dummy := AI1.limitHigh2;
//dummy := AI1.limitHigh1;
//dummy := AI1.limitLow1;
//dummy := AI1.limitLow2;
//dummy := AI1.maxValueReached;
//dummy := AI1.minValueReached;

END_PROGRAM
