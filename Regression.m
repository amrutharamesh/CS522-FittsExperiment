clear all; close all; warning off; clc;

%%
load clk_ammu.mat;
ID = data(:, 4);
ID = floor(ID*1000)/1000;
MT = data(:, 5);
D = data(:, 3);
TP = data(:,6);
W = data(:, 2);
UID = unique(ID);
UMT = []; UTP = [];
for i=1:length(UID)
    inds = find(ID==UID(i));
    MT(inds) = MT(inds);
    UMT = [UMT; mean(MT(inds))];
    UTP = [UMT; mean(TP(inds))];
end

%%
randInds = randperm(length(ID));
ID = ID(randInds);
MT = MT(randInds);
coeffs = polyfit(ID, MT, 1);
save ('coeffs.mat', 'coeffs');

%%
figure;
plot(ID, MT, 'b.', 'LineWidth', 5); grid on;
title('Movement Time over Index of Difficulty'); xlabel('ID (bits)'); ylabel('MT (ms)');
figure;
plot(ID, TP, 'b.', 'LineWidth', 5); grid on;
title('Throughput over Index of Difficulty'); xlabel('ID (bits)'); ylabel('TP (bits/ms)');
save ('coeffs.mat', 'coeffs');
figure; plot(UID, UMT, 'bo', 'LineWidth', 5);
title('Mean(Movement Time) over Index of Difficulty'); xlabel('ID (bits)'); ylabel('TP (bits/ms)');
hold on;
lineCoords = [min(UID)-1 polyval(coeffs, min(UID)-1); max(UID)+1 polyval(coeffs, max(UID)+1)];
plot(lineCoords(:,1), lineCoords(:,2), 'r-', 'LineWidth', 3);