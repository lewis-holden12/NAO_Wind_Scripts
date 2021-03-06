% correlations october

[r50, p50] = corrcoef(feburary_cell{13}(1:67), feb_nao_SB(1:67,2));
[r50_49_59, p50_49_59] = corrcoef(feburary_cell{13}(1:11), feb_nao_SB(1:11,2));
[r50_60_69, p50_60_69] = corrcoef(feburary_cell{13}(12:21), feb_nao_SB(12:21,2));
[r50_70_79, p50_70_79] = corrcoef(feburary_cell{13}(22:31), feb_nao_SB(22:31,2));
[r50_80_89, p50_80_89] = corrcoef(feburary_cell{13}(32:41), feb_nao_SB(32:41,2));
[r50_90_99, p50_90_99] = corrcoef(feburary_cell{13}(42:51), feb_nao_SB(42:51,2));
[r50_00_09, p50_00_09] = corrcoef(feburary_cell{13}(52:61), feb_nao_SB(52:61,2));
[r50_10_15, p50_10_15] = corrcoef(feburary_cell{13}(62:67), feb_nao_SB(62:67,2));

r_oct_50(1,:) = [r50(1,2) r50_49_59(1,2) r50_60_69(1,2) r50_70_79(1,2) r50_80_89(1,2) r50_90_99(1,2) r50_00_09(1,2) r50_10_15(1,2)] 
p_oct_50(1,:) = [p50(1,2) p50_49_59(1,2) p50_60_69(1,2) p50_70_79(1,2) p50_80_89(1,2) p50_90_99(1,2) p50_00_09(1,2) p50_10_15(1,2)] 

[rGF, pGF] = corrcoef(feburary_cell{14}(1:67), feb_nao_SB(1:67,2));
[rGF_49_59, pGF_49_59] = corrcoef(feburary_cell{14}(1:11), feb_nao_SB(1:11,2));
[rGF_60_69, pGF_60_69] = corrcoef(feburary_cell{14}(12:21), feb_nao_SB(12:21,2));
[rGF_70_79, pGF_70_79] = corrcoef(feburary_cell{14}(22:31), feb_nao_SB(22:31,2));
[rGF_80_89, pGF_80_89] = corrcoef(feburary_cell{14}(32:41), feb_nao_SB(32:41,2));
[rGF_90_99, pGF_90_99] = corrcoef(feburary_cell{14}(42:51), feb_nao_SB(42:51,2));
[rGF_00_09, pGF_00_09] = corrcoef(feburary_cell{14}(52:61), feb_nao_SB(52:61,2));
[rGF_10_15, pGF_10_15] = corrcoef(feburary_cell{14}(62:67), feb_nao_SB(62:67,2));

r_oct_50(2,:) = [rGF(1,2) rGF_49_59(1,2) rGF_60_69(1,2) rGF_70_79(1,2) rGF_80_89(1,2) rGF_90_99(1,2) rGF_00_09(1,2) rGF_10_15(1,2)] 
p_oct_50(2,:) = [pGF(1,2) pGF_49_59(1,2) pGF_60_69(1,2) pGF_70_79(1,2) pGF_80_89(1,2) pGF_90_99(1,2) pGF_00_09(1,2) pGF_10_15(1,2)] 

[rSF, pSF] = corrcoef(feburary_cell{15}(1:67), feb_nao_SB(1:67,2));
[rSF_49_59, pSF_49_59] = corrcoef(feburary_cell{15}(1:11), feb_nao_SB(1:11,2));
[rSF_60_69, pSF_60_69] = corrcoef(feburary_cell{15}(12:21), feb_nao_SB(12:21,2));
[rSF_70_79, pSF_70_79] = corrcoef(feburary_cell{15}(22:31), feb_nao_SB(22:31,2));
[rSF_80_89, pSF_80_89] = corrcoef(feburary_cell{15}(32:41), feb_nao_SB(32:41,2));
[rSF_90_99, pSF_90_99] = corrcoef(feburary_cell{15}(42:51), feb_nao_SB(42:51,2));
[rSF_00_09, pSF_00_09] = corrcoef(feburary_cell{15}(52:61), feb_nao_SB(52:61,2));
[rSF_10_15, pSF_10_15] = corrcoef(feburary_cell{15}(62:67), feb_nao_SB(62:67,2));

r_oct_50(3,:) = [rSF(1,2) rSF_49_59(1,2) rSF_60_69(1,2) rSF_70_79(1,2) rSF_80_89(1,2) rSF_90_99(1,2) rSF_00_09(1,2) rSF_10_15(1,2)] 
p_oct_50(3,:) = [pSF(1,2) pSF_49_59(1,2) pSF_60_69(1,2) pSF_70_79(1,2) pSF_80_89(1,2) pSF_90_99(1,2) pSF_00_09(1,2) pSF_10_15(1,2)] 

[r99, p99] = corrcoef(hours_cell{16}(1:67), feb_nao_SB(1:67,2));
[r99_49_59, p99_49_59] = corrcoef(feburary_cell{16}(1:11), feb_nao_SB(1:11,2));
[r99_60_69, p99_60_69] = corrcoef(feburary_cell{16}(12:21), feb_nao_SB(12:21,2));
[r99_70_79, p99_70_79] = corrcoef(feburary_cell{16}(22:31), feb_nao_SB(22:31,2));
[r99_80_89, p99_80_89] = corrcoef(feburary_cell{16}(32:41), feb_nao_SB(32:41,2));
[r99_90_99, p99_90_99] = corrcoef(feburary_cell{16}(42:51), feb_nao_SB(42:51,2));
[r99_00_09, p99_00_09] = corrcoef(feburary_cell{16}(52:61), feb_nao_SB(52:61,2));
[r99_10_15, p99_10_15] = corrcoef(feburary_cell{16}(62:67), feb_nao_SB(62:67,2));

r_oct_50(4,:) = [r99(1,2) r99_49_59(1,2) r99_60_69(1,2) r99_70_79(1,2) r99_80_89(1,2) r99_90_99(1,2) r99_00_09(1,2) r99_10_15(1,2)] 
p_oct_50(4,:) = [p99(1,2) p99_49_59(1,2) p99_60_69(1,2) p99_70_79(1,2) p99_80_89(1,2) p99_90_99(1,2) p99_00_09(1,2) p99_10_15(1,2)] 
