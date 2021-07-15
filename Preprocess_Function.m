function CleanData = preprocess(Data)
%Low Pass Filter
Data = lowpass(Data,64,512);
Data = downsample(Data,2);
% Notch Filter
Fs = 256;
wo = 50/(256/2); 
bw = wo/60;
[b,a] = iirnotch(wo,bw);
CleanData =filter(b,a,Data);
end