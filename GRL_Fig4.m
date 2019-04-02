

% Load post-processed data
load GRL_postproc.mat

% Vertical levels
levels = [53 60 80 90 100 110 120 140 160 180 200];

% Create juliantime vector
WCv2_date(:,4:5) = WCv2_time;
WCv2_date(:,6) = 0;
juliantime_sta = juliandate(datetime(WCv2_date)) - juliandate(datetime('2016-01-01 00:00:00'))+1;
juliantime_sta(juliantime_sta >= 367) = juliantime_sta(juliantime_sta>=367)-366;

% _________________________________________________________________________
% WIND ROSE
% _________________________________________________________________________

% Wind rose
WCv2_WD_offset = WCv2_WD + 60.5;
WCv2_WD_offset(WCv2_WD_offset>360) = WCv2_WD_offset(WCv2_WD_offset>360)-360;

figure()
wind_rose(WCv2_WD_offset(:,5),WCv2_WS(:,5),'di',[0,3,6,9,12,15,18],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Wind speed [m s^{-1}]')

% Seasonal wind roses
start_months = [306 336 1 32 60 92 122 153 183 214 245 275];
imin = [];
imin(1) = 1;
for i = 2:length(start_months)+1
    [~,imin(i)] = min(abs(juliantime_sta - start_months(i-1)));
end

% Winter
figure()
wind_rose(WCv2_WD_offset(imin(3):imin(6),5),WCv2_WS(imin(3):imin(6),5),'ci',[2,4,6,8],'di',[0,3,6,9,12,15,18],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Wind speed [m s^{-1}]')

% Summer
figure()
wind_rose(WCv2_WD_offset(imin(9):imin(12),5),WCv2_WS(imin(9):imin(12),5),'ci',[2,4,6,8],'di',[0,3,6,9,12,15,18],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Wind speed [m s^{-1}]')


  
% _________________________________________________________________________
% DISSIPATION ROSE
% _________________________________________________________________________

% 10-min average data from .sta files
juliantime_v2_plot = juliantime_v2_plot(12512:end);
imin = nan(length(juliantime_v2_plot),1);
for i = 1:length(juliantime_v2_plot)
    [~,imin(i)] = min(abs(juliantime_v2_plot(i) - juliantime_sta));
end
 
eps_sta = nan(size(juliantime_sta,1),length(levels));
for i = 1:size(eps_sta,1)
    eps_sta(i,:) = nanmedian(eps_oconn(imin == i,:),1);
end

WCv2_logeps_100_sta = log10(eps_sta(:,5));
WCv2_WD_100 = WCv2_WD_offset(:,5);
WCv2_WD_plot = WCv2_WD_100(~isnan(WCv2_logeps_100_sta));
WCv2_logeps_rose_plot = WCv2_logeps_100_sta(~isnan(WCv2_logeps_100_sta));

% Dissipation Rose
figure()
wind_rose(WCv2_WD_plot,WCv2_logeps_rose_plot,'di',[-6,-5,-4,-3,-2],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Log of \epsilon')

% Seasonal
start_months = [306 336 1 32 60 92 122 153 183 214 245 275];
imin = [];
imin(1) = 1;
for i = 2:length(start_months)+1
    [~,imin(i)] = min(abs(juliantime_sta - start_months(i-1)));
end

% Winter
eps_winter = WCv2_logeps_100_sta(imin(3):imin(6),1);
WD_winter_eps = WCv2_WD_offset(imin(3):imin(6),5);
eps_winter = eps_winter(~isnan(eps_winter));
WD_winter_eps = WD_winter_eps(~isnan(eps_winter));
figure()
wind_rose(WD_winter_eps,eps_winter,'di',[-6,-5,-4,-3,-2],'ci',[2,4,6,8],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Log of \epsilon')

% Summer
eps_summer = WCv2_logeps_100_sta(imin(9):imin(12),1);
WD_summer_eps = WCv2_WD_offset(imin(9):imin(12),5);
eps_summer = eps_summer(~isnan(eps_summer));
WD_summer_eps = WD_summer_eps(~isnan(eps_summer));
figure()
wind_rose(WD_summer_eps,eps_summer,'di',[-6,-5,-4,-3,-2],'ci',[2,4,6,8],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','Log of \epsilon')


% _________________________________________________________________________
% TKE ROSE
% _________________________________________________________________________

% Wind direction
WCv2_WD_offset = WCv2_WD + 60.5;
WCv2_WD_offset(WCv2_WD_offset>360) = WCv2_WD_offset(WCv2_WD_offset>360)-360;
WCv2_WD_100 = WCv2_WD_offset(:,5);

% 10-min average data from .sta files
juliantime_TKE = juliantime_TKE(2494:end);
imin = nan(length(juliantime_TKE),1);
for i = 1:length(juliantime_TKE)
    [~,imin(i)] = min(abs(juliantime_TKE(i) - juliantime_sta));
end

TKE_sta = nan(size(juliantime_sta,1),length(levels));
for i = 1:size(TKE_sta,1)
    TKE_sta(i,:) = nanmedian(TKE(imin == i,:),1);
end

WCv2_TKE_100_sta = TKE_sta(:,5);

% No Nans
WCv2_WD_plot = WCv2_WD_100(~isnan(WCv2_TKE_100_sta));
WCv2_TKE_rose_plot = WCv2_TKE_100_sta(~isnan(WCv2_TKE_100_sta));

% TKE Rose
figure()
wind_rose(WCv2_WD_plot,WCv2_TKE_rose_plot,'di',[0,0.2,0.4,0.6,0.8,1],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','TKE [m^{2} s^{-2}]')

% Seasonal
start_months = [306 336 1 32 60 92 122 153 183 214 245 275];
imin = [];
imin(1) = 1;
for i = 2:length(start_months)+1
    [~,imin(i)] = min(abs(juliantime_sta - start_months(i-1)));
end

% Winter
TKE_winter = WCv2_TKE_100_sta(imin(3):imin(6),1);
TKE_winter = TKE_winter(~isnan(TKE_winter));
WD_winter_TKE = WCv2_WD_offset(imin(3):imin(6),5);
WD_winter_TKE = WD_winter_TKE(~isnan(TKE_winter));
figure()
wind_rose(WD_winter_TKE,TKE_winter,'di',[0,0.2,0.4,0.6,0.8,1],'ci',[2,4,6,8],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','TKE [m^{2} s^{-2}]')

% Summer
TKE_summer = WCv2_TKE_100_sta(imin(9):imin(12),1);
TKE_summer = TKE_summer(~isnan(TKE_summer));
WD_summer_TKE = WCv2_WD_offset(imin(9):imin(12),5);
WD_summer_TKE = WD_summer_TKE(~isnan(TKE_summer));
figure()
wind_rose(WD_summer_TKE,TKE_summer,'di',[0,0.2,0.4,0.6,0.8,1],'ci',[2,4,6,8],'dtype','meteo','legtype',1,'cmap',parula,'lablegend','TKE [m^{2} s^{-2}]')

