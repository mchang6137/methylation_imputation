beta_a_b = zeros(33,2);
ci_a = zeros(33,2);
ci_b = zeros(33,2);

for i = 1:33
    [p,ci] = betafit(AllSamples(:,i));
    beta_a_b(i,1) = p(1);
    beta_a_b(i,2) = p(2);
    ci_a(i,1) = ci(1,1);
    ci_a(i,2) = ci(1,2);
    ci_b(i,1) = ci(2,1);
    ci_b(i,2) = ci(2,2);
end
    
    