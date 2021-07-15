function result1= textfile(result)
%Save Result and Display Result
f1 = "Dear user,";
f2 = "Thank you for taking the depression test on Helios."; 
f4 = "Do take note that the result is not 100% accurate.";
f5 = "If you are facing any medical difficulty, please seek help from medical personnel.";
f6 = "Stay Safe and Thank You.";
f7 = "Sincerely,";
f8 = "Team Helios";
save("Result.txt");
fileid = fopen('Result.txt','wt');
if (result == 1)
        disp("The user is under the DEPRESSION category");
        f3 = "Based on your current result, you are in the DEPRESSION category.";  
        f9 = "You may take a Simple Self-Test Depression Scale(PHQ-9) that is available in the application to judge the level of depression.";
        fprintf(fileid,'%s\n\n%s\n%s\n\n%s\n%s\n\n%s\n\n%s\n\n%s\n%s', f1,f2,f3,f4,f5,f9,f6,f7,f8);
end
if (result == 0)
        disp("The user is under the HEALTHY category");
        f3= "Based on your current result, you are in the HEALTHY category.";
        fprintf(fileid,'%s\n\n%s\n%s\n\n%s\n%s\n\n%s\n\n%s\n%s%s', f1,f2,f3,f4,f5,f6,f7,f8);
end

fclose(fileid);
result1 = 2;
end
