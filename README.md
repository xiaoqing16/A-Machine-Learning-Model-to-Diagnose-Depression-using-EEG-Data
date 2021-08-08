# A Machine Learning Model to Diagnose Depression
This model is built for my capstone project, "A Mobile Application to Diagnose Mild Depression". The project is amied to build a mobile application to diagnose depression with the aids of **Electroencephalography, EEG** and **Machine Learning**.<br />
[Here is the presentation slide for the capstone project.](https://docs.google.com/presentation/d/1hlXZmtGES1h9QgD5NXM2zmtDWGdyMEkAnQunmUfV8Hw/edit?usp=sharing
)

## Requirements
- MATLAB R2020a
- Signal Processing Toolbox from MATLAB
- [EEG Feature Extraction Toolbox](https://github.com/JingweiToo/EEG-Feature-Extraction-Toolbox) from Mr. Too Jing Wei
- [Binary Differential Evolution](https://github.com/JingweiToo/Binary-Differential-Evolution-for-Feature-Selection) from Mr. Too Jing Wei

## Dataset
The dataset, [EEG_3channels_resting_lanzhou_2015](http://modma.lzu.edu.cn/) is provided by Gansu Provincial Key Laboratory of Wearable Computing from Lanzhou University, China.

## Algorithms used 
- Data preprocessing: Notch Filter
- Feature Extraction: [EEG Feature Extraction Toolbox](https://github.com/JingweiToo/EEG-Feature-Extraction-Toolbox)
- Feature Selection : [Binary Differential Evolution](https://github.com/JingweiToo/Binary-Differential-Evolution-for-Feature-Selection)
- Classification: Support Vector Machine
- Vaidation: 10-Fold Cross Validation
 
## Result
The accuracy of the model is only 68.67%. One of the reason of low accuracy is the dataset is too small as it only have total 55 data where 26 depression patients and 28 healthy controls.

## File Details
- main.m is the code to train the model.
- predict.m is the code to predict new data
- SVM.mat is the data file of the trained model

## Credits
This model uses Open Source components. You can find the source code of the open source projects. I acknowledge and am grateful to [Mr.Too Jing Wei](https://github.com/JingweiToo] for his contributions to open source.

Project: [Electroencephalogram ( EEG ) Feature Extraction Toolbox](https://github.com/JingweiToo/EEG-Feature-Extraction-Toolbox)<br />
Copyright (c) 2020, Jingwei Too <br />
All rights reserved.<br />
[BSD 3-Clause License](https://github.com/JingweiToo/EEG-Feature-Extraction-Toolbox/blob/main/LICENSE)

Project: [Binary Differential Evolution for Feature Selection](https://github.com/JingweiToo/Binary-Differential-Evolution-for-Feature-Selection)<br />
Copyright (c) 2020, Jingwei Too <br />
All rights reserved. <br />
[BSD 3-Clause License](https://github.com/JingweiToo/Binary-Differential-Evolution-for-Feature-Selection/blob/master/LICENSE)
