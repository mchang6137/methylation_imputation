bpsize = 1000;
partialimputepd = [];
pd = fitdist(reshape(AllSamples_no2627(1:40,1:31),31*80,1),'Kernel','Kernel','epanechnikov', 'Support', [0,1]);
pdprev = pd;
for j = 1:length(Partial)-1
    if (isnan(Partial(j)) && PartialSampled(j) == 0)
        % get all rows +/- 1000bp
        windowbegin = SiteBegin(j,1);
        idx = 0;
        idxback = 0;
        while (SiteBegin(j+idx,1) < windowbegin + bpsize)
            idx = idx+1;
            if j+idx >= length(Partial)
                break;
            end
        end
        while (j-idxback > 1 && SiteBegin(j-idxback,1) > windowbegin - bpsize)
            idxback = idxback + 1;
        end
        % fit gev
        if (idx+idxback < 10)
            pd = pdprev;
        else
            section = reshape(AllSamples_no2627(j-idxback:j+idx,1:31),31*(idx+idxback+1),1);
            pd = fitdist(section,'Kernel','Kernel','epanechnikov','Support', [0,1], 'Bandwidth',0.01);
            pdprev = pd;
        end
        % impute
        imputevalue = random(pd);
        partialimputepd = [partialimputepd imputevalue];
    elseif (~isnan(Partial(j)))
        partialimputepd = [partialimputepd Partial(j)];
    else
        partialimputepd = [partialimputepd NaN];
    end
    if mod(j, 100000) == 0
        disp(j);
    end
end
partialimputepd = transpose(partialimputepd);
save('partialimputepd.mat', 'partialimputepd');
disp('done');
