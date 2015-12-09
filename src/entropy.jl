"""
Computes entropy of a sequence.
"""
function entropy(X :: AbstractVector)
  d = Dict{eltype(X), Int}()
  n = length(X)
  for i = 1:length(X)
    d[X[i]] = get(d, X[i], 0) + 1
  end
  sum(kv -> log2(n / kv[2]) * kv[2], d) / n
end

"""
Computes conditional entropy `H(Y | X)`.
"""
function conditional_entropy(X :: AbstractVector, Y :: AbstractVector)
  d = Dict{eltype(X), Dict{eltype(Y), Int}}()
  n = length(X)
  for i = 1:length(X)
    if !haskey(d, X[i])
      d[X[i]] = Dict{eltype(Y), Int}()
    end
    d[X[i]][Y[i]] = get(d[X[i]], Y[i], 0) + 1
  end

  function _el_ent(ed :: Dict{eltype(Y), Int})
    en = sum(kv -> kv[2], ed)
    sum(kv -> log2(en / kv[2]) * kv[2], ed)
  end
  sum(kv -> _el_ent(kv[2]), d) / n
end
