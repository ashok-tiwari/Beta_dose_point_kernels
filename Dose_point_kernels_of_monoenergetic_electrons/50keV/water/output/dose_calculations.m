% Absorbed dose and dose point kernels calculations 
% 50 keV monoenergetic electrons in water
% Date: Jan 26, 2019
% Ashok Tiwari, University of Iowa

close all; clear; clc; workspace;

%% Read GATE generated .mhd file and perform radial averaging of absorbed dose
mhd_image = fopen('2e7_50keV_water-Edep.raw', 'r');
dose_img = fread(mhd_image,'float32');
max_value = max(dose_img);
min_value = min(dose_img);
dose_img_X = 400;
dose_img_Y = 400;
dose_img_Z = 400;

dose_image = reshape(dose_img, dose_img_X, dose_img_Y, dose_img_Z);

% Radial averaging of absorbed dose
j = 0; X1 = dose_img_X/2; Y1 = dose_img_Y/2; Z1 = dose_img_Z/2;

voxel_SIZE = 0.00062270002672448754;     % in mm
voxel_size = voxel_SIZE * 0.001;         % voxel size in meter
density = 1000;                          % density of water (kg/m^3)

for i = 1:1:(dose_img_Z/2 - 1)
    j = j+1; M = 0;
    for k = 0:2:360                      % measurement at each 2 degrees
        x = i * cosd(k);
        y = i * sind(k);
        Xc = X1 + x;
        Yc = Y1 + y;
        XR = round(Xc);
        YR = round(Yc);
        M = M + dose_image(XR, YR, Z1);
        desposited_energy = M/180;       % energy deposition in MeV using doseActor
    end
    D(j,1) = i * voxel_SIZE;             % radial distance in mm
    D(j,2) = (desposited_energy * 1.60218*10^(-13)) / ((voxel_size^3) * density); % dose in Gy
end


%% save # of shells (i) and absorbed dose (Gy) in Excel file
title_name = {'Simulations of 50 keV monoenergetic electrons in water'};
col_header = {'Radius(mm)', 'Dose(Gy)'};
writematrix(D, 'dose_50keV_mono_ele.xls', 'sheet', 1, 'Range', 'A3:B201');
writecell(col_header, 'dose_50keV_mono_ele.xls', 'Sheet', 1, 'Range', 'A2:B2');
writecell(title_name, 'dose_50keV_mono_ele.xls', 'Sheet', 1, 'Range', 'A1:B1')


%% Read Monte Carlo simulation data from Excel
data = readmatrix('dose_50keV_mono_ele.xls', 'sheet', 1, 'Range', 'A3:B201');

first_col  = data(1:101, 1);         % radial distance in mm
second_col = data(1:101, 2);         % dose in Gy

%% plot absorbed dose vs distance
figure(1)
plot(first_col, second_col, 'k-o', 'LineWidth',1);

% Make ticks longer and thicker
ax = gca;
properties(ax)
for k = .01 : 0.01 : .02
  ax.TickLength = [k, k];  % Make tick marks longer
  ax.LineWidth = 50*k;     % Make tick marks thicker
end
ay = gca;
properties(ay)
for k = .01 : 0.01 : .02
  ay.TickLength = [k, k];
end

grid on
ax = gca;
ax.XGrid = 'off';
ax.YGrid = 'on';
ax.GridLineStyle = '-';

legend({'50 keV monoenergy electron'}, 'Fontsize', 14);
legend('boxoff')

set(gca,'TickDir','in'); % other options are, 'both' 'in'
%set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
%set(gca,'xticklabel',num2str(get(gca,'xtick')','%.1f'))
set(gca, 'YScale', 'log')
set(gca,'FontSize',16, 'XMinorTick','on','YMinorTick','on');
ax = gca;
%ax.YAxis.Exponent = 0;
 
%title('monoenergetic electron 50 keV');
xlabel('Radial distance (mm)', 'FontSize', 16);
ylabel('Absorbed dose (Gy)', 'FontSize', 16);
saveas(gcf, '/home/ashok/Desktop/projects/project1/Dose_point_kernels_of_monoenergetic_electrons/50keV/water/output/mono_ele_dose_50keV.png');


%% Dose point kernels of 50 keV monoenergetic electron calculations
%  Dose point kernel J = (4*PI*(radius)^2*Dose(r,E) * Rcsda)/E;

Rcsda = 0.00432;    % in g/cm^2
Rcsda = Rcsda * 10; % in kg/m^2
r_over_Rcsda = ((first_col * 0.001)/Rcsda)*1000;

Energy = 0.05 * 1.602 * 10^(-13); % in joules

J = (4*pi*((first_col*0.001).^2).*second_col.*Rcsda)/(Energy*2e7); % 2e7 is the number of primaries

% plot dose point kernel vs scaled distance (r_over_Rcsda)
figure(2);
plot(r_over_Rcsda, J, 'k-o', 'LineWidth',1 );

% Make ticks longer and thicker
ax = gca;
properties(ax)
for k = .01 : 0.01 : .02
  ax.TickLength = [k, k];  % Make tick marks longer
  ax.LineWidth = 50*k;     % Make tick marks thicker
end
ay = gca;
properties(ay)
for k = .01 : 0.01 : .02
  ay.TickLength = [k, k];
end

grid on
ax = gca;
ax.XGrid = 'off';
ax.YGrid = 'on';
ax.GridLineStyle = '-';

legend({'50 keV'}, 'Fontsize', 14);
legend('boxoff')

set(gca,'TickDir','in'); % other options are, 'both' 'in'
%set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
%set(gca,'xticklabel',num2str(get(gca,'xtick')','%.1f'))
%set(gca, 'YScale', 'log')
set(gca,'FontSize',16, 'XMinorTick','on','YMinorTick','on');
ax = gca;
%ax.YAxis.Exponent = 0;
 
%title('monoenergetic electron dose point kernels 50 keV');
xlabel('Scaled distance (r/Rcsda)', 'FontSize', 16);
ylabel('Dose Point Kernel (J)', 'FontSize', 16);
saveas(gcf, '/home/ashok/Desktop/projects/project1/Dose_point_kernels_of_monoenergetic_electrons/50keV/water/output/mono_ele_dpk_50keV.png');







