cd 'C:\Users\User\Desktop\Demo'
%load Test data
filename = uigetfile('*.txt*');
Data = load(filename);
Data = Data(:,1);

%Preprocessing
CleanData = preprocess(Data);

%Feature Extraction
features = extract(CleanData);
    
%Predict result
mdl = loadLearnerForCoder('SVM.mat'); 
result = predict(mdl,features);  
textfile = textfile(result);




