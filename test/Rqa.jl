using Base.Test

rqa = Rqa.rqadata(collect("rqa"))
@test_approx_eq Rqa.RR(rqa) 0

alabama = Rqa.rqadata(collect("alabama"))
@test_approx_eq Rqa.RR(alabama) 6/21
@test_approx_eq Rqa.DET(alabama) 0


zzz = Rqa.rqadata(collect("zzz"))
@test_approx_eq Rqa.RR(zzz) 1
@test_approx_eq Rqa.DET(zzz) 2/3


w7 = Rqa.crqadata(collect("www"), collect("wwww"))
@test_approx_eq Rqa.RR(w7) 1
@test_approx_eq Rqa.DET(w7) 10/12

taran = Rqa.crqadata(collect("ratatar"), collect("taran"))
@test_approx_eq Rqa.RR(taran) 10/35
@test_approx_eq Rqa.DET(taran) 7/10
