function fnParadigmDriftGratingDrawCycle(acInputFromKofiko)

global g_strctPTB g_strctDraw g_strctNet g_strctServerCycle g_bPhotoDiodeToggle

if ~isempty(acInputFromKofiko)
	strCommand = acInputFromKofiko{1};
	switch strCommand
		case 'Display'  % display static gratings
			g_strctDraw.m_pt2iCenter = acInputFromKofiko{2};
			g_strctDraw.m_fSize = acInputFromKofiko{3};
			g_strctDraw.m_fSpatialFreq = acInputFromKofiko{4};
			g_strctDraw.m_fContrast = acInputFromKofiko{5};
			g_strctDraw.m_fOrientation = acInputFromKofiko{6};
			g_strctDraw.m_afBackgroundColor = acInputFromKofiko{7};
			g_strctServerCycle.m_iMachineState = 1;
		case 'Drift' % show drifting gratings
			g_strctDraw.m_pt2iCenter = acInputFromKofiko{2};
			g_strctDraw.m_fSize = acInputFromKofiko{3};
			g_strctDraw.m_fSpatialFreq = acInputFromKofiko{4};
			g_strctDraw.m_fTempFreq = acInputFromKofiko{5};
			g_strctDraw.m_fContrast = acInputFromKofiko{6};
			g_strctDraw.m_fOrientation = acInputFromKofiko{7};
			g_strctDraw.m_iStimulusOnTime = acInputFromKofiko{8};
			g_strctDraw.m_afBackgroundColor = acInputFromKofiko{9};
			g_strctServerCycle.m_iMachineState = 2;
	end
end

switch g_strctServerCycle.m_iMachineState
	case 0 % do nothing
	case 1 % display static gratings (for previewing the true moving gratings)       
        gray = 255 / 2;
        inc = g_strctDraw.m_fContrast * gray;
        p = ceil(1/g_strctDraw.m_fSpatialFreq);
        fr = g_strctDraw.m_fSpatialFreq*2*pi;
        x = meshgrid(0:g_strctDraw.m_fSize+p+1, 1);
        grating = gray + inc*sin(fr*x);
        gratingtex = Screen('MakeTexture', g_strctPTB.m_hWindow, grating);
        mask = ones(g_strctDraw.m_fSize, g_strctDraw.m_fSize, 4);
        mask(:,:,1) = g_strctDraw.m_afBackgroundColor(1);
        mask(:,:,2) = g_strctDraw.m_afBackgroundColor(2);
        mask(:,:,3) = g_strctDraw.m_afBackgroundColor(3);
        [x, y] = meshgrid(1:g_strctDraw.m_fSize, 1:g_strctDraw.m_fSize);
        center = (g_strctDraw.m_fSize+1) / 2;
        mask(:, :, 4) = 255 * (1-((x-center).^2 + (y-center).^2 <= center^2));
        masktex = Screen('MakeTexture', g_strctPTB.m_hWindow, mask);    
        srcRect = [0 0 g_strctDraw.m_fSize g_strctDraw.m_fSize];
        dstRect =  CenterRectOnPoint(srcRect, g_strctDraw.m_pt2iCenter(1), g_strctDraw.m_pt2iCenter(2));
        
        Screen('FillRect', g_strctPTB.m_hWindow, g_strctDraw.m_afBackgroundColor, g_strctPTB.m_aiRect);
        Screen('DrawTexture', g_strctPTB.m_hWindow, gratingtex, srcRect, dstRect, g_strctDraw.m_fOrientation);
        Screen('DrawTexture', g_strctPTB.m_hWindow, masktex, srcRect, dstRect, g_strctDraw.m_fOrientation);
        g_strctServerCycle.m_fLastFlipTime = fnFlipWrapper(g_strctPTB.m_hWindow);
        g_strctServerCycle.m_iMachineState = 0;
	case 2
        gray = 255 / 2;
        inc = g_strctDraw.m_fContrast * gray;
        p = ceil(1/g_strctDraw.m_fSpatialFreq);
        fr = g_strctDraw.m_fSpatialFreq*2*pi;
        x = meshgrid(0:g_strctDraw.m_fSize+p+1, 1);
        grating = gray + inc*sin(fr*x);
        gratingtex = Screen('MakeTexture', g_strctPTB.m_hWindow, grating);
        mask = ones(g_strctDraw.m_fSize, g_strctDraw.m_fSize, 4);
        mask(:,:,1) = g_strctDraw.m_afBackgroundColor(1);
        mask(:,:,2) = g_strctDraw.m_afBackgroundColor(2);
        mask(:,:,3) = g_strctDraw.m_afBackgroundColor(3);
        [x, y] = meshgrid(1:g_strctDraw.m_fSize, 1:g_strctDraw.m_fSize);
        center = (g_strctDraw.m_fSize+1) / 2;
        mask(:, :, 4) = 255 * (1-((x-center).^2 + (y-center).^2 <= center^2));
        masktex = Screen('MakeTexture', g_strctPTB.m_hWindow, mask);    
        maskSrcRect = [0 0 g_strctDraw.m_fSize g_strctDraw.m_fSize];
        dstRect =  CenterRectOnPoint(maskSrcRect, g_strctDraw.m_pt2iCenter(1), g_strctDraw.m_pt2iCenter(2));
        
        Screen('FillRect', g_strctPTB.m_hWindow, g_strctDraw.m_afBackgroundColor, g_strctPTB.m_aiRect);
        

               
        ifi = Screen('GetFlipInterval', g_strctPTB.m_hWindow);
        p = 1 / g_strctDraw.m_fSpatialFreq;
        shiftPerFlip = g_strctDraw.m_fTempFreq * ifi * p;
        vbl = fnFlipWrapper(g_strctPTB.m_hWindow);
        vblendtime = vbl + g_strctDraw.m_iStimulusOnTime/1000;
        i = 0;
        while(vbl < vblendtime)
            xoffset = mod(i*shiftPerFlip, p);
            i = i+1;
            srcRect = [xoffset 0 xoffset+g_strctDraw.m_fSize g_strctDraw.m_fSize];
            Screen('DrawTexture', g_strctPTB.m_hWindow, gratingtex, srcRect, dstRect, g_strctDraw.m_fOrientation);
            Screen('DrawTexture', g_strctPTB.m_hWindow, masktex, maskSrcRect, dstRect, g_strctDraw.m_fOrientation);
            %draw the PhoteDiode
            if ~isempty(g_bPhotoDiodeToggle)
                iPhotoDiodeSize = 50;
                if g_bPhotoDiodeToggle
                    Screen('FillRect', g_strctPTB.m_hWindow, [255 255 255], [0, 0, iPhotoDiodeSize, iPhotoDiodeSize]);
                else
                    Screen('FillRect', g_strctPTB.m_hWindow, [0, 0, 0], [0, 0, iPhotoDiodeSize, iPhotoDiodeSize]);
                end
            end
            vbl = Screen('Flip', g_strctPTB.m_hWindow, vbl+0.5*ifi);
        end
		vbl = fnFlipWrapper(g_strctPTB.m_hWindow, vbl+0.5*ifi);
        g_strctServerCycle.m_fLastFlipTime = vbl;
        g_strctServerCycle.m_iMachineState = 0;
end

return