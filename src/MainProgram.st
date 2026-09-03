USING LBC;

// ===================== AnalogInput =====================
TYPE LBC_test_AnalogInput_Input : STRUCT
    enable                     : BOOL;
    parentReferenceDesignator  : WSTRING[128];
    analogValue                : INT;
    simulatedAnalogValue       : INT;
    simulation                 : BOOL;
    reset                      : BOOL;
    quality                    : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_AnalogInput_Output : STRUCT
    valid            : BOOL;
    busy             : BOOL;
    error            : BOOL;
    status           : WORD;
    processValue     : LREAL;
    limitHigh2       : BOOL;
    limitHigh1       : BOOL;
    limitLow1        : BOOL;
    limitLow2        : BOOL;
    maxValueReached  : BOOL;
    minValueReached  : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_AnalogInput : STRUCT
    input  : LBC_test_AnalogInput_Input;
    output : LBC_test_AnalogInput_Output;
END_STRUCT;
END_TYPE

// ===================== AnalogScaleCn (AScale) =====================
TYPE LBC_test_AnalogScaleCn_Input : STRUCT
    enable                      : BOOL;
    parentReferenceDesignator   : WSTRING[128];
    inputValue                  : LREAL;
    simulatedInputValue         : LREAL;
END_STRUCT;
END_TYPE

TYPE LBC_test_AnalogScaleCn_Output : STRUCT
    outputValue : LREAL;
    valid       : BOOL;
    busy        : BOOL;
    error       : BOOL;
    status      : WORD;
END_STRUCT;
END_TYPE

TYPE LBC_test_AnalogScaleCn : STRUCT
    input  : LBC_test_AnalogScaleCn_Input;
    output : LBC_test_AnalogScaleCn_Output;
END_STRUCT;
END_TYPE

// ===================== DigitalSignal (Dsig) =====================
TYPE LBC_test_DigitalSignal_Input : STRUCT
    enable                     : BOOL;
    parentReferenceDesignator  : WSTRING[128];
    digitalValue               : BOOL;
    simulatedDigitalValue      : BOOL;
    reset                      : BOOL;
    simulation                 : BOOL;
    quality                    : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_DigitalSignal_Output : STRUCT
    valid        : BOOL;
    busy         : BOOL;
    error        : BOOL;
    status       : WORD;
    risingEdge   : BOOL;
    fallingEdge  : BOOL;
    processValue : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_DigitalSignal : STRUCT
    input  : LBC_test_DigitalSignal_Input;
    output : LBC_test_DigitalSignal_Output;
END_STRUCT;
END_TYPE

// ===================== TwoWayActuator =====================
TYPE LBC_test_TwoWayActuator_Input : STRUCT
    enable                     : BOOL;
    parentReferenceDesignator  : WSTRING[128];
    feedbackHomePos            : BOOL;
    feedbackWorkPos            : BOOL;
    enableManualCmds           : BOOL;
    interlockWorkPos           : BOOL;
    interlockHomePos           : BOOL;
    commandHomePos             : BOOL;
    commandWorkPos             : BOOL;
    reset                      : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_TwoWayActuator_Output : STRUCT
    goToHomePos          : BOOL;
    goToWorkPos          : BOOL;
    valid                : BOOL;
    busy                 : BOOL;
    error                : BOOL;
    status               : WORD;
    inHomePos            : BOOL;
    inWorkPos            : BOOL;
    interlockWorkPosOut  : BOOL;
    interlockHomePosOut  : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_TwoWayActuator : STRUCT
    input  : LBC_test_TwoWayActuator_Input;
    output : LBC_test_TwoWayActuator_Output;
END_STRUCT;
END_TYPE

// ===================== ThreeWayActuator =====================
TYPE LBC_test_ThreeWayActuator_Input : STRUCT
    enable                     : BOOL;
    parentReferenceDesignator  : WSTRING[128];
    feedbackNeutralPos         : BOOL;
    feedbackWorkPos1           : BOOL;
    feedbackWorkPos2           : BOOL;
    enableManualCmds           : BOOL;
    interlockWorkPos1          : BOOL;
    interlockWorkPos2          : BOOL;
    interlockNeutralPos        : BOOL;
    commandNeutralPos          : BOOL;
    commandWorkPos1            : BOOL;
    commandWorkPos2            : BOOL;
    reset                      : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_ThreeWayActuator_Output : STRUCT
    goToNeutralPos          : BOOL;
    goToWorkPos1            : BOOL;
    goToWorkPos2            : BOOL;
    error                   : BOOL;
    status                  : WORD;
    valid                   : BOOL;
    busy                    : BOOL;
    inNeutralPos            : BOOL;
    inWorkPos1              : BOOL;
    inWorkPos2              : BOOL;
    interlockNeutralPosOut  : BOOL;
    interlockWorkPos1Out    : BOOL;
    interlockWorkPos2Out    : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_ThreeWayActuator : STRUCT
    input  : LBC_test_ThreeWayActuator_Input;
    output : LBC_test_ThreeWayActuator_Output;
END_STRUCT;
END_TYPE

