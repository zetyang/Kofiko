function [strctOutput] = fnParadigmDriftGratingCycle(strctInputs)

global g_strctParadigm g_strctStimulusServer g_strctPTB

fCurrTime = GetSecs();
switch g_strctParadigm.m_iMachineState
	case 0
		fnParadigmToKofikoComm('SetParadigmState', 'Waiting for user to press Start');
	case 1
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fTempFreq = g_strctParadigm.m_strctStimulusParams.TempFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.TempFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		iStimulusOnTime = g_strctParadigm.m_strctStimulusParams.StimulusOnMS.Buffer(g_strctParadigm.m_strctStimulusParams.StimulusOnMS.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
		fnParadigmToStimulusServer('Drift', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fTempFreq, fContrast, fOrientation, iStimulusOnTime, afBackgroundColor);
		
		fnParadigmToKofikoComm('SetParadigmState', 'Running...');
		g_strctParadigm.m_fStimulusOnTimer = GetSecs();
		g_strctParadigm.m_iMachineState = 2;
	case 2
		iStimulusOnTime = g_strctParadigm.m_strctStimulusParams.StimulusOnMS.Buffer(g_strctParadigm.m_strctStimulusParams.StimulusOnMS.BufferIdx);	
		if fCurrTime - g_strctParadigm.m_fStimulusOnTimer > (iStimulusOnTime / 1000)
			g_strctParadigm.m_iMachineState = 0;
		end
end
return;
