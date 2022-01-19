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


if ~isfield(Param,'GroupPair')
   GroupPair.Pair=[];
   GroupPair.SignY=2;
   GroupPair.Plot=1;
   GroupPair.Std=1;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=1; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker={'o'};
else
   GroupPair=Param.GroupPair;
end


end
%      dfX=median(diff(X))/10;
dfX=median(diff(X))/10;
for i=1:length(RateAll)
    plotX1(i)=(i-1)*dfX/2;
end

GroupPair1=GroupPair;


for i=1:length(RateAll)
        plotX2=plotX1(i)+X;
    if length(GroupPair.Marker)~=1
       GroupPair1.Marker={GroupPair.Marker{i}};
    end

    if size(RateAll{i},1)==length(X)
    SubFunPlotErrorBar(X,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),Param.PlotType,1,GroupPair1)

    else
    SubFunPlotErrorBar(X,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),Param.PlotType,1,GroupPair1);
    end
    hold on;

end

set(gca,'fontname','Times New Roman');
varargout{1}=1;

end