// ===================== MotorStarter =====================
TYPE LBC_test_MotorStarter_Input : STRUCT
    enable                     : BOOL;
    parentReferenceDesignator  : WSTRING[128];
    feedbackReady              : BOOL;
    feedbackRunningForward     : BOOL;
    feedbackRunningBackward    : BOOL;
    feedbackError              : BOOL;
    interlock                  : BOOL;
    enableManualCmds           : BOOL;
    commandForward             : BOOL;
    commandBackward            : BOOL;
    reset                      : BOOL;
END_STRUCT;
END_TYPE

TYPE LBC_test_MotorStarter_Output : STRUCT
    enableStarter  : BOOL;
    starterActive  : BOOL;
    forward        : BOOL;
    backward       : BOOL;
    resetStarter   : BOOL;
    valid          : BOOL;
    busy           : BOOL;
    error          : BOOL;
    status         : WORD;
END_STRUCT;
END_TYPE

TYPE LBC_test_MotorStarter : STRUCT
    input  : LBC_test_MotorStarter_Input;
    output : LBC_test_MotorStarter_Output;
END_STRUCT;
END_TYPE

PROGRAM LBCexample
    VAR_EXTERNAL

        // ---- library interface/config instances (real objects, not test scratch) ----
        InstAnalogInput     : LBC_typeAnalogInputInterface;
        InstAchn            : LBC_typeAnalogScaleInterface;
        InstDsig            : LBC_typeDigitalSignalInterface;
        InstTwoWay          : LBC_typeTwoWayActuatorInterface;
        InstThreeWay        : LBC_typeThreeWayActuatorInterface;
        InstMotorStarter    : LBC_typeMotorStarterInterface;

    END_VAR

    VAR
        // ---- FB instances under test ----
        AInput       : LBC.LBC_AnalogInput;
        AScale       : LBC.LBC_AnalogScaleCn;
        Dsig         : LBC.LBC_DigitalSignal;
        twoWay       : LBC.LBC_TwoWayActuator;
        threeWay     : LBC.LBC_ThreeWayActuator;
        motorStarter : LBC.LBC_MotorStarter;
        
        InstAchnControlNode : LBC_typeAnalogScaleControlNode;
        
        // ---- scalable test harnesses: force/monitor via .input.* / .output.* ----
        AInputTest       : LBC_test_AnalogInput;
        AScaleTest       : LBC_test_AnalogScaleCn;
        DsigTest         : LBC_test_DigitalSignal;
        twoWayTest       : LBC_test_TwoWayActuator;
        threeWayTest     : LBC_test_ThreeWayActuator;
        motorStarterTest : LBC_test_MotorStarter;

    END_VAR


    VAR_TEMP

    END_VAR
;

// ---- AnalogInput ----
AInput(
    enable                    := AInputTest.input.enable,
    parentReferenceDesignator := AInputTest.input.parentReferenceDesignator,
    analogValue               := AInputTest.input.analogValue,
    simulatedAnalogValue      := AInputTest.input.simulatedAnalogValue,
    simulation                := AInputTest.input.simulation,
    reset                     := AInputTest.input.reset,
    quality                   := AInputTest.input.quality,
    valid                     => AInputTest.output.valid,
    busy                      => AInputTest.output.busy,
    error                     => AInputTest.output.error,
    status                    => AInputTest.output.status,
    processValue              => AInputTest.output.processValue,
    limitHigh2                => AInputTest.output.limitHigh2,
    limitHigh1                => AInputTest.output.limitHigh1,
    limitLow1                 => AInputTest.output.limitLow1,
    limitLow2                 => AInputTest.output.limitLow2,
    maxValueReached           => AInputTest.output.maxValueReached,
    minValueReached           => AInputTest.output.minValueReached,
    config                    := InstAnalogInput.config,
    moduleInterface           := InstAnalogInput
);

// ---- AnalogScaleCn ----
AScale(
    enable                    := AScaleTest.input.enable,
    parentReferenceDesignator := AScaleTest.input.parentReferenceDesignator,
    inputValue                := AScaleTest.input.inputValue,
    simulatedInputValue       := AScaleTest.input.simulatedInputValue,
    outputValue               => AScaleTest.output.outputValue,
    valid                     => AScaleTest.output.valid,
    busy                      => AScaleTest.output.busy,
    error                     => AScaleTest.output.error,
    status                    => AScaleTest.output.status,
    config                    := InstAchn.config,
    moduleInterface           := InstAchn,
    controlNode               := InstAchnControlNode
);

// ---- DigitalSignal ----
Dsig(
    enable                    := DsigTest.input.enable,
    parentReferenceDesignator := DsigTest.input.parentReferenceDesignator,
    digitalValue              := DsigTest.input.digitalValue,
    simulatedDigitalValue     := DsigTest.input.simulatedDigitalValue,
    reset                     := DsigTest.input.reset,
    simulation                := DsigTest.input.simulation,
    quality                   := DsigTest.input.quality,
    valid                     => DsigTest.output.valid,
    busy                      => DsigTest.output.busy,
    error                     => DsigTest.output.error,
    status                    => DsigTest.output.status,
    risingEdge                => DsigTest.output.risingEdge,
    fallingEdge               => DsigTest.output.fallingEdge,
    processValue              => DsigTest.output.processValue,
    config                    := InstDsig.config,
    moduleInterface           := InstDsig
);

