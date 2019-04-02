
% Load post-processed data
load GRL_postproc.mat

% Create julian time vector
WCv2_date(:,4:5) = WCv2_time;
WCv2_date(:,6) = 0;
juliantime_sta = juliandate(datetime(WCv2_date)) - juliandate(datetime('2016-01-01 00:00:00'))+1;
juliantime_sta(juliantime_sta >= 367) = juliantime_sta(juliantime_sta>=367)-366;

% Vertical levels
levels = [53 60 80 90 100 110 120 140 160 180 200];

% Calculate annual cycle
timeplot = 1:1:(366);
eps_annual = nan(length(levels),length(timeplot));
WS_annual = nan(length(levels),length(timeplot));
TKE_annual = nan(length(levels),length(timeplot));
for i = 1:length(timeplot)
    for k = 1:length(levels)
        eps_annual(k,i) = nanmedian(eps_oconn(abs(juliantime_v2_plot - timeplot(i))<1/2*30,k));
        WS_annual(k,i) = nanmean(WCv2_WS(abs(juliantime_sta - timeplot(i))<1/2*30,k));
        TKE_annual(k,i) = nanmedian(TKE(abs(juliantime_TKE - timeplot(i))<1/2*30,k));
    end
end

% _________________________________________________________________________
% ANNUAL CLIMATOLOGY OF DISSIPATION
% _________________________________________________________________________

figure()
pcolor(timeplot,levels,log10(eps_annual))
colormap parula % type of color scale
c = [1E-5, 1E-4, 1E-3, 1E-2];
c1 = [1E-5, 1E-4, 1E-3, 1E-2];
caxis(log10([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',log10(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'\epsilon [m^{2}/s^{3}]','FontSize',16)
shading interp %interp % flat
xlabel('Day of the year','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])

% _________________________________________________________________________
% ANNUAL CLIMATOLOGY OF WIND SPEED
% _________________________________________________________________________

figure()
pcolor(timeplot,levels,WS_annual)
colormap parula % type of color scale
c = [6, 10, 14];
c1 = [6, 10, 14];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'10-min wind speed [m s^{-1}]','FontSize',16)
shading interp %interp % flat
xlabel('Day of the year','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])

% _________________________________________________________________________
% ANNUAL CLIMATOLOGY OF TKE
% _________________________________________________________________________

figure()
pcolor(timeplot,levels,TKE_annual)
colormap parula % type of color scale
c = [0, 0.25, 0.5, 0.75];
c1 = [0, 0.25, 0.5, 0.75];
caxis(([c(1) c(length(c))])); % range for colors
colbar=colorbar('FontSize',16,'YTick',(c1),'YTickLabel',c1); % show colorbar in the plot
xlabel(colbar,'Lidar TKE [m^{2} s^{-2}]','FontSize',16)
shading interp %interp % flat
xlabel('Day of the year','FontSize',16)
ylabel('Height (m AGL)','FontSize',16)
set(gca,'FontSize',14)
ylim([53,200])








