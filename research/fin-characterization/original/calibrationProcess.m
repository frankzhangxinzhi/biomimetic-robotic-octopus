function steadyStageResult = calibrationProcess(M,loadingTF)
steadyStageResult = zeros(6,3);
if loadingTF == 1
    steadyStageResult(2,1) = 50;
    steadyStageResult(3,1) = 150;
    steadyStageResult(4,1) = 350;
    steadyStageResult(5,1) = 550;
    steadyStageResult(6,1) = 1050;
else
    steadyStageResult(5,1) = 50;
    steadyStageResult(4,1) = 150;
    steadyStageResult(3,1) = 350;
    steadyStageResult(2,1) = 550;
    steadyStageResult(1,1) = 1050;
end
for i = 1:6
    samplenum1 = 3000*((i-1)*10+3);
    samplenum2 = 3000*(i*10-3);
    steadyStageResult(i,2) = mean(M(samplenum1:samplenum2, 2));
    steadyStageResult(i,3) = std(M(samplenum1:samplenum2, 2));
end