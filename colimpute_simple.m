windowsize = 50;
AllSamplesimpute = [];
for i = 1:33
    Sample_i = AllSamples(:,i);
    if i == 27
        Sample_i = zeros(length(AllSamples(:,i)),1);
    end
    for j = 1:length(Sample_i)-1
        if (isnan(Sample_i(j,1)))
            if(j > 50 && j < length(Sample_i)-50)
                phat = betafit(Sample_i(j-windowsize:j+windowsize));
            elseif (j <= 50)
                phat = betafit(Sample_i(1:j+windowsize));
            elseif (j >= length(Sample_i)-50)
                phat = betafit(Sample_i(j-windowsize:end));
            end
            Sample_i(j,1) = betarnd(phat(1),phat(2));
        end
        if mod(j, 100000) == 0
            disp(i);
            disp(j);
        end
    end
    AllSamplesimpute = [AllSamplesimpute Sample_i];
end
