newglm = [];
for i=1:length(Sample1)
    if i == 7 || i == 9 || i == 20 || i == 21 || i == 22 || i == 23 || i == 25  || i == 30
        newglm = [newglm AllSamplesimpute(:,i)];
    end
end
    