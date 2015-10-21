function DriftGrating(angle, cyclespersecond, f, drawmask, gratingsize)

if nargin < 5
    gratingsize = [];
end

if isempty(gratingsize)
    gratingsize = 400;
end

if nargin < 4
    drawmask = [];
end

if isempty(drawmask)
    drawmask = 1;
end

if nargin < 3
    f = [];
end

if isempty(f)
    f = 0.05;
end

if nargin < 2
    cyclespersecond = [];
end

if isempty(cyclespersecond)
    cyclespersecond = 1;
end

if nargin < 1
    angle = [];
end

if isempty(angle)
    angle = 30;
end

movieDurationSecs = 20;

texsize = gratingsize / 2;

try
    AssertOpenGL;
    screens = Screen('Screens');
    screenNumber = max(screens);
    
    white = WhiteIndex(screenNumber)
    black = BlackIndex(screenNumber)
    
    gray = round((white + black) / 2);
    
    if gray == white
        gray = white / 2;
    end
    
    inc = white - gray;
    
    [w screenRect] = Screen('OpenWindow', screenNumber, gray);
    
    if drawmask
        Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    end
    
    p = ceil(1/f);
    fr = f*2*pi;
    visiblesize = 2*texsize+1;
    
    x = meshgrid(-texsize:texsize + p, 1);
    grating = gray + inc*cos(fr*x);
    gratingtex = Screen('MakeTexture', w, grating);
    
    mask = ones(2*texsize+1, 2*texsize+1, 2)*gray;
    [x,y] = meshgrid(-1*texsize:1*texsize, -1*texsize:texsize);
    mask(:,:,2) = white * (1 - exp(-((x/90).^2)-((y/90).^2)));
    masktex = Screen('MakeTexture', w, mask);
    
    priorityLevel = MaxPriority(w);
    
    dstRect = [0 0 visiblesize visiblesize];
    dstRect = CenterRect(dstRect, screenRect);
    
    ifi = Screen('GetFlipInterval', w);
    waitframes = 1;
    waitduration = waitframes * ifi;
    p = 1/f;
    shiftperframe = cyclespersecond * p * waitduration;
    
    vbl = Screen('Flip', w);
    
    vblendtime = vbl + movieDurationSecs;
    i = 0;
    
    while(vbl < vblendtime)
        xoffset = mod(i*shiftperframe, p);
        i = i+1;
        srcRect = [xoffset 0 xoffset+visiblesize visiblesize];
        
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, angle);
        
        if drawmask == 1
            Screen('DrawTexture', w, masktex, [0 0 visiblesize visiblesize], dstRect, angle)
        end;
        
        vbl = Screen('Flip', w, vbl+(waitframes - 0.5) * ifi);
        
        if KbCheck
            break;
        end;
    end;
    
    Priority(0);
    Screen('CloseAll');
catch
    Screen('CloseAll');
    Priority(0);
    psychrethrow(psychlasterror);
end

return;
        
    
    
    