Machine Learning Model to Diagnose Depression

This is a model I built for my capstone project.

The dataset is the EEG_3channels_resting_lanzhou_2015 from http://modma.lzu.edu.cn/

The algorithms used in the model are:
Data preprocessing: Notch Filter

Data Extraction: EEG Feature Extraction Toolbox (Toolbox from Mr. Too Jing Wei, https://github.com/JingweiToo/EEG-Feature-Extraction-Toolbox)

Data Selection : Binary Differential Evolution (Code from Mr. Too Jing Wei, https://github.com/JingweiToo/Binary-Differential-Evolution-for-Feature-Selection)

Classification: Support Vector Machine

Vaidation: 10-Fold Cross Validation
 
  
  

File Details:

Training.m is the code to train the model

Testing.m is the code to predict new data

Preprocess_Feature.m, Extract_Function.m, Result_Feataure.m are the feature will be used in Training.m

SVM.mat is the data file of the trained model
