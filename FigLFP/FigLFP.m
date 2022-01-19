clear all

load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\LFP.mat')
SavePath='C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\FigLFP\';

ComColor= [10,80,190;176,34,242;10,150,120;191,126,0;178,51,51;51,204,178;131 151 18;100 50 189;]/255;

Datatype=1; %%%%paired data
Dim1=3;  %%%%%%%%3 theta gamma states


%%%%%%%%%%%For Fig3E ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper
GroupPair.Pair=[1 3 5;2 4 6];
RGroupID=[1 1 2 2 3 3];  
BarColor=[ComColor(1,:);ComColor(1,:);ComColor(2,:);ComColor(2,:);ComColor(3,:);ComColor(3,:)];
x=[1 2 4 5 7 8];
clear PlotData;
PlotData{1}=squeeze(OccMData(1,WT,1));   %%%%State 1 incorrect
PlotData{2}=squeeze(OccMData(1,WT,2));   %%%%State 1 correct
PlotData{3}=squeeze(OccMData(2,WT,1));   %%%%State 2 incorrect
PlotData{4}=squeeze(OccMData(2,WT,2));   %%%%State 2 correct
PlotData{5}=squeeze(OccMData(3,WT,1));   %%%%State 3 incorrect
PlotData{6}=squeeze(OccMData(3,WT,2));   %%%%State 3 correct

GroupPair.SignY=0.43;
GroupPair.LimY=[0 0.45];
GroupPair.Std=0;
GroupPair.Pair=[1 3 5;2 4 6];
GroupPair.SignY=0.36;
GroupPair.Plot=1;
GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
GroupPair.SamplePairedPlot=2; %%%%%%%%%Dash line for paired comparison sample
GroupPair.LimY=[0 GroupPair.SignY*1.2];





P.yTick=[0.15 0.45];
P.xTick=x;
%              PlotData{3}=squeeze(OccMData(ii,AD,1));
%              PlotData{4}=squeeze(OccMData(ii,AD,2));
%              statsTrans(ii)=ErrorBarPlotLU(x,PlotData,[],ComColor(ii,:),2,Datatype,[SavePath 'Occ' num2str(ii) '.txt'],GroupPair,RGroupID);
figure;
subplot('position',[0.02 0.02 0.96 0.96])
SubFunPlotErrorBar(x,PlotData,[],BarColor,2,Datatype,GroupPair,RGroupID);

%  set(gca,'xlim',[0.5 8.5],'xtick',P.xTick,'xticklabel',[],'linewidth',1);
 set(gca,'ylim',[0.15 0.45],'ytick',P.yTick,'yticklabel',[],'box','off');

papersizePX=[0 0 10 7];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'OccWT'],'png'); 
%%%%%%%%%%%For Fig3E ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper






%%%%%%%%%%%For Fig4D ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper
GroupPair.Pair=[1 3 5 7 9 11;2 4 6 8 10 12];   %%%WC comparison
tempPair=[[1 2;3 4] [1 2;3 4]+4 [1 2;3 4]+8];  %%%Geno comparison
GroupPair.Pair=[GroupPair.Pair tempPair];
RGroupID=[1 1 2 2 3 3 4 4 5 5 6 6];  
BarColor=[repmat(ComColor(1,:),4,1);repmat(ComColor(2,:),4,1);;repmat(ComColor(3,:),4,1)];
x=[[1:4] [1:4]+1+4 [1:4]+2+8];
clear PlotData;
PlotData{1}=squeeze(OccMData(1,WT,1));     %%%%State 1 incorrect WT
PlotData{end+1}=squeeze(OccMData(1,WT,2)); %%%%State 1 correct WT
PlotData{end+1}=squeeze(OccMData(1,AD,1)); %%%%State 1 incorrect AD
PlotData{end+1}=squeeze(OccMData(1,AD,2)); %%%%State 1 correct AD

