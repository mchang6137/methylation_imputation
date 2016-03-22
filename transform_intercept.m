glmimputecopy = glmimpute;
for i=1:length(glmimpute)
    if SampleFull(i) == glmimpute(i)
        continue
    else
        glmimputecopy(i) = (glmimpute(i)-0.07)/0.85;
        if glmimputecopy(i) >= 1
            glmimputecopy(i) = glmimpute(i);
        end
    end
end
