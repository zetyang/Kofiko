f = 0.1;
afBackgroundColor = [255 0 0];
iGratingSize = 200;

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
iCurrentCenterX = 900;
iCurrentCenterY = 400;
fContrast = 1;
angle = 0;
timefreq = 10;
StimulusOnTime = 5000;

w = Screen('OpenWindow', screenNumber, afBackgroundColor);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

gray = round((white + black) / 2);
if gray == white
   gray = white / 2;
end
inc = fContrast*(white - gray);
p = ceil(1/f);
fr = f*2*pi;
x = meshgrid(0:iGratingSize+p+1, 1);
grating = gray + inc*sin(fr*x);
gratingtex = Screen('MakeTexture', w, grating);
		
mask = ones(iGratingSize, iGratingSize, 4);
mask(:,:,1) = afBackgroundColor(1);
mask(:,:,2) = afBackgroundColor(2);
mask(:,:,3) = afBackgroundColor(3);
[x, y] = meshgrid(1:iGratingSize, 1:iGratingSize);
center = (iGratingSize+1) / 2;
mask(:, :, 4) = white * (1-((x-center).^2 + (y-center).^2 <= center^2));
masktex = Screen('MakeTexture', w, mask);
        
maskSrcRect = [0 0 iGratingSize iGratingSize];
dstRect =  CenterRectOnPoint(maskSrcRect, iCurrentCenterX, iCurrentCenterY);


stimulusOn = GetSecs();
p = 1 / f;
duration = 0;
timeperiod = 1 / timefreq;
while (duration) < (StimulusOnTime / 1000)
    offset = mod(duration*timefreq*p, p);
    srcRect = [offset 0 iGratingSize+offset iGratingSize];
    Screen('DrawTexture', w, gratingtex, srcRect, dstRect, angle);
    Screen('DrawTexture', w, masktex, maskSrcRect, dstRect);
    Screen('Flip', w);
    duration = GetSecs() - stimulusOn;
end

Screen('CloseAll');