

% Load post-processed data
load GRL_postproc.mat

% Vertical levels
levels = [53 60 80 90 100 110 120 140 160 180 200];

timeplot = 0:24/2880:(24-24/2880);
timeclimatology = 0:1/2880:(1-1/2880); % 30s intervals in a day
eps_climat_summer = nan(length(levels),length(timeclimatology));
eps_climat_winter = nan(length(levels),length(timeclimatology));

% _________________________________________________________________________
% SUMMER DIURNAL CLIMATOLOGY OF DISSIPATION
% _________________________________________________________________________

% June 1
[~,istart_summer] = min(abs(juliantime_v2_plot-152));
% Aug 30
[~,iend_summer] = min(abs(juliantime_v2_plot-244));

eps_oconn_summer = eps_oconn(istart_summer:iend_summer,:);
juliantime_v2_summer = juliantime_v2_plot(istart_summer:iend_summer);
integ=floor(juliantime_v2_summer);
fract=juliantime_v2_summer-integ;

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        eps_climat_summer(k,i) = nanmedian(eps_oconn_summer(abs(fract - timeclimatology(i))<1/2*1/2880,k));
    end
end

figure()
pcolor(timeplot,levels,log10(eps_climat_summer))
colormap parula % type of color scale
c = [1E-5, 1E-4, 1E-3, 1E-2];
c1 = [1E-5, 1E-4, 1E-3, 1E-2];
caxis(log10([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',log10(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'\epsilon [m^{2}/s^{3}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])

% _________________________________________________________________________
% WINTER DIURNAL CLIMATOLOGY OF DISSIPATION
% _________________________________________________________________________

% Dec 1
[~,istart_winter] = min(abs(juliantime_v2_plot-336));
% March 31
[~,iend_winter] = min(abs(juliantime_v2_plot-60));

eps_oconn_winter = eps_oconn(istart_winter:iend_winter,:);
juliantime_v2_winter = juliantime_v2_plot(istart_winter:iend_winter);
integ=floor(juliantime_v2_winter);
fract=juliantime_v2_winter-integ;

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        eps_climat_winter(k,i) = nanmedian(eps_oconn_winter(abs(fract - timeclimatology(i))<1/2*1/2880,k));
    end
end

figure()
pcolor(timeplot,levels,log10(eps_climat_winter))
colormap parula % type of color scale
c = [1E-5, 1E-4, 1E-3, 1E-2];
c1 = [1E-5, 1E-4, 1E-3, 1E-2];
caxis(log10([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',log10(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'\epsilon [m^{2}/s^{3}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])

% _________________________________________________________________________
% SUMMER DIURNAL CLIMATOLOGY OF WIND SPEED
% _________________________________________________________________________

% Create juliantime vector
WCv2_date(:,4:5) = WCv2_time;
WCv2_date(:,6) = 0;
juliantime_sta = juliandate(datetime(WCv2_date)) - juliandate(datetime('2016-01-01 00:00:00'))+1;
juliantime_sta(juliantime_sta >= 367) = juliantime_sta(juliantime_sta>=367)-366;

% June 1
[~,istart_summer] = min(abs(juliantime_sta-152));
% Sept 30
[~,iend_summer] = min(abs(juliantime_sta-244));

WCv2_WS_summer = WCv2_WS(istart_summer:iend_summer,:);
juliantime_sta_summer = juliantime_sta(istart_summer:iend_summer);
integ=floor(juliantime_sta_summer);
fract=juliantime_sta_summer-integ;

timeclimatology = 0:1/(24*6):(1-1/(24*6)); % 10-min intervals in a day
WS_climat_summer = nan(length(levels),length(timeclimatology));

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        WS_climat_summer(k,i) = nanmean(WCv2_WS_summer(abs(fract - timeclimatology(i))<1/2*1/(24*6),k));
    end
end

timeplot = 0:24/(24*6):(24-24/(24*6));

figure()
pcolor(timeplot,levels,WS_climat_summer)
colormap parula % type of color scale
c = [6, 10, 14];
c1 = [6, 10, 14];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'10-min wind speed [m s^{-1}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])


% _________________________________________________________________________
% WINTER DIURNAL CLIMATOLOGY OF WIND SPEED
% _________________________________________________________________________

% Dec 1
[~,istart_winter] = min(abs(juliantime_sta-336));
% March 31
[~,iend_winter] = min(abs(juliantime_sta-60));

WCv2_WS_winter = WCv2_WS(istart_winter:iend_winter,:);
juliantime_sta_winter = juliantime_sta(istart_winter:iend_winter);
integ=floor(juliantime_sta_winter);
fract=juliantime_sta_winter-integ;

timeclimatology = 0:1/(24*6):(1-1/(24*6)); % 10-min intervals in a day
WS_climat_winter = nan(length(levels),length(timeclimatology));

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        WS_climat_winter(k,i) = nanmean(WCv2_WS_winter(abs(fract - timeclimatology(i))<1/2*1/(24*6),k));
    end
end

timeplot = 0:24/(24*6):(24-24/(24*6));

figure()
pcolor(timeplot,levels,WS_climat_winter)
colormap parula % type of color scale
c = [6, 10, 14];
c1 = [6, 10, 14];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'10-min wind speed [m s^{-1}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])


% _________________________________________________________________________
% WINTER DIURNAL CLIMATOLOGY OF TKE
% _________________________________________________________________________

% Dec 1
[~,istart_winter] = min(abs(juliantime_TKE-336));
% March 31
[~,iend_winter] = min(abs(juliantime_TKE-60));

TKE_winter = TKE(istart_winter:iend_winter,:);
TKE_winter(TKE_winter>10) = NaN;
juliantime_TKE_winter = juliantime_TKE(istart_winter:iend_winter);
integ=floor(juliantime_TKE_winter);
fract=juliantime_TKE_winter-integ;

timeclimatology = 0:1/(24*6):(1-1/(24*6)); % 10-min intervals in a day
TKE_climat_winter = nan(length(levels),length(timeclimatology));

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        TKE_climat_winter(k,i) = nanmedian(TKE_winter(abs(fract - timeclimatology(i))<1/2*1/(24*6),k));
    end
end

timeplot = 0:24/(24*6):(24-24/(24*6));

figure()
pcolor(timeplot,levels,TKE_climat_winter)
colormap parula % type of color scale
c = [0, 0.75];
c1 = [0, 0.75];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'Lidar TKE [m^{2} s^{-2}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])


% _________________________________________________________________________
% SUMMER DIURNAL CLIMATOLOGY OF TKE
% _________________________________________________________________________

% June 1
[~,istart_summer] = min(abs(juliantime_TKE-152));
% Sept 30
[~,iend_summer] = min(abs(juliantime_TKE-244));

TKE_summer = TKE(istart_summer:iend_summer,:);
juliantime_TKE_summer = juliantime_TKE(istart_summer:iend_summer);
integ=floor(juliantime_TKE_summer);
fract=juliantime_TKE_summer-integ;

timeclimatology = 0:1/(24*6):(1-1/(24*6)); % 10-min intervals in a day
TKE_climat_summer = nan(length(levels),length(timeclimatology));

for i = 1:length(timeclimatology)
    for k = 1:length(levels)
        TKE_climat_summer(k,i) = nanmedian(TKE_summer(abs(fract - timeclimatology(i))<1/2*1/(24*6),k));
    end
end

timeplot = 0:24/(24*6):(24-24/(24*6));

figure()
pcolor(timeplot,levels,TKE_climat_summer)
colormap parula % type of color scale
c = [0, 0.75];
c1 = [0, 0.75];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'Lidar TKE [m^{2} s^{-2}]','FontSize',16)
shading interp %interp % flat
xlabel('Time UTC','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])


