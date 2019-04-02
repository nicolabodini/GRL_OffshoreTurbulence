

% Load post-processed data
load GRL_postproc.mat

% Create julian time vector
WCv2_date(:,4:5) = WCv2_time;
WCv2_date(:,6) = 0;
juliantime_sta = juliandate(datetime(WCv2_date)) - juliandate(datetime('2016-01-01 00:00:00'))+1;
juliantime_sta(juliantime_sta >= 367) = juliantime_sta(juliantime_sta>=367)-366;

% Calculate wind veer veer
veer = abs(rad2deg(angdiff(deg2rad(WCv2_WD(:,2)),deg2rad(WCv2_WD(:,11)))));

% 3m/s wind speed threshold
WS_avg = (WCv2_WS(:,2)+WCv2_WS(:,11))./2;
veer(WS_avg < 3) = NaN;

% Select wind veer for region 2
veer_r2 = veer(WS_avg < 13);

% _________________________________________________________________________
% SUMMER VEER
% _________________________________________________________________________
% June 1
[~,istart_summer] = min(abs(juliantime_sta-152));
% Aug 30
[~,iend_summer] = min(abs(juliantime_sta-244));

veer_summer = veer(istart_summer:iend_summer);
WS_avg_summer = WS_avg(istart_summer:iend_summer);
veer_summer_r2 = veer_summer(WS_avg_summer > 5 & WS_avg_summer < 13);

% _________________________________________________________________________
% WINTER VEER
% _________________________________________________________________________
% Dec 1
[~,istart_winter] = min(abs(juliantime_sta-336));
% March 31
[~,iend_winter] = min(abs(juliantime_sta-60));

veer_winter = veer(istart_winter:iend_winter);
WS_avg_winter = WS_avg(istart_winter:iend_winter);
veer_winter_r2 = veer_winter(WS_avg_winter > 5 & WS_avg_winter < 13);

% _________________________________________________________________________
% PLOTS
% _________________________________________________________________________

% Filter outliers for clean data viz purposes
veer(veer>100) = NaN;
veer_r2(veer_r2>100) = NaN;
veer_summer(veer_summer>100) = NaN;
veer_summer_r2(veer_summer_r2>100) = NaN;
veer_winter(veer_winter>100) = NaN;
veer_winter_r2(veer_winter_r2>100) = NaN;

figure()
histogram(veer./140)
hold on
histogram(veer_r2./140)

figure()
histogram(veer_summer./140)
hold on
histogram(veer_summer_r2./140)

figure()
histogram(veer_winter./140)
hold on
histogram(veer_winter_r2./140)




