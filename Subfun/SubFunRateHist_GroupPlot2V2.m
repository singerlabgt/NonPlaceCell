function varargout=SubFunRateHist_GroupPlot2V2(X,RateAll,Color,varargin)


if nargin==4
   
   Param=varargin{1};
   if isfield(Param,'Marker')
   else
      for i=1:length(RateAll)
      Param.Marker{i}='o';
      end
   end
   
   
   if ~isfield(Param,'PlotType')
      Param.PlotType=2;       
   end
Ytick=Param.Ytick;
Ystep=(max(Ytick)-min(Ytick))/20;
hold on;
else
   Param.Pair=[];
   Param.SignY=2;
   Param.Plot=1;
   Param.Std=1;      %%%%%%%%%using standard deviation as errorbar
   Param.LimY=[0 Param.SignY*1.2];
   Param.Marker={'o'};

    


end
     dfX=median(diff(X))/10;
     if isnan(dfX)
        dfX=0.1;
     end

ParamTemp=rmfield(Param,'Marker');
for i=1:length(RateAll)
    
    if length(Param.Marker)>1
       ParamTemp.Marker{1}=Param.Marker{i};
    end

    
    
    X2=X+dfX*(i-1);
    
    
    
    if size(RateAll{i},1)==length(X)
%     a(i)=error_area(X,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),0.4);
    SubFunPlotErrorBar(X2,nanmean(RateAll{i},2),ste(RateAll{i}'),Color(i,:),5,1,ParamTemp)

    else
%     a(i)=error_area(X,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),0.4);
    SubFunPlotErrorBar(X2,nanmean(RateAll{i}),ste(RateAll{i}),Color(i,:),5,1,ParamTemp);

    end
    hold on;
    

    

    
end

if nargout==1
   varargout{1}=1;
end








