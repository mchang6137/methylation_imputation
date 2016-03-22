bpsize = 400;
AllSamplesimpute = [];
for i = 1:33
    Sample_i = AllSamples(:,i);
    if i == 27
        Sample_i = zeros(length(AllSamples(:,i)),1);
    end
    for j = 1:gap
        windowbegin = SiteBegin(j,1);
        idx = 0;
        idxback = 0;
        nanarray = [];
        while (isnan(Sample_i(j+idx,1)) | SiteBegin(j+idx,1) < windowbegin + bpsize)
            idx = idx+1;
            if j+idx >= gap
                break;
            elseif isnan(Sample_i(j+idx,1))
                nanarray(end+1) = j+idx;
            end
        end
        while (j-idxback > 1 & SiteBegin(j-idxback,1) > windowbegin - bpsize)
            idxback = idxback + 1;
        end 
        meanvalue = nanmean(Sample_i(j-idxback:j+idx));
        if ~isnan(meanvalue)
            lastmean = meanvalue;
        end
        for k = 1:length(nanarray)
            if ~isnan(meanvalue)
                Sample_i(nanarray(k),1) = meanvalue;
            else
                Sample_i(nanarray(k),1) = lastmean;
            end
        end
    end
    for j = gap+1:length(Sample_i)-1
        windowbegin = SiteBegin(j,1);
        idx = 0;
        idxback = 0;
        nanarray = [];
        while (isnan(Sample_i(j+idx,1)) | SiteBegin(j+idx,1) < windowbegin + bpsize)
            idx = idx+1;
            if j+idx >= length(Sample_i)
                break;
            elseif isnan(Sample_i(j+idx,1))
                nanarray(end+1) = j+idx;
            end
        end
        while (j-idxback > 1 & SiteBegin(j-idxback,1) > windowbegin - bpsize)
            idxback = idxback + 1;
        end
        meanvalue = nanmean(Sample_i(j-idxback:j+idx));
        if ~isnan(meanvalue)
            lastmean = meanvalue;
        end
        for k = 1:length(nanarray)
            if ~isnan(meanvalue)
                Sample_i(nanarray(k),1) = meanvalue;
            else
                Sample_i(nanarray(k),1) = lastmean;
            end
        end
    end
    AllSamplesimpute = [AllSamplesimpute Sample_i];
end
