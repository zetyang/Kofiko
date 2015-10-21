function fnParadigmDriftGratingCleanTextureMemory()
global  g_strctParadigm

if isfield(g_strctParadigm, 'm_gratingtex') && ~isempty(g_strctParadigm.m_gratingtex)
    Screen('Close', g_strctParadigm.m_gratingtex);
    rmfield(g_strctParadigm, 'm_gratingtex');
end

if isfield(g_strctParadigm, 'm_masktex') && ~isempty(g_strctParadigm.m_masktex)
    Screen('Close', g_strctParadigm.m_masktex);
    rmfield(g_strctParadigm, 'm_masktex');
end

return;