PlotData{end+1}=squeeze(OccMData(2,WT,1)); %%%%State 2 incorrect WT
PlotData{end+1}=squeeze(OccMData(2,WT,2)); %%%%State 2 correct WT
PlotData{end+1}=squeeze(OccMData(2,AD,1)); %%%%State 2 incorrect AD
PlotData{end+1}=squeeze(OccMData(2,AD,2)); %%%%State 2 correct AD

PlotData{end+1}=squeeze(OccMData(3,WT,1)); %%%%State 3 incorrect WT
PlotData{end+1}=squeeze(OccMData(3,WT,2)); %%%%State 3 correct WT
PlotData{end+1}=squeeze(OccMData(3,AD,1)); %%%%State 3 incorrect AD
PlotData{end+1}=squeeze(OccMData(3,AD,2)); %%%%State 3 correct AD

GroupPair.SignY=0.48;
GroupPair.LimY=[0 0.45];
GroupPair.Std=0;
P.yTick=[0.15 0.45];
P.xTick=x;
figure;
subplot('position',[0.02 0.02 0.96 0.96])
SubFunPlotErrorBar(x,PlotData,[],BarColor,2,Datatype,GroupPair,RGroupID);
set(gca,'xlim',[x(1)-0.5 x(end)+0.5],'xtick',P.xTick,'xticklabel',[],'linewidth',1);
set(gca,'ylim',[0.15 0.5],'ytick',P.yTick,'yticklabel',[],'box','off');

papersizePX=[0 0 6 4];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'WTADOcc'],'png'); 
%%%%%%%%%%%For Fig4D ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper



%%%%%%%%%%%For Fig S11 AB
clear PlotData
x=[1 2 4 5];
Datatype=1;

   GroupPair.Pair=[1 1 2 3;2 3 4 4];
   GroupPair.SignY=0.55;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=2; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 0.6];
RGroupID=[1 1 2 2];  

   P.xLeft=0.06;
   P.xRight=0.02;
   P.yTop=0.02;
   P.yBottom=0.06;
   P.xInt=0.02;
   P.yInt=0.02
   P.xTick=x;
   P.yTick=0.1:0.3:0.7;
figure;
 for ii=1:Dim1  
         for jj=1:Dim1
             subplotLU(Dim1+1,Dim1,ii+1,jj)
             PlotData{1}=squeeze(TransMData(ii,jj,WT,1));
             PlotData{2}=squeeze(TransMData(ii,jj,WT,2));
             PlotData{3}=squeeze(TransMData(ii,jj,AD,1));
             PlotData{4}=squeeze(TransMData(ii,jj,AD,2));
             SubFunPlotErrorBar(x,PlotData,[],[0.2 0.2 0.2],2,Datatype,GroupPair,RGroupID);

             set(gca,'ylim',[0.2 0.6],'ytick',P.yTick,'yticklabel',[]);

         end
             subplotLU(Dim1+1,Dim1,1,ii)

             PlotData{1}=squeeze(OccMData(ii,WT,1));
             PlotData{2}=squeeze(OccMData(ii,WT,2));
             PlotData{3}=squeeze(OccMData(ii,AD,1));
             PlotData{4}=squeeze(OccMData(ii,AD,2));
             SubFunPlotErrorBar(x,PlotData,[],ComColor(ii,:),2,Datatype,GroupPair,RGroupID);

             set(gca,'ylim',[0.2 0.6],'ytick',P.yTick,'yticklabel',[]);
 end
        clear PlotData

papersizePX=[0 0 12 16];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'TranOccData'],'png'); 
%%%%%%%%%%%For Fig S11 AB







%%%%Load ColorShade for HeatMap 
load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\colorMapPN.mat')
%%%%Load ColorShade for HeatMap 



%%%%%%%%%%%For Fig3F

SpaBinNum=6; %%%Spatial Bin Num.
Dim1=3;   %%%%Num. of TG states.


figure;
color1=colorMapBR2(1:2:end,:);  %%%%%%%Currently
% color1=colorTest2(1:2:end,:);

