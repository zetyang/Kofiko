function fnParadigmDriftGratingCallbacks(strCallback, varargin)

global g_strctParadigm g_strctStimulusServer

switch strCallback
	case 'Start'
		g_strctParadigm.m_iMachineState = 1;
	case 'GratingCenterXSlider'
		iNewGratingCenterX = round(get(g_strctParadigm.m_strctControllers.m_hGratingCenterXSlider, 'value'));
		set(g_strctParadigm.m_strctControllers.m_hGratingCenterXEdit, 'String', num2str(iNewGratingCenterX));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix', iNewGratingCenterX);
		fnLog('Setting grating center x to %d pixles', iNewGratingCenterX);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'GratingCenterXEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hGratingCenterXEdit, 'string');
		iNewGratingCenterX = fnMyStr2Num(strTemp);
		if ~isempty(iNewGratingCenterX)
			iNewGratingCenterX = round(iNewGratingCenterX);
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hGratingCenterXSlider, iNewGratingCenterX);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXEdit', iNewGratingCenterX);
			fnLog('Setting grating center x to %d pixles', iNewGratingCenterX);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end
	otherwise
		fnParadigmToKofikoComm('DisplayMessage', [strCallback,' not handeled']);
end

return;	
		