using Base.Test

rqa = Rqa.rqadata(collect("rqa"))
@test_approx_eq Rqa.RR(rqa) 0
@test Rqa.DET(rqa) |> isnan
@test Rqa.LMEAN(rqa) |> isnan
@test Rqa.LENT(rqa) |> isnan

alabama = Rqa.rqadata(collect("alabama"))
@test_approx_eq Rqa.RR(alabama) 6/21
@test_approx_eq Rqa.DET(alabama) 0
@test Rqa.LMEAN(alabama) |> isnan
@test Rqa.LENT(alabama) |> isnan


zzz = Rqa.rqadata(collect("zzz"))
@test_approx_eq Rqa.RR(zzz) 1
@test_approx_eq Rqa.DET(zzz) 2/3
@test_approx_eq Rqa.LMEAN(zzz) 2
@test_approx_eq Rqa.LENT(zzz) 0

w7 = Rqa.crqadata(collect("www"), collect("wwww"))
@test_approx_eq Rqa.RR(w7) 1
@test_approx_eq Rqa.DET(w7) 10/12
@test_approx_eq Rqa.LMEAN(w7) 2.5
@test_approx_eq Rqa.LENT(w7) 1

taran = Rqa.crqadata(collect("ratatar"), collect("taran"))
@test_approx_eq Rqa.RR(taran) 10/35
@test_approx_eq Rqa.DET(taran) 7/10
@test_approx_eq Rqa.LMEAN(taran) 7/3
@test_approx_eq Rqa.LENT(taran) (-(1/3) * log2(1/3) - (2/3) * log2(2/3))
@test_approx_eq Rqa.DET(taran, 3) 3/10
@test_approx_eq Rqa.LMEAN(taran, 3) 3
@test_approx_eq Rqa.LENT(taran, 3) 0
@test_approx_eq Rqa.DET(taran, 4) 0
@test Rqa.LMEAN(taran, 4) |> isnan
@test Rqa.LENT(taran, 4) |> isnan
