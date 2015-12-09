import Base: size, getindex

"""
`DelayEmbedding` wraps any vector and exposes a view with vectors of
`dim` consecutive elements, with differences between indices being `lag`.
For `dim` equal to `1` it reduces to a regular `dim`-sized slidig window.
"""
immutable DelayEmbedding{T, Vec <: AbstractVector} <: AbstractVector{AbstractVector{T}}
  vec :: Vec
  dim :: Int
  lag :: Int

  function DelayEmbedding(vec :: Vec, dim :: Int, lag :: Int)
    if dim < 1
      throw(ArgumentError("Dimension has to be positive"))
    elseif lag < 1
      throw(ArgumentError("Lag has to be positive"))
    else
      new(vec, dim, lag)
    end
  end
end

function DelayEmbedding{Vec <: AbstractVector}(vec :: Vec, dim :: Int, lag :: Int = 1)
  DelayEmbedding{eltype(vec), Vec}(vec, dim, lag)
end


size(de :: DelayEmbedding) = max(0, size(de.vec, 1) - (de.dim - 1) * de.lag)

function getindex(de :: DelayEmbedding, i :: Int)
  slice(de.vec, i : de.lag : (i + (de.dim - 1) * de.lag))
end

