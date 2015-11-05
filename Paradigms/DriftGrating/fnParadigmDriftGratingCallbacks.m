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
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix', iNewGratingCenterX);
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
    
    case 'GratingCenterYSlider'
		iNewGratingCenterY = round(get(g_strctParadigm.m_strctControllers.m_hGratingCenterYSlider, 'value'));
		set(g_strctParadigm.m_strctControllers.m_hGratingCenterYEdit, 'String', num2str(iNewGratingCenterY));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix', iNewGratingCenterY);
		fnLog('Setting grating center y to %d pixles', iNewGratingCenterY);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'GratingCenterYEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hGratingCenterYEdit, 'string');
		iNewGratingCenterY = fnMyStr2Num(strTemp);
		if ~isempty(iNewGratingCenterY)
			iNewGratingCenterY = round(iNewGratingCenterY);
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hGratingCenterYSlider, iNewGratingCenterY);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix', iNewGratingCenterY);
			fnLog('Setting grating center y to %d pixles', iNewGratingCenterY);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end
    
    case 'GratingSizeSlider'
		iNewGratingSize = round(get(g_strctParadigm.m_strctControllers.m_hGratingSizeSlider, 'value'));
		set(g_strctParadigm.m_strctControllers.m_hGratingSizeEdit, 'String', num2str(iNewGratingSize));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix', iNewGratingSize);
		fnLog('Setting grating size to %d pixles', iNewGratingSize);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
        g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'GratingSizeEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hGratingSizeEdit, 'string');
		iNewGratingSize = fnMyStr2Num(strTemp);
		if ~isempty(iNewGratingSize)
			iNewGratingSize = round(iNewGratingSize);
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hGratingSizeSlider, iNewGratingSize);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix', iNewGratingSize);
			fnLog('Setting grating Size to %d pixles', iNewGratingSize);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
            g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end

    case 'SpatialFreqSlider'
		iNewSpatialFreq = get(g_strctParadigm.m_strctControllers.m_hSpatialFreqSlider, 'value');
		set(g_strctParadigm.m_strctControllers.m_hSpatialFreqEdit, 'String', num2str(iNewSpatialFreq));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz', iNewSpatialFreq);
		fnLog('Setting spatial freq to %f Hz', iNewSpatialFreq);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
        g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'SpatialFreqEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hSpatialFreqEdit, 'string');
		iNewSpatialFreq = fnMyStr2Num(strTemp);
		if ~isempty(iNewSpatialFreq)
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hSpatialFreqSlider, iNewSpatialFreq);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz', iNewSpatialFreq);
			fnLog('Setting spatial freq to %f Hz', iNewSpatialFreq);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
            g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end

    case 'TemporalFreqSlider'
		iNewTemporalFreq = get(g_strctParadigm.m_strctControllers.m_hTemporalFreqSlider, 'value');
		set(g_strctParadigm.m_strctControllers.m_hTemporalFreqEdit, 'String', num2str(iNewTemporalFreq));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'TempFreqHz', iNewTemporalFreq);
		fnLog('Setting temporal freq to %f Hz', iNewTemporalFreq);
	case 'TemporalFreqEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hTemporalFreqEdit, 'string');
		iNewTemporalFreq = fnMyStr2Num(strTemp);
		if ~isempty(iNewTemporalFreq)
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hTemporalFreqSlider, iNewTemporalFreq);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'TempFreqHz', iNewTemporalFreq);
			fnLog('Setting temporal freq to %f Hz', iNewTemporalFreq);
		end
        
    case 'ContrastSlider'
		iNewContrast = get(g_strctParadigm.m_strctControllers.m_hContrastSlider, 'value');
		set(g_strctParadigm.m_strctControllers.m_hContrastEdit, 'String', num2str(iNewContrast));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast', iNewContrast);
		fnLog('Setting contrast to %f', iNewContrast);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
        g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'ContrastEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hContrastEdit, 'string');
		iNewContrast = fnMyStr2Num(strTemp);
		if ~isempty(iNewContrast)
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hContrastSlider, iNewContrast);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast', iNewContrast);
			fnLog('Setting contrast to %f', iNewContrast);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
            g_strctParadigm.m_bRedraw = 1;  % redraw the texture in kofiko machine
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end

    case 'OrientationSlider'
		iNewOrientation = get(g_strctParadigm.m_strctControllers.m_hOrientationSlider, 'value');
		set(g_strctParadigm.m_strctControllers.m_hOrientationEdit, 'String', num2str(iNewOrientation));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation', iNewOrientation);
		fnLog('Setting orientation to %f', iNewOrientation);
		
		iCurrentCenterX = g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
		iCurrentCenterY = g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
		iGratingSize = g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
		fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx);
		fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
		fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
		afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);
		fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
	case 'OrientationEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hOrientationEdit, 'string');
		iNewOrientation = fnMyStr2Num(strTemp);
		if ~isempty(iNewOrientation)
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hOrientationSlider, iNewOrientation);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation', iNewOrientation);
			fnLog('Setting orientation to %f', iNewOrientation);
			
			iCurrentCenterX = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterXPix');
			iCurrentCenterY = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingCenterYPix');
			iGratingSize = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'GratingSizePix');
			fSpatialFreq = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'SpatialFreqHz');
			fContrast = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Contrast');
			fOrientation = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'Orientation');
			afBackgroundColor = fnTsGetVar(g_strctParadigm.m_strctStimulusParams, 'BackgroundColor');
			fnParadigmToStimulusServer('Display', [iCurrentCenterX, iCurrentCenterY], iGratingSize, fSpatialFreq, fContrast, fOrientation, afBackgroundColor);
		end

    case 'StimulusOnTimeSlider'
		iNewStimulusOnTime = get(g_strctParadigm.m_strctControllers.m_hStimulusOnTimeSlider, 'value');
		set(g_strctParadigm.m_strctControllers.m_hStimulusOnTimeEdit, 'String', num2str(iNewStimulusOnTime));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'StimulusOnMS', iNewStimulusOnTime);
		fnLog('Setting stimulus on time to %f MS', iNewStimulusOnTime);
	case 'StimulusOnTimeEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hStimulusOnTimeEdit, 'string');
		iNewStimulusOnTime = fnMyStr2Num(strTemp);
		if ~isempty(iNewStimulusOnTime)
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hStimulusOnTimeSlider, iNewStimulusOnTime);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'StimulusOnMS', iNewStimulusOnTime);
			fnLog('Setting stimulus on time to %f MS', iNewStimulusOnTime);
		end
    
    case 'GazeRectSlider'
		iNewGazeRect = round(get(g_strctParadigm.m_strctControllers.m_hGazeRectSlider, 'value'));
		set(g_strctParadigm.m_strctControllers.m_hGazeRectEdit, 'String', num2str(iNewGazeRect));
		g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GazeBoxPix', iNewGazeRect);
		fnLog('Setting gaze box size to %d pix', iNewGazeRect);
	case 'GazeRectEdit'
		strTemp = get(g_strctParadigm.m_strctControllers.m_hGazeRectEdit, 'string');
		iNewGazeRect = fnMyStr2Num(strTemp);
		if ~isempty(iNewGazeRect)
            iNewGazeRect = round(iNewGazeRect);
			fnUpdateSlider(g_strctParadigm.m_strctControllers.m_hGazeRectSlider, iNewGazeRect);
			g_strctParadigm.m_strctStimulusParams = fnTsSetVar(g_strctParadigm.m_strctStimulusParams, 'GazeBoxPix', iNewGazeRect);
			fnLog('Setting gaze box size to %d pix', iNewGazeRect);
		end
	otherwise
		fnParadigmToKofikoComm('DisplayMessage', [strCallback,' not handeled']);
end

return;	
		