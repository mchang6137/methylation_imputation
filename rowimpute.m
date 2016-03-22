bpsize = 1000;
partialimpute = [];
phat = gevfit(reshape(AllSamples_no2627(1:80,1:31),31*80,1));
phatprev = phat;
for j = 1:length(Partial)
    if (isnan(Partial(j)) && PartialSampled(j) == 0)
        % get all rows +/- 400bp
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
        if (idx+idxback < 40)
            phat = phatprev;
        else
            [phat,pci] = gevfit(reshape(AllSamples_no2627(j-idxback:j+idx,1:31),31*(idx+idxback+1),1),0.05,options);
            phatprev = phat;
        end
        % impute
        imputevalue = gevrnd(phat(1),phat(2),phat(3));
        partialimpute = [partialimpute imputevalue];
    elseif (~isnan(Partial(j)))
        partialimpute = [partialimpute Partial(j)];
    else
        partialimpute = [partialimpute NaN];
    end
    if mod(j, 10000) == 0
        disp(j);
    end
end
partialimpute = transpose(partialimpute);
save('partialimpute.mat', 'partialimpute');
disp('done');
