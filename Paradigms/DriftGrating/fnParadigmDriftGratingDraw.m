function fnParadigmDriftGratingDraw()

global g_strctPTB g_strctParadigm

iCurrentCenterX = g_strctPTB.m_fScale * g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterXPix.BufferIdx);
iCurrentCenterY = g_strctPTB.m_fScale * g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingCenterYPix.BufferIdx);
iGratingSize = g_strctPTB.m_fScale * g_strctParadigm.m_strctStimulusParams.GratingSizePix.Buffer(g_strctParadigm.m_strctStimulusParams.GratingSizePix.BufferIdx);
fSpatialFreq = g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.SpatialFreqHz.BufferIdx)/g_strctPTB.m_fScale;
fTempFreq = g_strctParadigm.m_strctStimulusParams.TempFreqHz.Buffer(g_strctParadigm.m_strctStimulusParams.TempFreqHz.BufferIdx);
fContrast = g_strctParadigm.m_strctStimulusParams.Contrast.Buffer(g_strctParadigm.m_strctStimulusParams.Contrast.BufferIdx);
fOrientation = g_strctParadigm.m_strctStimulusParams.Orientation.Buffer(g_strctParadigm.m_strctStimulusParams.Orientation.BufferIdx);
iStimulusOnTime = g_strctParadigm.m_strctStimulusParams.StimulusOnMS.Buffer(g_strctParadigm.m_strctStimulusParams.StimulusOnMS.BufferIdx);
afBackgroundColor = g_strctParadigm.m_strctStimulusParams.BackgroundColor.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.BackgroundColor.BufferIdx);

Screen('FillRect', g_strctPTB.m_hWindow, afBackgroundColor, g_strctPTB.m_aiRect);

if g_strctParadigm.m_bRedraw
    if isfield(g_strctParadigm, 'm_gratingtex') && ~isempty(g_strctParadigm.m_gratingtex)
        Screen('Close', g_strctParadigm.m_gratingtex);
    end
    if isfield(g_strctParadigm, 'm_masktex') && ~isempty(g_strctParadigm.m_masktex)
        Screen('Close', g_strctParadigm.m_masktex);
    end
    
    gray = 255 / 2;
    inc = fContrast * gray;
    p = ceil(1/fSpatialFreq);
    fr = fSpatialFreq*2*pi;
    x = meshgrid(0:iGratingSize+p+1, 1);
    grating = gray + inc*sin(fr*x);
    g_strctParadigm.m_gratingtex = Screen('MakeTexture', g_strctPTB.m_hWindow, grating);
		
    mask = ones(iGratingSize, iGratingSize, 4);
    mask(:,:,1) = afBackgroundColor(1);
    mask(:,:,2) = afBackgroundColor(2);
    mask(:,:,3) = afBackgroundColor(3);
    [x, y] = meshgrid(1:iGratingSize, 1:iGratingSize);
    center = (iGratingSize+1) / 2;
    mask(:, :, 4) = 255 * (1-((x-center).^2 + (y-center).^2 <= center^2));
    g_strctParadigm.m_masktex = Screen('MakeTexture', g_strctPTB.m_hWindow, mask);
    
    g_strctParadigm.m_bRedraw = 0;
end

switch g_strctParadigm.m_iMachineState
	case 0 % just draw a static grating       
        srcRect = [0 0 iGratingSize iGratingSize];
        dstRect =  CenterRectOnPoint(srcRect, iCurrentCenterX, iCurrentCenterY);
        Screen('DrawTexture', g_strctPTB.m_hWindow, g_strctParadigm.m_gratingtex, srcRect, dstRect, fOrientation);
        Screen('DrawTexture', g_strctPTB.m_hWindow, g_strctParadigm.m_masktex, srcRect, dstRect);	
	case {1, 2} % drifting gratings
        maskSrcRect = [0 0 iGratingSize iGratingSize];
        dstRect =  CenterRectOnPoint(maskSrcRect, iCurrentCenterX, iCurrentCenterY);
        stimulusOn = GetSecs();
        p = 1 / fSpatialFreq;
        duration = 0;
        while duration < iStimulusOnTime/1000
            offset = mod(duration*fTempFreq*p, p);
            srcRect = [offset 0 iGratingSize+offset iGratingSize];
            Screen('DrawTexture', g_strctPTB.m_hWindow, g_strctParadigm.m_gratingtex, srcRect, dstRect, fOrientation);
            Screen('DrawTexture', g_strctPTB.m_hWindow, g_strctParadigm.m_masktex, maskSrcRect, dstRect);
            Screen('Flip', g_strctPTB.m_hWindow);
            duration = GetSecs() - stimulusOn;
        end        
end

return;