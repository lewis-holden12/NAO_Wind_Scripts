% correlations feb

[r50, p50] = corrcoef(hours_cell{17}(1:67), feb_nao_SB(1:67,2));
[r50_49_59, p50_49_59] = corrcoef(hours_cell{13}(1:11), feb_nao_SB(1:11,2));
[r50_60_69, p50_60_69] = corrcoef(hours_cell{13}(12:21), feb_nao_SB(12:21,2));
[r50_70_79, p50_70_79] = corrcoef(hours_cell{13}(22:31), feb_nao_SB(22:31,2));
[r50_80_89, p50_80_89] = corrcoef(hours_cell{13}(32:41), feb_nao_SB(32:41,2));
[r50_90_99, p50_90_99] = corrcoef(hours_cell{13}(42:51), feb_nao_SB(42:51,2));
[r50_00_09, p50_00_09] = corrcoef(hours_cell{13}(52:61), feb_nao_SB(52:61,2));
[r50_10_15, p50_10_15] = corrcoef(hours_cell{13}(62:67), feb_nao_SB(62:67,2));

r_oct_50(1,:) = [r50(1,2) r50_49_59(1,2) r50_60_69(1,2) r50_70_79(1,2) r50_80_89(1,2) r50_90_99(1,2) r50_00_09(1,2) r50_10_15(1,2)] 
p_oct_50(1,:) = [p50(1,2) p50_49_59(1,2) p50_60_69(1,2) p50_70_79(1,2) p50_80_89(1,2) p50_90_99(1,2) p50_00_09(1,2) p50_10_15(1,2)] 

[rGF, pGF] = corrcoef(hours_cell{18}(1:67), feb_nao_SB(1:67,2));
[rGF_49_59, pGF_49_59] = corrcoef(hours_cell{18}(1:11), feb_nao_SB(1:11,2));
[rGF_60_69, pGF_60_69] = corrcoef(hours_cell{18}(12:21), feb_nao_SB(12:21,2));
[rGF_70_79, pGF_70_79] = corrcoef(hours_cell{18}(22:31), feb_nao_SB(22:31,2));
[rGF_80_89, pGF_80_89] = corrcoef(hours_cell{18}(32:41), feb_nao_SB(32:41,2));
[rGF_90_99, pGF_90_99] = corrcoef(hours_cell{18}(42:51), feb_nao_SB(42:51,2));
[rGF_00_09, pGF_00_09] = corrcoef(hours_cell{18}(52:61), feb_nao_SB(52:61,2));
[rGF_10_15, pGF_10_15] = corrcoef(hours_cell{18}(62:67), feb_nao_SB(62:67,2));

r_oct_50(2,:) = [rGF(1,2) rGF_49_59(1,2) rGF_60_69(1,2) rGF_70_79(1,2) rGF_80_89(1,2) rGF_90_99(1,2) rGF_00_09(1,2) rGF_10_15(1,2)] 
p_oct_50(2,:) = [pGF(1,2) pGF_49_59(1,2) pGF_60_69(1,2) pGF_70_79(1,2) pGF_80_89(1,2) pGF_90_99(1,2) pGF_00_09(1,2) pGF_10_15(1,2)] 

[rSF, pSF] = corrcoef(hours_cell{19}(1:67), feb_nao_SB(1:67,2));
[rSF_49_59, pSF_49_59] = corrcoef(hours_cell{19}(1:11), feb_nao_SB(1:11,2));
[rSF_60_69, pSF_60_69] = corrcoef(hours_cell{19}(12:21), feb_nao_SB(12:21,2));
[rSF_70_79, pSF_70_79] = corrcoef(hours_cell{19}(22:31), feb_nao_SB(22:31,2));
[rSF_80_89, pSF_80_89] = corrcoef(hours_cell{19}(32:41), feb_nao_SB(32:41,2));
[rSF_90_99, pSF_90_99] = corrcoef(hours_cell{19}(42:51), feb_nao_SB(42:51,2));
[rSF_00_09, pSF_00_09] = corrcoef(hours_cell{19}(52:61), feb_nao_SB(52:61,2));
[rSF_10_15, pSF_10_15] = corrcoef(hours_cell{19}(62:67), feb_nao_SB(62:67,2));

r_oct_50(3,:) = [rSF(1,2) rSF_49_59(1,2) rSF_60_69(1,2) rSF_70_79(1,2) rSF_80_89(1,2) rSF_90_99(1,2) rSF_00_09(1,2) rSF_10_15(1,2)] 
p_oct_50(3,:) = [pSF(1,2) pSF_49_59(1,2) pSF_60_69(1,2) pSF_70_79(1,2) pSF_80_89(1,2) pSF_90_99(1,2) pSF_00_09(1,2) pSF_10_15(1,2)] 

[r99, p99] = corrcoef(hours_cell{20}(1:67), feb_nao_SB(1:67,2));
[r99_49_59, p99_49_59] = corrcoef(hours_cell{20}(1:11), feb_nao_SB(1:11,2));
[r99_60_69, p99_60_69] = corrcoef(hours_cell{20}(12:21), feb_nao_SB(12:21,2));
[r99_70_79, p99_70_79] = corrcoef(hours_cell{20}(22:31), feb_nao_SB(22:31,2));
[r99_80_89, p99_80_89] = corrcoef(hours_cell{20}(32:41), feb_nao_SB(32:41,2));
[r99_90_99, p99_90_99] = corrcoef(hours_cell{20}(42:51), feb_nao_SB(42:51,2));
[r99_00_09, p99_00_09] = corrcoef(hours_cell{20}(52:61), feb_nao_SB(52:61,2));
[r99_10_15, p99_10_15] = corrcoef(hours_cell{20}(62:67), feb_nao_SB(62:67,2));

r_oct_50(4,:) = [r99(1,2) r99_49_59(1,2) r99_60_69(1,2) r99_70_79(1,2) r99_80_89(1,2) r99_90_99(1,2) r99_00_09(1,2) r99_10_15(1,2)] 
p_oct_50(4,:) = [p99(1,2) p99_49_59(1,2) p99_60_69(1,2) p99_70_79(1,2) p99_80_89(1,2) p99_90_99(1,2) p99_00_09(1,2) p99_10_15(1,2)] 