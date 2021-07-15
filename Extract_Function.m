function features = extract(CleanData)
%Feature Extraction
features = zeros(1,5); 
% Band Power Alpha
    % Parameters
    Fs = 256;
    fs = 256;
    f_low  = 8;      % 8 Hz
    f_high = 12;     % 12 Hz
    % sampling frequency 
    if isfield(Fs,'fs'), fs = Fs; end
    % Band power 
    BPA = bandpower(CleanData, fs, [f_low f_high]);
% Band Power Beta
    % Parameters         
    f_low  = 12;      % 12 Hz
    f_high = 30;      % 30 Hz
    % sampling frequency 
    if isfield(fs,'fs'), fs = Fs; end
    % Band power 
    BPB = bandpower(CleanData, fs, [f_low f_high]);
% Standard Deviation
    N  = length(CleanData); 
    mu = mean(CleanData); 
    SD = sqrt((1 / (N - 1)) * sum((CleanData - mu) .^ 2));
% Median
    Med = median(CleanData);
% Skewness
    SKEW = skewness(CleanData);
%Feature    
    features(1,1:5) = [BPA,BPB,SD,Med,SKEW];
end