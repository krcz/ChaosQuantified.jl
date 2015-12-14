using Base.Test

v = [1, 2, 3, 4, 5, 6, 7, 8]

emb1 = DelayEmbedding(v, 3)
@test size(emb1) == 6
@test emb1[1] == [1, 2, 3]
@test emb1[6] == [6, 7, 8]

emb2 = DelayEmbedding(v, 2, 2)
@test size(emb2) == 6
@test emb2[1] == [1, 3]
@test emb2[6] == [6, 8]

@test_throws BoundsError emb2[0]
@test_throws BoundsError emb2[7]

@test_throws ArgumentError DelayEmbedding(v, 0)
@test_throws ArgumentError DelayEmbedding(v, -3)
@test_throws ArgumentError DelayEmbedding(v, 2, 0)
@test_throws ArgumentError DelayEmbedding(v, 2, -5)
