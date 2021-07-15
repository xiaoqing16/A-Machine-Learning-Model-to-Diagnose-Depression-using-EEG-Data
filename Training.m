cd 'C:\Users\User\Documents\MATLAB\EEG_3channels_resting_lanzhou_2015'
dataset = readtable('subjects_information_EEG_3channels_resting_lanzhou_2015.xlsx');

%Import Dataset
dataset = removevars(dataset,{'Var3','Var4','Var5','Var6','Var7','Var8','Var9','Var10','Var11','Var12','Var13'});
dataset.Properties.VariableNames = {'Subject_ID' 'Type'};
%Convert categorical data into Binary
dataset.Type = strcmp(dataset.Type,'MDD');

%Import txt into MATLAB
name= dataset{:,1};
data = cell(size(name));
 for n=1:numel(name)
     txt_file_name = name{n};
     data{n} = readmatrix(txt_file_name); 
     data{n}=data{n}(:,1);
 end
 
%Preprocessing
for n=1:numel(name)
    fs=250;
% Notch Filter
T=1/fs;
t=(0:fs-1)*T;
wo = 50/(250/2); 
bw = wo/60;
[b,a] = iirnotch(wo,bw);
data{n}=filter(b,a,data{n});
end

%Feature Extraction
feat = zeros(55,14);
for n=1:numel(name)
X = data{n};
opts.fs = 250;
% Hjorth Activity
f1 = jfeeg('ha', X); 

% Hjorth Mobility
f2 = jfeeg('hm', X); 

% Hjorth Complexity
f3 = jfeeg('hc', X);

% Band Power Alpha
f4 = jfeeg('bpa', X, opts);

% Band Power Beta
f5 = jfeeg('bpb',X,opts);

% Band Power Theta
f6 = jfeeg('bpt',X,opts);

% Band Power Delta
f7 = jfeeg('bpd',X,opts);

% Band Power Gamma
f8 = jfeeg('bpg',X,opts);

% Standard Deviation
f9 = jfeeg('sd',X);

% Median
f10 = jfeeg('md',X);

% Maximum
f11 = jfeeg('max',X);

% Minimum
f12 = jfeeg('min',X);

% Skewness
f13 = jfeeg('skew',X);

% Kurtosis
f14 = jfeeg('kurt',X);

%Create Feature vector and Add Label
feat(n,1:15) = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,dataset{n,2}];
end

% Feature Selection
% Split Data into Feature and Label
Feature = feat(:,1:14);
Label = feat(:,end);
% Set 30% data as validation set for feature selection
ho = 0.3; 
% Hold-out method
HO = cvpartition(Label,'HoldOut',ho,'Stratify',false);
% Binary Differential Evolution
[sFeat,Sf,Nf,curve] = jBDE(Feature,Label,5,100,0.9,HO);
%Delete Unselected Feature
feats = horzcat(feat(:,Sf),feat(:,end));

% Split data into testing and training
[m,n] = size(feats) ;
P = 0.75 ;
rng(1,'philox');
s = rng;
idx = randperm(m)  ;
data_tr = feats(idx(1:round(P*m)),:); 
data_ts = feats(idx(round(P*m)+1:end),:);
Feature_tr = data_tr(:,1:n-1);
Label_tr = data_tr(:,end);
Feature_ts = data_ts(:,1:n-1);
Label_ts = data_ts(:,end);

% Classification
%Train
SVMModel = fitcsvm(Feature_tr,Label_tr,'KernelFunction','rbf',...
             'Standardize',true,'ClassNames',{'1','0'});

%Cross Validation
partitionedModel = crossval(SVMModel,'KFold',10);
Accuracy = 1-loss(SVMModel,Feature_ts,Label_ts);





