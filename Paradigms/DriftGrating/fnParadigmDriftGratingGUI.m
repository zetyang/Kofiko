function fnParadigmDriftGratingGUI()

global g_strctParadigm g_strctStimulusServer

[hParadigmPanel, iPanelHeight, iPanelWidth] = fnCreateParadigmPanel();
strctControllers.m_hPanel = hParadigmPanel;
strctControllers.m_iPanelHeight = iPanelHeight;
strctControllers.m_iPanelWidth = iPanelWidth;

iNumButtonsInRow = 3;
iButtonWidth = iPanelWidth / iNumButtonsInRow - 20;

screen_size = g_strctStimulusServer.m_aiScreenSize(3:4);
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40, ...
	'Grating Center X (Pix):', 'GratingCenterX', 0, screen_size(1), [1 50], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30, ...
	'Grating Center Y (Pix):', 'GratingCenterY', 0, screen_size(2), [1 50], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*2, ...
	'Grating Size (Pix):', 'GratingSize', 1, min(screen_size)/2, [1 10], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*3, ...
	'Spatial Frequency (Hz):', 'SpatialFreq', 0, 0.5, [0.005, 0.01], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*4, ...
	'Temporal Frequency (Hz):', 'TemporalFreq', 0, 60, [0.1, 1], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'TempFreqHz'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*5, ...
	'Contrast:', 'Contrast', 0, 1, [0.01, 0.1], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*6, ...
	'Orientation (Deg):', 'Orientation', 0, 180, [0.1, 1], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*7, ...
	'Stimulus On Time (MS):', 'StimulusOnTime', 10, 10000, [1, 50], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'StimulusOnMS'));
strctControllers = fnAddTextSliderEditComboSmall(strctControllers, 40+30*8, ...
	'Gaze Area (pix):', 'GazeRect', 0, 300, [1, 50], fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GazeBoxPix'));
	
g_strctParadigm.m_strctControllers = strctControllers;
return;
