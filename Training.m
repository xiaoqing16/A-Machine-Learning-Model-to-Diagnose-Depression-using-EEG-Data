% Import Dataset
dataset = readtable('subjects_information_EEG_3channels_resting_lanzhou_2015.xlsx');
% Remove unused varialbles
dataset = removevars(dataset,{'Var3','Var4','Var5','Var6','Var7','Var8','Var9','Var10','Var11','Var12','Var13'});
% Rename variables
dataset.Properties.VariableNames = {'Subject_ID' 'Type'};
% Convert label into 1 and 0 where 1 is depression and 0 is healthy
dataset.Type = strcmp(dataset.Type,'MDD');

%Import txt file for each into MATLAB and save as data
name= dataset{:,1};
data = cell(size(name));
 for n=1:numel(name)
     txt_file_name = name{n};
     data{n} = readmatrix(txt_file_name); 
     data{n}=data{n}(:,1);
 end
 
% Preprocessing
% Notch Filter
for n=1:numel(name)
    fs=250;
T=1/fs;
t=(0:fs-1)*T;
wo = 50/(250/2); 
bw = wo/60;
[b,a] = iirnotch(wo,bw);
data{n}=filter(b,a,data{n});
end

% Feature Extraction using EEG Feature Extraction Toolbox
% Please download and include the toolbox in your folder before run the file
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

%Create Feature vector and add label
feat(n,1:15) = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,dataset{n,2}];
end

% Feature Selection - Binary Differential Evolution
% Please download and include the function of BDE in your folder before run the file
% Split Data into Feature and Label
Feature = feat(:,1:14);
Label = feat(:,end);

% Set 30% data as validation set for feature selection
ho = 0.3; 
% Hold-out method
HO = cvpartition(Label,'HoldOut',ho,'Stratify',false);
% Binary Differential Evolution
[sFeat,Sf,Nf,curve] = jBDE(Feature,Label,5,100,0.9,HO);
% Remove Unselected Features
feats = horzcat(feat(:,Sf),feat(:,end));

% Split data into testing set and training set
[m,n] = size(feats) ;
P = 0.75 ;
rng(1,'philox');
s = rng;
idx = randperm(m)  ;
data_tr = feats(idx(1:round(P*m)),:); 
data_ts = feats(idx(round(P*m)+1:end),:);
% Split dataset into Feature and Label
Feature_tr = data_tr(:,1:n-1);
Label_tr = data_tr(:,end);
Feature_ts = data_ts(:,1:n-1);
Label_ts = data_ts(:,end);

% Classification

% Train the model
SVMModel = fitcsvm(Feature_tr,Label_tr,'KernelFunction','rbf',...
             'Standardize',true,'ClassNames',{'1','0'});

%Cross Validation
partitionedModel = crossval(SVMModel,'KFold',10);
Accuracy = 1-loss(SVMModel,Feature_ts,Label_ts);