Clim=[-0.1 0.1];
PPdy=[0.01 0.01 0.01 0.01];
for t=1:SpaBinNum
clear occtemp trantemp
for i=1:Dim1
    temp=SpaMapOcc{2,i}-SpaMapOcc{1,i};     %%%%%%%%Correct-Incorrect difference for state i; 
    occtemp(i)=nanmean(temp(WT,t));
    for j=1:Dim1
        
    temp=SpaMapTran{2,i,j}-SpaMapTran{1,i,j};  %%%%%%%%Correct-Incorrect difference for state i->j transition; 
    trantemp(i,j)=nanmean(temp(WT,t));
    end
end

subplotLU(1,SpaBinNum,1,t,PPdy)
[G,p]=MarkovState_HeatPlot(trantemp,occtemp,ComColor,color1,Clim)
end
papersizePX=[0 0 3*SpaBinNum 3];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'WTSpatialDynamic'],'png'); 
%%%%%%%%%%%For Fig3F



%%%%%%%%%%%For Fig4E
figure;
for t=1:SpaBinNum
clear occtemp trantemp
for i=1:Dim1
    temp=SpaMapOcc{2,i}-SpaMapOcc{1,i};
    occtemp(i)=nanmean(temp(AD,t));
    for j=1:Dim1
        
    temp=SpaMapTran{2,i,j}-SpaMapTran{1,i,j};
    trantemp(i,j)=nanmean(temp(AD,t));
    end
end

subplotLU(1,SpaBinNum,1,t,PPdy)
[G,p]=MarkovState_HeatPlot(trantemp,occtemp,ComColor,color1,Clim)
end
papersizePX=[0 0 3*SpaBinNum 3];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath 'ADSpatialDynamic'],'png'); 
%%%%%%%%%%%For Fig4E




%%%%%%%%%%%For Fig S11 EF
GenoAnimal={WT AD};
GenoName={'WT' 'AD'};

SpaBin=[0:30:150]+15;

PlotColor2=[0.4 0.4 0.4;0.02 0.95 0.02;];
PlotColor3=[1 1 1;1 1 1];
PlotColor4={PlotColor2 PlotColor3};

Param2.TimeCol=SpaBin;
Param2.Paired=1;
Param2.BinName='Spa';
Param2.Bin=SpaBin;
Param2.Ytick=[0:0.1:0.2];


Param2.PlotType=4;

for iG=1:length(GenoAnimal)
figure;

%%%%%Plot Occurence Data
for i=1:Dim1
    subplotLU(Dim1+1,Dim1,1,i);
clear DataPlot
    DataPlot{1}=SpaMapOcc{1,i}(GenoAnimal{iG},:);   %%%%%%Plot Occurence Data
    DataPlot{2}=SpaMapOcc{2,i}(GenoAnimal{iG},:);

Param2.Ytick=[0 5];
Param2.SigPlot='Ttest';
Param2.LimY=[0 0.5];

SubFunRateHist_GroupPlot(SpaBin,DataPlot,PlotColor2,Param2);
set(gca,'xlim',[0 180],'ylim',[0 0.5],'xtick',SpaBin,'xticklabel',[]); 
if i~=1
   set(gca,'yticklabel',[]);
end
hold on;
%%%%%Plot Occurence Data


%%%%%Plot Tranisition Data
for j=1:Dim1
        subplotLU(Dim1+1,Dim1,i+1,j);
        
Param2.Ytick=[0.2 0.4];
    clear DataPlot     
    DataPlot{1}=SpaMapTran{1,i,j}(GenoAnimal{iG},:);
    DataPlot{2}=SpaMapTran{2,i,j}(GenoAnimal{iG},:);

    SubFunRateHist_GroupPlot(SpaBin,DataPlot,PlotColor2,Param2);

set(gca,'xlim',[0 180],'ylim',[0.0 0.5],'xtick',SpaBin,'xticklabel',[]);   
if j~=1
   set(gca,'yticklabel',[]);
end
    end
end
%%%%%Plot Tranisition Data

 papersizePX=[0 0 18 20]/2;
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath GenoName{iG} 'DynData'],'png'); 
end
%%%%%%%%%%%For Fig S11 EF




