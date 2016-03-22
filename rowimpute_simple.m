partialimputepd = [];
for j = 1:length(Partial)-1
    if (isnan(Partial(j)) && PartialSampled(j) == 0)
        % get all rows +/- 1000bp
        if(j > 2 && j < length(Sample_i)-2)
            section = reshape(AllSamples_no2627(j-2:j+2,1:31),31*5,1);
            pd = fitdist(section,'Kernel','Kernel','epanechnikov','Support', [0,1], 'Bandwidth',0.01);
        elseif (j <= 2)
            section = reshape(AllSamples_no2627(j:j+2,1:31),31*3,1);
            pd = fitdist(section,'Kernel','Kernel','epanechnikov','Support', [0,1], 'Bandwidth',0.01);
        elseif (j >= length(Sample_i)-2)
            section = reshape(AllSamples_no2627(j-2:j,1:31),31*3,1);
            pd = fitdist(section,'Kernel','Kernel','epanechnikov','Support', [0,1], 'Bandwidth',0.01);
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
