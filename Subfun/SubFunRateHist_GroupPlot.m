function varargout=SubFunRateHist_GroupPlot(X,RateAll,Color,varargin)

%%%%%%output{1} a is for figure legend
%%%%%%output{2} Outstats is the statistics


if nargin==4
   
   Param=varargin{1};
   if ~isfield(Param,'PlotType')
      Param.PlotType=2;       
   end
   
Ytick=Param.Ytick;
Ystep=(max(Ytick)-min(Ytick))/20;
hold on;




end
%      dfX=median(diff(X))/10;
dfX=median(diff(X))/10;
for i=1:length(RateAll)
    plotX1(i)=(i-1)*dfX/2;
end

for i=1:length(RateAll)
        plotX2=plotX1(i)+X;

    if size(RateAll{i},1)==length(X)
%     a(i)=error_area(X,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),0.4);
%     ErrorBarPlotLU(X,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),Param.PlotType,1);
    SubFunPlotErrorBar(X,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),Param.PlotType,1)

    else
%     a(i)=error_area(X,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),0.4);
%     ErrorBarPlotLU(X,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),Param.PlotType,1);
    SubFunPlotErrorBar(X,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),Param.PlotType,1);
    end
    hold on;

end

set(gca,'fontname','Times New Roman');
varargout{1}=1;

end