// ---- TwoWayActuator ----
twoWay(
    enable                    := twoWayTest.input.enable,
    parentReferenceDesignator := twoWayTest.input.parentReferenceDesignator,
    feedbackHomePos           := twoWayTest.input.feedbackHomePos,
    feedbackWorkPos           := twoWayTest.input.feedbackWorkPos,
    enableManualCmds          := twoWayTest.input.enableManualCmds,
    interlockWorkPos          := twoWayTest.input.interlockWorkPos,
    interlockHomePos          := twoWayTest.input.interlockHomePos,
    commandHomePos            := twoWayTest.input.commandHomePos,
    commandWorkPos            := twoWayTest.input.commandWorkPos,
    reset                     := twoWayTest.input.reset,
    goToHomePos               => twoWayTest.output.goToHomePos,
    goToWorkPos               => twoWayTest.output.goToWorkPos,
    valid                     => twoWayTest.output.valid,
    busy                      => twoWayTest.output.busy,
    error                     => twoWayTest.output.error,
    status                    => twoWayTest.output.status,
    inHomePos                 => twoWayTest.output.inHomePos,
    inWorkPos                 => twoWayTest.output.inWorkPos,
    interlockWorkPosOut       => twoWayTest.output.interlockWorkPosOut,
    interlockHomePosOut       => twoWayTest.output.interlockHomePosOut,
    config                    := InstTwoWay.config,
    moduleInterface           := InstTwoWay
);

// ---- ThreeWayActuator ----
threeWay(
    enable                    := threeWayTest.input.enable,
    parentReferenceDesignator := threeWayTest.input.parentReferenceDesignator,
    feedbackNeutralPos        := threeWayTest.input.feedbackNeutralPos,
    feedbackWorkPos1          := threeWayTest.input.feedbackWorkPos1,
    feedbackWorkPos2          := threeWayTest.input.feedbackWorkPos2,
    enableManualCmds          := threeWayTest.input.enableManualCmds,
    interlockWorkPos1         := threeWayTest.input.interlockWorkPos1,
    interlockWorkPos2         := threeWayTest.input.interlockWorkPos2,
    interlockNeutralPos       := threeWayTest.input.interlockNeutralPos,
    commandNeutralPos         := threeWayTest.input.commandNeutralPos,
    commandWorkPos1           := threeWayTest.input.commandWorkPos1,
    commandWorkPos2           := threeWayTest.input.commandWorkPos2,
    reset                     := threeWayTest.input.reset,
    goToNeutralPos            => threeWayTest.output.goToNeutralPos,
    goToWorkPos1              => threeWayTest.output.goToWorkPos1,
    goToWorkPos2              => threeWayTest.output.goToWorkPos2,
    error                     => threeWayTest.output.error,
    status                    => threeWayTest.output.status,
    valid                     => threeWayTest.output.valid,
    busy                      => threeWayTest.output.busy,
    inNeutralPos              => threeWayTest.output.inNeutralPos,
    inWorkPos1                => threeWayTest.output.inWorkPos1,
    inWorkPos2                => threeWayTest.output.inWorkPos2,
    interlockNeutralPosOut    => threeWayTest.output.interlockNeutralPosOut,
    interlockWorkPos1Out      => threeWayTest.output.interlockWorkPos1Out,
    interlockWorkPos2Out      => threeWayTest.output.interlockWorkPos2Out,
    config                    := InstThreeWay.config,
    moduleInterface           := InstThreeWay
);

// ---- MotorStarter ----
motorStarter(
    enable                     := motorStarterTest.input.enable,
    parentReferenceDesignator  := motorStarterTest.input.parentReferenceDesignator,
    feedbackReady              := motorStarterTest.input.feedbackReady,
    feedbackRunningForward     := motorStarterTest.input.feedbackRunningForward,
    feedbackRunningBackward    := motorStarterTest.input.feedbackRunningBackward,
    feedbackError              := motorStarterTest.input.feedbackError,
    interlock                  := motorStarterTest.input.interlock,
    enableManualCmds           := motorStarterTest.input.enableManualCmds,
    commandForward             := motorStarterTest.input.commandForward,
    commandBackward            := motorStarterTest.input.commandBackward,
    reset                      := motorStarterTest.input.reset,
    enableStarter              => motorStarterTest.output.enableStarter,
    starterActive              => motorStarterTest.output.starterActive,
    forward                    => motorStarterTest.output.forward,
    backward                   => motorStarterTest.output.backward,
    resetStarter               => motorStarterTest.output.resetStarter,
    valid                      => motorStarterTest.output.valid,
    busy                       => motorStarterTest.output.busy,
    error                      => motorStarterTest.output.error,
    status                     => motorStarterTest.output.status,
    config                     := InstMotorStarter.config,
    moduleInterface            := InstMotorStarter
);

END_PROGRAM
