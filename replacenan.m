AllSamplescleared = [];
for i = 1:33
    Sample_i = AllSamples(:,i);
    for j = 1:length(Sample_i)
        if isnan(Sample_i(j))
           Sample_i(j) = 0;
        end
    end
    AllSamplescleared = [AllSamplescleared Sample_i];         
end
