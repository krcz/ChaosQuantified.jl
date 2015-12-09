using Base.Test

a = collect("aaaaaaaa")
@test_approx_eq entropy(a) 0 
@test_approx_eq conditional_entropy(a[1:(end-1)], a[2:end]) 0 

abcd = collect("abcdabcd")
@test_approx_eq entropy(abcd) 2 
@test_approx_eq conditional_entropy(abcd[1:(end-1)], abcd[2:end]) 0 

abac = collect("abac")
@test_approx_eq entropy(abac) 1.5 
@test_approx_eq conditional_entropy(abac[1:(end-1)], abac[2:end]) 2/3
@test_approx_eq conditional_entropy(DelayEmbedding(abac, 3), abac[3:end]) 0
