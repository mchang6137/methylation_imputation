all_cossim = [];
newglmShort = [];
for i = 1:8
    Sample_i = newglm(:,i);
    Sample_i(isnan(Sample_i))=0;
    shortsample = Sample_i(IsSampled == 1);
    newglmShort = [newglmShort shortsample];
    %cossim = dot(shortsample,onlysampled)/norm(shortsample)/norm(onlysampled);
    %r = corrcoef(shortsample,onlysampled);
    %all_cossim = [all_cossim cossim];
end
    