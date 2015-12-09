module Rqa

"""Helper struct keeping sizes of diagonal lines and total area
of recurrence plot. In case of regular recurrence plot only upper triangle
(without the diagonal) is considered; in case of cross recurrence plot it is
the whole rectanle"""
type RQAdata
  area :: Int64
  lines :: Dict{Int64, Int64}
end

"Computes recurrence rate - probability of recurrence"
function RR(data :: RQAdata)
  if isempty(data.lines)
    0
  else
    sum(kv -> kv[1]*kv[2], data.lines) / data.area
  end
end

function DET(data :: RQAdata, min_length :: Int = 2)
  if isempty(data.lines)
    0
  else
    longblack = sum(data.lines) do kv
      if kv[1] >= min_length
        kv[1]*kv[2]
      else
        0
      end
    end

    allblack = sum(kv -> kv[1]*kv[2], data.lines)
    longblack / allblack
  end
end

"Computes mean length of line"
function LMEAN(data :: RQAdata)
  llines = filter((k,v) -> k > 1, data.lines)
  if isempty(llines)
    NaN
  else
    length_sum = sum(kv -> kv[1] * kv[2], llines)
    count = sum(kv -> kv[2], llines)
    length_sum / count
  end
end

"Computes entropy of lines"
function LENT(data :: RQAdata)
  llines = filter((k,v) -> k > 1, data.lines)
  if isempty(llines)
    NaN
  else
    cnt = sum(kv -> kv[2], llines)
    sum(kv -> kv[2] / cnt * log2(cnt / kv[2]), llines)
  end
end

"""
Calculates the lines count for RQA. Takes into consideration only one triangle
of the plot, without the diagonal"""
function rqadata(sig :: AbstractVector, eq :: Function = (x, y) -> x == y)
  n = length(sig)
  lines = Dict{Int64, Int64}()

  for lag = 1:(n - 1)
    l = 0
    for i in (lag + 1):n
      if eq(sig[i], sig[i - lag])
        l += 1
      else
        if l > 0
          lines[l] = get(lines, l, 0) + 1
        end
        l = 0
      end
    end
    if l > 0
      lines[l] = get(lines, l, 0) + 1
    end
  end
  RQAdata(div(n*(n - 1), 2), lines)
end

"""
Computes the recurrence data for Cross Recurrence Quantification Analysis
"""
function crqadata(
    sig1 :: AbstractVector,
    sig2 :: AbstractVector,
    eq :: Function = (x, y) -> x == y)
  n = length(sig1)
  m = length(sig2)
  lines = Dict{Int64, Int64}()

  for lag = (1 - n):(m - 1)
    l = 0
    for i in max(1, 1-lag):min(n, m - lag)
      if eq(sig1[i], sig2[i + lag])
        l += 1
      else
        if l > 0
          lines[l] = get(lines, l, 0) + 1
        end
        l = 0
      end
    end
    if l > 0
      lines[l] = get(lines, l, 0) + 1
    end
  end
  RQAdata(n*m, lines)
end

end
