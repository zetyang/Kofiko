function fnParadigmDriftGratingParadigmSwitch(strEvent)

global g_strctParadigm

switch strEvent
    case 'Init'
        fnParadigmToKofikoComm('SetFixationPosition',...
            g_strctParadigm.m_strctStimulusParams.FixationSpotPix.Buffer(1,:,g_strctParadigm.m_strctStimulusParams.FixationSpotPix.BufferIdx));
    case 'Close'
end
return;