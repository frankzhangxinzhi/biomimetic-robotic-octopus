% main codes for ABS material post-lab data processing
clc
clear

% load data
load('ABS1127Result.mat')
load('PP1122Result.mat')
load('N1122Result.mat')
load('DAR1204Result.mat')

% Set default font to Times New Roman for all plots
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultLegendFontName', 'Times New Roman');

% hold all data in a HUGE structure
% 1. ABS
% 2. PP
% 3. N
% 4. DAR
DATA = [ABS1127Result,PP1122Result,N1122Result,DAR1204Result];

materialList = ["ABS Plastic","Polyester Plastic","Water Resistant Nylon","Delrin Acetal Resin"];

dotColor.blue = [0,0,1];
dotColor.Orange = [1, 0.6, 0];
dotColor.Red = [0.85, 0, 0];
dotColor.Green = [0, 0.7, 0];
dotColorNames = fieldnames(dotColor);

dotstyle = ['o','s','^','d'];

%% actual buckling from video footage
% for each line: [beginning, ending]
LbActual = [122.5, 97.5; 152.5, 142.5; 142.5, 122.5; 152.5, 127.5];
patch_Y = [1.65, 2.22; 2.05, 2.35;2.05, 2.8;2.1, 2.55];

%% Prediced Buckling Length
Lb = [114.04 122.67 123.7 121.95];
Lbnew = [115.14 121.6 122.36 121.06];

%% Subplots
figure
widthForLines = 1;
markersize = 50;
for z = 1:length(DATA)
    subplot(2,2,z)
    errorbar(DATA(z).L(:), DATA(z).ratio(:), DATA(z).d_ratio(:),'LineWidth', 0.5, 'Color', dotColor.(dotColorNames{z}),'LineStyle','none','HandleVisibility', 'off')
    hold on
    x_patch = [LbActual(z,1) LbActual(z,1) LbActual(z,2) LbActual(z,2)];
    y_patch = [0 5 5 0];
    patch(x_patch, y_patch, dotColor.(dotColorNames{z}), 'EdgeColor','none','Linewidth',0.5,'FaceAlpha', 0.1,'HandleVisibility', 'off');
    plot([Lbnew(z) Lbnew(z)],[0 5],'-','Color',dotColor.(dotColorNames{z}),'LineWidth',widthForLines,'HandleVisibility', 'off')
    plot([Lb(z) Lb(z)],[0 5],':','Color',dotColor.(dotColorNames{z}),'LineWidth',widthForLines,'HandleVisibility', 'off')
    scatter(DATA(z).L(:),DATA(z).ratio(:),markersize,dotstyle(z),'MarkerFaceColor', dotColor.(dotColorNames{z}), 'MarkerEdgeColor', 'none','DisplayName', materialList(z))
    xlim([min(DATA(z).L(:))-5 max(DATA(z).L(:))+5])
    xlabel(materialList(z)+' Fin length (mm)')
    ylim([min(DATA(z).ratio(:))-0.3 max(DATA(z).ratio(:))+0.4])
    ylabel('$\bar{C}_T/\bar{C}_D$', 'Interpreter', 'latex')
    hold off
end

% just for legend... lol
figure 
hold on
ylim([0 1]);xlim([0 1])
plot([999 999],[0 5],':','Color','k','LineWidth',widthForLines,'DisplayName', 'Predicted Buckling Length from Equation 3')
plot([999 999],[0 5],'-','Color','k','LineWidth',widthForLines,'DisplayName', 'Predicted Buckling Length from Equation 5')
patch([999 999 999 999], [999 999 999 999],'k','EdgeColor','k','Linewidth',0.5,'FaceAlpha', 0.1,'DisplayName', 'Development of Asymmetric Buckling')
legend

%% 4 Material in ONE plot
figure 
hold on

for z = 1:length(DATA)
    errorbar(DATA(z).L(:), DATA(z).ratio(:), DATA(z).d_ratio(:),'LineWidth', 0.5, 'Color', dotColor.(dotColorNames{z}),'LineStyle','none','HandleVisibility', 'off')
    x_patch = [LbActual(z,1) LbActual(z,1) LbActual(z,2) LbActual(z,2)];
    y_patch = [patch_Y(z,1) patch_Y(z,2) patch_Y(z,2) patch_Y(z,1)];
    patch(x_patch, y_patch, dotColor.(dotColorNames{z}), 'EdgeColor',dotColor.(dotColorNames{z}),'Linewidth',0.5,'FaceAlpha', 0.1,'HandleVisibility', 'off');
end
for z = 1:length(DATA)
    scatter(DATA(z).L(:),DATA(z).ratio(:),markersize,dotstyle(z),'MarkerFaceColor', dotColor.(dotColorNames{z}), 'MarkerEdgeColor', 'none','DisplayName', materialList(z))
end

% for the legend 
plot([999 999],[0 5],':','Color','k','LineWidth',widthForLines,'DisplayName', 'Predicted Buckling Length')
patch([999 999 999 999], [999 999 999 999],'k','EdgeColor','k','Linewidth',0.5,'FaceAlpha', 0.1,'DisplayName', 'Development of Asymmetric Buckling')


xlim([60 155])
xlabel('Fin length (mm)')
ylim([1.2 3.2])
ylabel('$\bar{C}_T/\bar{C}_D$', 'Interpreter', 'latex')
legend('Location','northwest')



