% correlations october

[r50, p50] = corrcoef(hours_cell{1}(1:67), oct_nao_PC(1:67,2));
[r50_49_59, p50_49_59] = corrcoef(hours_cell{1}(1:11), oct_nao_PC(1:11,2));
[r50_60_69, p50_60_69] = corrcoef(hours_cell{1}(12:21), oct_nao_PC(12:21,2));
[r50_70_79, p50_70_79] = corrcoef(hours_cell{1}(22:31), oct_nao_PC(22:31,2));
[r50_80_89, p50_80_89] = corrcoef(hours_cell{1}(32:41), oct_nao_PC(32:41,2));
[r50_90_99, p50_90_99] = corrcoef(hours_cell{1}(42:51), oct_nao_PC(42:51,2));
[r50_00_09, p50_00_09] = corrcoef(hours_cell{1}(52:61), oct_nao_PC(52:61,2));
[r50_10_15, p50_10_15] = corrcoef(hours_cell{1}(62:67), oct_nao_PC(62:67,2));

r_oct_50(1,:) = [r50(1,2) r50_49_59(1,2) r50_60_69(1,2) r50_70_79(1,2) r50_80_89(1,2) r50_90_99(1,2) r50_00_09(1,2) r50_10_15(1,2)] 
p_oct_50(1,:) = [p50(1,2) p50_49_59(1,2) p50_60_69(1,2) p50_70_79(1,2) p50_80_89(1,2) p50_90_99(1,2) p50_00_09(1,2) p50_10_15(1,2)] 

[rGF, pGF] = corrcoef(hours_cell{2}(1:67), oct_nao_PC(1:67,2));
[rGF_49_59, pGF_49_59] = corrcoef(hours_cell{2}(1:11), oct_nao_PC(1:11,2));
[rGF_60_69, pGF_60_69] = corrcoef(hours_cell{2}(12:21), oct_nao_PC(12:21,2));
[rGF_70_79, pGF_70_79] = corrcoef(hours_cell{2}(22:31), oct_nao_PC(22:31,2));
[rGF_80_89, pGF_80_89] = corrcoef(hours_cell{2}(32:41), oct_nao_PC(32:41,2));
[rGF_90_99, pGF_90_99] = corrcoef(hours_cell{2}(42:51), oct_nao_PC(42:51,2));
[rGF_00_09, pGF_00_09] = corrcoef(hours_cell{2}(52:61), oct_nao_PC(52:61,2));
[rGF_10_15, pGF_10_15] = corrcoef(hours_cell{2}(62:67), oct_nao_PC(62:67,2));

r_oct_50(2,:) = [rGF(1,2) rGF_49_59(1,2) rGF_60_69(1,2) rGF_70_79(1,2) rGF_80_89(1,2) rGF_90_99(1,2) rGF_00_09(1,2) rGF_10_15(1,2)] 
p_oct_50(2,:) = [pGF(1,2) pGF_49_59(1,2) pGF_60_69(1,2) pGF_70_79(1,2) pGF_80_89(1,2) pGF_90_99(1,2) pGF_00_09(1,2) pGF_10_15(1,2)] 

[rSF, pSF] = corrcoef(hours_cell{3}(1:67), oct_nao_PC(1:67,2));
[rSF_49_59, pSF_49_59] = corrcoef(hours_cell{3}(1:11), oct_nao_PC(1:11,2));
[rSF_60_69, pSF_60_69] = corrcoef(hours_cell{3}(12:21), oct_nao_PC(12:21,2));
[rSF_70_79, pSF_70_79] = corrcoef(hours_cell{3}(22:31), oct_nao_PC(22:31,2));
[rSF_80_89, pSF_80_89] = corrcoef(hours_cell{3}(32:41), oct_nao_PC(32:41,2));
[rSF_90_99, pSF_90_99] = corrcoef(hours_cell{3}(42:51), oct_nao_PC(42:51,2));
[rSF_00_09, pSF_00_09] = corrcoef(hours_cell{3}(52:61), oct_nao_SB(52:61,2));
[rSF_10_15, pSF_10_15] = corrcoef(hours_cell{3}(62:67), oct_nao_SB(62:67,2));

r_oct_50(3,:) = [rSF(1,2) rSF_49_59(1,2) rSF_60_69(1,2) rSF_70_79(1,2) rSF_80_89(1,2) rSF_90_99(1,2) rSF_00_09(1,2) rSF_10_15(1,2)] 
p_oct_50(3,:) = [pSF(1,2) pSF_49_59(1,2) pSF_60_69(1,2) pSF_70_79(1,2) pSF_80_89(1,2) pSF_90_99(1,2) pSF_00_09(1,2) pSF_10_15(1,2)] 

[r99, p99] = corrcoef(hours_cell{4}(1:67), oct_nao_PC(1:67,2));
[r99_49_59, p99_49_59] = corrcoef(hours_cell{4}(1:11), oct_nao_PC(1:11,2));
[r99_60_69, p99_60_69] = corrcoef(hours_cell{4}(12:21), oct_nao_PC(12:21,2));
[r99_70_79, p99_70_79] = corrcoef(hours_cell{4}(22:31), oct_nao_PC(22:31,2));
[r99_80_89, p99_80_89] = corrcoef(hours_cell{4}(32:41), oct_nao_PC(32:41,2));
[r99_90_99, p99_90_99] = corrcoef(hours_cell{4}(42:51), oct_nao_PC(42:51,2));
[r99_00_09, p99_00_09] = corrcoef(hours_cell{4}(52:61), oct_nao_PC(52:61,2));
[r99_10_15, p99_10_15] = corrcoef(hours_cell{4}(62:67), oct_nao_PC(62:67,2));

r_oct_50(4,:) = [r99(1,2) r99_49_59(1,2) r99_60_69(1,2) r99_70_79(1,2) r99_80_89(1,2) r99_90_99(1,2) r99_00_09(1,2) r99_10_15(1,2)] 
p_oct_50(4,:) = [p99(1,2) p99_49_59(1,2) p99_60_69(1,2) p99_70_79(1,2) p99_80_89(1,2) p99_90_99(1,2) p99_00_09(1,2) p99_10_15(1,2)] 