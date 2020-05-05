%Basically, for this procedure you'll need essentially two variables: the
%EEG one (here it's "AZ") and the Sound Signal one (here it's "vec"). The
%length of both must be the same, this is essential for a succesful code
%run.This example works for 6 channels (T7, T8, FT7, TP7, TP8, FT8),
%however, it's easy to modify it to work for any number of channels. I will
%comment on a procedure for T7 channel, as the rest is just the same.
for k = 1:size(AZ,1) %the loop for every channel inside the variable.
T7 = AZ(1,:); %T7 is the first line in the AZ variable, so we pinpoint to it specifically.
t7 = abs(T7); %making EEG signal absolute, just like the Sound Signal is
[cT7, lags_T7]=xcorr(t7,vec,'normalized'); %Cross-correlation between T7 and the sound signal. 'normalized' returns back the common output of correlation within -1 and 1 values.
        CT7 = atanh(cT7); %Fisher transformation needed for the EEG data due to its not-so-normal distribution
        [T7_corr, im_T7]=max(CT7); %max. correlation at the peak and index
        T7_lags=lags_T7(im_T7); %lag at the time of the max. correlation
        T7_new = CT7./max(abs(CT7(:)));%building beautiful plot
        [~,I] = max(abs(CT7)); %this part is specifically based on this lesson and helps to transform the lags into the time difference https://www.mathworks.com/videos/determining-signal-similarities-97063.html)
        timeDiff_T7 = lags_T7(I)/500; %500 refers to frequency used during preprocessing of the data 
        fprintf('Delay EEG T7 by %f mileseconds to match with Speech Envelope\n',timeDiff_T7) 
T8 = AZ(2,:);
t8 = abs(T8); 
[cT8, lags_T8]=xcorr(t8,vec,'normalized'); 
        CT8 = atanh(cT8);
        [T8_corr, im_T8]=max(CT8) ;
        T8_lags=lags_T8(im_T8) ;
        T8_new = CT8./max(abs(CT8(:)));
        [~,I] = max(abs(CT8)); 
        timeDiff_T8 = lags_T8(I)/500;
        fprintf('Delay EEG T8 by %f mileseconds to match with Speech Envelope\n',timeDiff_T8) 
FT7 = AZ(3,:);
ft7 = abs(FT7); 
[cFT7, lags_FT7]=xcorr(ft7,vec,'normalized'); 
        CFT7 = atanh(cFT7);
        [FT7_corr, im_FT7]=max(CFT7) ;
        FT7_lags=lags_FT7(im_FT7) ;
        FT7_new = CFT7./max(abs(FT7(:)));
        [~,I] = max(abs(CFT7)); 
        timeDiff_FT7 = lags_FT7(I)/500;
        fprintf('Delay EEG FT7 by %f mileseconds to match with Speech Envelope\n',timeDiff_FT7) 
TP7 = AZ(4,:);
tp7 = abs(TP7); 
[cTP7, lags_TP7]=xcorr(tp7,vec,'normalized'); 
        CTP7 = atanh(cTP7);
        [TP7_corr, im_TP7]=max(CTP7) ;
        TP7_lags=lags_TP7(im_TP7) ;
        TP7_new = CTP7./max(abs(CTP7(:)));
        [~,I] = max(abs(CTP7)); 
        timeDiff_TP7 = lags_TP7(I)/500;
        fprintf('Delay EEG TP7 by %f mileseconds to match with Speech Envelope\n',timeDiff_TP7) 
TP8 = AZ(5,:);
tp8 = abs(TP8); 
[cTP8, lags_TP8]=xcorr(tp8,vec,'normalized'); 
        CTP8 = atanh(cTP8);
        [TP8_corr, im_TP8]=max(CTP8) ;
        TP8_lags=lags_TP8(im_TP8) ;
        TP8_new = CTP8./max(abs(CTP8(:)));
        [~,I] = max(abs(CTP8)); 
        timeDiff_TP8 = lags_TP8(I)/500;
        fprintf('Delay EEG TP8 by %f mileseconds to match with Speech Envelope\n',timeDiff_TP8) 
FT8 = AZ(6,:);
ft8 = abs(FT8); 
[cFT8, lags_FT8]=xcorr(ft8,vec,'normalized'); 
        CFT8 = atanh(cFT8);
        [FT8_corr, im_FT8]=max(CFT8) ;
        FT8_lags=lags_FT8(im_FT8) ;
        FT8_new = CFT8./max(abs(CFT8(:)));
        [~,I] = max(abs(CFT8)); 
        timeDiff_FT8 = lags_FT8(I)/500;
        fprintf('Delay EEG FT8 by %f mileseconds to match with Speech Envelope\n',timeDiff_FT8) 

end
AZ_CORR= [T7_corr T8_corr FT7_corr TP7_corr TP8_corr FT8_corr]; %storing all received correlation data
AZ_LAGS=[T7_lags T8_lags FT7_lags TP7_lags TP8_lags FT8_lags];
AZ_TIMEDIFF = [timeDiff_T7 timeDiff_T8 timeDiff_FT7 timeDiff_TP7 timeDiff_TP8 timeDiff_FT8];
AZ_INDEX = [im_T7 im_T8 im_FT7 im_TP7 im_TP8 im_FT8];
