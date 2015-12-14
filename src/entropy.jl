"""
Computes entropy of a sequence.
"""
function entropy(X :: AbstractVector)
  counts = Dict{eltype(X), Int}()
  n = length(X)
  for i = 1:length(X)
    counts[X[i]] = get(counts, X[i], 0) + 1
  end
  sum(kv -> log2(n / kv[2]) * kv[2], counts) / n
end

"""
Computes conditional entropy `H(Y | X)`.
"""
function conditional_entropy(X :: AbstractVector, Y :: AbstractVector)
  cnts_for_pref = Dict{eltype(X), Dict{eltype(Y), Int}}()
  n = length(X)
  for i = 1:length(X)
    if !haskey(cnts_for_pref, X[i])
      cnts_for_pref[X[i]] = Dict{eltype(Y), Int}()
    end
    counts = cnts_for_pref[X[i]]
    counts[Y[i]] = get(counts, Y[i], 0) + 1
  end

  # this helper function computes "unnormalized entropy" for given counts dict
  # i.e. entropy multiplied by sum of counts
  function _prefix_helper(counts :: Dict{eltype(Y), Int})
    counts_sum = sum(kv -> kv[2], counts)
    sum(kv -> log2(counts_sum / kv[2]) * kv[2], counts)
  end

  sum(kv -> _prefix_helper(kv[2]), cnts_for_pref) / n
end
