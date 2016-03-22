glmimpute = [];
for i = 1:length(Partial)
    if isnan(Partial(i))
        ypred = predict(glmstep,newglm(i,1:end));
        glmimpute = [glmimpute ypred];
    else
        glmimpute = [glmimpute Partial(i)];
    end
    if mod(i,100000) == 0
        disp(i);
    end
end
glmimpute = transpose(glmimpute);
save('imputeglm.mat','glmimpute');
disp('done');
        