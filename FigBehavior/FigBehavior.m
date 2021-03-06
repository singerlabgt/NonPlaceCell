
clear all
close all
load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\Performance.mat');
SavePath='C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\FigBehavior\';




%%%%%%%%%%%For Fig S13A ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper

   P.xLeft=0.2;
   P.xRight=0.02;
   P.yTop=0.02;
   P.yBottom=0.06;
   P.xInt=0.02;
   P.yInt=0.05;

   x=[1 2];

   RGroupID=[1 2];
   GroupPair.Pair=[1;2];
   GroupPair.SignY=15;
   GroupPair.Plot=1;
   GroupPair.Std=1;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=0; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker={'o'};
   PlotColor3=[0.1 0.1 0.1;0.5 0.1 0.1];

   
   figure;
   clear TempData

   
   %%%%%%%%%%%%Task Time
   TempData{1}=DurationMotivatedTT(GenoAnimal{1})/60;
   TempData{2}=DurationMotivatedTT(GenoAnimal{2})/60;
   GroupPair.SignY=200;
   subplotLU(3,1,1,1,P)
   SubFunPlotErrorBar(x,TempData,[],PlotColor3,2,1,GroupPair,RGroupID);
   set(gca,'xlim',[0 3])
   set(gca,'xtick',x,'xticklabel',[])
   box off
   set(gca,'yticklabel',[],'xticklabel',[],'ylim',[0 200],'ytick',0:100:200)


   %%%%%%%%%%%%Trial Num.
   clear TempData
   TempData{1}=TrialNumAll(GenoAnimal{1});
   TempData{2}=TrialNumAll(GenoAnimal{2});
   GroupPair.SignY=1000;
   subplotLU(3,1,2,1,P)
   SubFunPlotErrorBar(x,TempData,[],PlotColor3,2,1,GroupPair,RGroupID);
   set(gca,'xlim',[0 3])
   set(gca,'xtick',x,'xticklabel',[],'ylim',[0 1000],'ytick',0:200:800)
   set(gca,'yticklabel',[],'xticklabel',[])
   box off
   
   %%%%%%%%%%%%Success Rate.

   clear TempData
   TempData{1}=SuccR(GenoAnimal{1});
   TempData{2}=SuccR(GenoAnimal{2});
   GroupPair.SignY=1.1;
   subplotLU(3,1,3,1,P)
   SubFunPlotErrorBar(x,TempData,[],PlotColor3,2,1,GroupPair,RGroupID);
   set(gca,'xlim',[0 3])
   set(gca,'xtick',x,'xticklabel',[],'ylim',[0 1.2],'ytick',[0 0.5 1])
   set(gca,'yticklabel',[],'xticklabel',[])

   box off

papersizePX=[0 0 4 8];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'Performance'],'png'); 
%%%%%%%%%%%For Fig13A ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper









%%%%%%%%%%%For Fig13B ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper


%%%%%%%%Compare Rewardzone (6), ShamRewardZone (3) and Non-reward Zone ([1 2 4 5])
clear LickRS SpeedRS TimeRS OccRS
for iG=1:length(GenoAnimal)
    LickRS{(iG-1)*3+3}=squeeze(nanmean(LickMap180(GenoAnimal{iG},[1 2 4 5]),2)); %%%Other non-reward zones
    LickRS{(iG-1)*3+2}=(LickMap180(GenoAnimal{iG},3));   %%%%Sham reward
    LickRS{(iG-1)*3+1}=(LickMap180(GenoAnimal{iG},6));   %%%%reward
    

    %%%Occupancy Prob
   OccRS{(iG-1)*3+3}=squeeze(nanmean(NormOccMap180(GenoAnimal{iG},[1 2 4 5]),2)); %%%Other non-reward zones
   OccRS{(iG-1)*3+2}=(NormOccMap180(GenoAnimal{iG},3));   %%%%Sham reward
   OccRS{(iG-1)*3+1}=(NormOccMap180(GenoAnimal{iG},6));   %%%%reward

    
    SpeedRS{(iG-1)*3+3}=nanmean(SpeedGroup(GenoAnimal{iG},[1 2 4 5]),2);
    SpeedRS{(iG-1)*3+2}=SpeedGroup(GenoAnimal{iG},3);
    SpeedRS{(iG-1)*3+1}=SpeedGroup(GenoAnimal{iG},6);
    


end
x=[1 2 3 5 6 7];
PlotColor3=[0.1 0.1 0.1;0.5 0.1 0.1];

   PlotColor4=[repmat(PlotColor3(1,:),3,1);repmat(PlotColor3(2,:),3,1)];
   RGroupID=[1 1 1 2 2 2];
   tempPair=[1 1 2;2 3 3];
   tempPair2=[1 2 3;4 5 6];
%    GroupPair.Pair=[tempPair tempPair+3];
   GroupPair.Pair=[tempPair tempPair+3 tempPair2];
   GroupPair.SignY=15;
   GroupPair.Plot=1;
   GroupPair.Std=1;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=1; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker={'o'};
   
   figure;
   
   GroupPair.SignY=5;
   GroupPair.LimY=[0 6];

   subplotLU(3,1,1,1,P)
   SubFunPlotErrorBar(x,LickRS,[],PlotColor4,2,1,GroupPair,RGroupID);
   set(gca,'xtick',x,'xticklabel',[],'ytick',[0:3:6],'ylim',[0 6])
   set(gca,'yticklabel',[])

   box off
   
   
   GroupPair.SignY=23;
   GroupPair.LimY=[0 25];
   subplotLU(3,1,2,1,P)
   SubFunPlotErrorBar(x,SpeedRS,[],PlotColor4,2,1,GroupPair,RGroupID);
   set(gca,'xtick',x,'xticklabel',[])
      set(gca,'yticklabel',[])

   box off

   GroupPair.SignY=0.5;
   GroupPair.LimY=[0 0.6];
   subplotLU(3,1,3,1,P)
   SubFunPlotErrorBar(x,OccRS,[],PlotColor4,2,1,GroupPair,RGroupID);
   set(gca,'xtick',x,'xticklabel',repmat({'True G.','False G.','Others'},1,2),'ytick',[0:0.3:0.6],'ylim',[0 0.6])
   set(gca,'yticklabel',[],'xticklabel',[])
   box off

   
papersizePX=[0 0 10 8];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'LickSpeedOccRewardNonReward'],'png'); 
%%%%%%%%%%%For Fig13B ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper

