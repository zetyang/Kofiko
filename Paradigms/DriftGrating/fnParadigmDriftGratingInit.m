function bSuccessful = fnParadigmGriftGratingInit()

global g_strctParadigm g_strctStimulusServer

g_strctParadigm.m_fStartTime = GetSecs;
g_strctParadigm.m_iMachineState = 0;
g_strctParadigm.m_bRedraw = 1;


iSmallBuffer = 100;



%%% Stimulus related parameters.
strctStimulusParams = fnTsAddVar([], 'FixationSpotPix', g_strctStimulusServer.m_aiScreenSize(3:4)/2, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'GratingCenterXPix', g_strctStimulusServer.m_aiScreenSize(3)/2, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'GratingCenterYPix', g_strctStimulusServer.m_aiScreenSize(4)/2, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'GratingSizePix', g_strctParadigm.m_fInitial_GratingSizePix, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'SpatialFreqHz', g_strctParadigm.m_fInitial_SpatialFreq, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'TempFreqHz', g_strctParadigm.m_fInitial_TempFreq, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'Contrast', g_strctParadigm.m_fInitial_Contrast, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'Orientation', g_strctParadigm.m_fInitial_Orientation, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'StimulusOnMS', g_strctParadigm.m_fInitial_StimulusON_MS, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'GazeBoxPix', g_strctParadigm.m_fInitial_GazeBoxPix, iSmallBuffer);
strctStimulusParams = fnTsAddVar(strctStimulusParams, 'BackgroundColor', g_strctParadigm.m_afInitial_BackgroundColor, iSmallBuffer);


g_strctParadigm.m_strctStimulusParams = strctStimulusParams;

bSuccessful = true;
return;