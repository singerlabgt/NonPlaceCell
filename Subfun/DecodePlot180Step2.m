function DecodePlot180Step2(Data,Geno,GenoName,ParamN,NumBin,SaveFolder1)
%%%%%%

SpaBin=ParamN.SpaBin;


ColorP1{1}=[0.6 0.1 0.8;0.7 0.7 0.7;0.1 .1 0.1];
ColorP1{2}=ColorP1{1};


%%%%%%%%%%General parameter setting for rate-histogram;
Param.PlotType=3;
                             
Param.TimeCol=SpaBin;        %%%x axis is spatial bin
Param.Paired=1;              %%%Paired 
Param.BinName='Actual Position';
Param.Bin=SpaBin;            %%%x axis is spatial bin
Param.Ytick=[0:1:4];     %%%Y axis stick
%%%%%%%%%%General parameter setting for rate-histogram;
   GroupPair.SignY=2.5;
   GroupPair.Pair=[];
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=1; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 4];
   GroupPair.Marker={'o','d','s'};
   


Param.GroupPair=GroupPair;



%%%%%%
for iG=1:length(Geno)


PopName={'All','DelPF','DelNPF'};
   P.xLeft=0.06;
   P.xRight=0.02;
   P.yTop=0.06;
   P.yBottom=0.02;
   P.xInt=0.02;
   P.yInt=0.02;







AnimalI=Geno{iG};
HFstep=[0 0]; %%%%%%%%%decoded as position within interval 0 bin before and 0 bin after the actual position (exactly the current bin) was consider as good decoding; 
count=0;
clear DataRes

for Spai=1:length(SpaBin)
    ROI=[Spai+HFstep(1):Spai+HFstep(2)];    
    ROI=mod(ROI,length(SpaBin));
    ROI(ROI==0)=length(SpaBin);
    DataRes{1}(:,Spai)=squeeze(nanmean(Data.All(AnimalI,ROI,Spai),2));
    DataRes{2}(:,Spai)=squeeze(nanmean(Data.deletePF(AnimalI,ROI,Spai),2));
    DataRes{3}(:,Spai)=squeeze(nanmean(Data.deleteNPF(AnimalI,ROI,Spai),2));
end   

clear DataResBinAll;
DataResBinAll{1}=mean(DataRes{1},2);
DataResBinAll{2}=mean(DataRes{2},2);
DataResBinAll{3}=mean(DataRes{3},2);


tempP3.Bin=1;
tempP3.TimeCol=1;



Datatype=1;
figure;
subplot('position',[0.02 0.02 0.96 0.96]);
GroupPair1=GroupPair;
GroupPair1.SignY=2.5;
GroupPair1.LimY=[1 2.5];
if iG==2
  GroupPair1.SignY=2.5;
  GroupPair1.LimY=[0.5 3.5];
  
    
end

SubFunPlotErrorBar(1:3,DataResBinAll,[],ColorP1,2,Datatype,GroupPair1,[1 1 1])
StepY=1-GroupPair1.LimY(1);
tempLimYMax=min(find(StepY*[1:6]-diff(GroupPair1.LimY)>=0)); 
tempLimYMax=GroupPair1.LimY(1)+tempLimYMax*StepY;
tempYTick=GroupPair1.LimY(1):StepY:tempLimYMax;

set(gca,'ylim',[0 4],'xlim',[0 4],'box','off')
set(gca,'ylim',[GroupPair1.LimY(1) GroupPair1.LimY(2)],'xlim',[0 4],'xtick',1:3,'ytick',[1 2],'yticklabel',[],'xticklabel',[]);
papersizePX=[0 0 3.5 5];


if iG==2
  set(gca,'ylim',[GroupPair1.LimY(1) GroupPair1.LimY(2)+0.4],'xlim',[0 5],'xtick',1:3,'ytick',0.5:1:3.5,'yticklabel',[],'xticklabel',[]);
end
papersizePX=[0 0 3.5 5];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'CurrDec'],'png'); 







tempP3=Param;
tempP3.Bin=1;
tempP3.TimeCol=1;

Datatype=1;
  
AnimalI=Geno{iG};
count=0;
clear DataRes


%%%%%%%%%%Decode as goal zone
for Spai=1:length(SpaBin)
    ROI=[31:36];    %%%%%%%%True Goal Zone Spatial Bin Index
  DataRes{1}(:,Spai)=squeeze(nanmax(Data.All(AnimalI,ROI,Spai),[],2));
  DataRes{2}(:,Spai)=squeeze(nanmax(Data.deletePF(AnimalI,ROI,Spai),[],2));
  DataRes{3}(:,Spai)=squeeze(nanmax(Data.deleteNPF(AnimalI,ROI,Spai),[],2));

end   
%%%%%%%%%%Decode as goal zone


clear DataResBin30;
[m,n]=discretize(SpaBin,NumBin);
[IBin30,n]=discretize(SpaBin,NumBin);
Spa30Bin=(n(1:end-1)+n(2:end))/2;
SpaBinWidth=round(mean(diff(Spa30Bin)));
for Spai=1:length(n)-1
    DataResBin30{1}(:,Spai)=mean(DataRes{1}(:,IBin30==Spai),2);
    DataResBin30{2}(:,Spai)=mean(DataRes{2}(:,IBin30==Spai),2);
    DataResBin30{3}(:,Spai)=mean(DataRes{3}(:,IBin30==Spai),2);
end   




% tempP3=Param;
tempP3.GroupPair=GroupPair;

figure;
subplot('position',[0.02 0.02 0.96 0.96]);
tempP3.PlotType=7;
tempP3.Ytick=[0:4];
tempP3.Bin=Spa30Bin;
tempP3.TimeCol=Spa30Bin;
tempP3.GroupPair.SignY=2.5;
if iG==1
tempP3.GroupPair.LimY=[0.8 3.1];
tempP3.GroupPair.SignY=2.1;
else
tempP3.GroupPair.LimY=[0.8 3.9];
tempP3.GroupPair.SignY=3.4;
    
end
StepY=1-tempP3.GroupPair.LimY(1);
tempLimYMax=min(find(StepY*[1:6]-diff(tempP3.GroupPair.LimY)>=-0.000001));
tempLimYMax=tempP3.GroupPair.LimY(1)+tempLimYMax*StepY;
tempYTick=tempP3.GroupPair.LimY(1):StepY:tempLimYMax;
SubFunRateHist_GroupPlot(Spa30Bin,DataResBin30(1),ColorP1{1},tempP3);


set(gca,'xlim',[0 180],'xtick',[0:30:180],'ylim',[tempP3.GroupPair.LimY(1) tempP3.GroupPair.LimY(2)+0.1],'ytick',tempYTick,'yticklabel',[]);
if iG==2
set(gca,'xlim',[0 180],'xtick',[0:30:180],'ylim',[tempP3.GroupPair.LimY(1) tempP3.GroupPair.LimY(2)+0.4],'ytick',[0.5:1:3.5],'yticklabel',[]);
    
end

papersizePX=[0 0 9 4];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'GoalRawBin' num2str(SpaBinWidth)],'png'); 







clear DataResBin30N
    DataResBin30N{1}=(zeros(size(DataResBin30{1}))+1-DataResBin30{1});   %%%%Chance Level
    DataResBin30N{2}=(DataResBin30{2}-DataResBin30{1});
    DataResBin30N{3}=(DataResBin30{3}-DataResBin30{1});
tempP3.GroupPair=GroupPair;

figure;
subplot('position',[0.02 0.02 0.96 0.96]);
tempP3.PlotType=7;
tempP3.Ytick=[0:4];
tempP3.Bin=Spa30Bin;
tempP3.TimeCol=Spa30Bin;
tempP3.GroupPair.SignY=2;
if iG==1
tempP3.GroupPair.LimY=[-0.6 0.3];
tempP3.GroupPair.SignY=0.2;
else
tempP3.GroupPair.LimY=[-0.4 0.2];
tempP3.GroupPair.SignY=0.2;
    
end
StepY=1-tempP3.GroupPair.LimY(1);
tempLimYMax=min(find(StepY*[1:6]-diff(tempP3.GroupPair.LimY)>=-0.000001));
tempLimYMax=tempP3.GroupPair.LimY(1)+tempLimYMax*StepY;
tempYTick=tempP3.GroupPair.LimY(1):StepY:tempLimYMax;


ColorP2=ColorP1{1}(2:3,:);

tempP3=tempP3;
tempP3.GroupPair.Marker={'d' 's'};
tempP3.GroupPair.SamplePlot=0;
tempP3.GroupPair.SamplePairedPlot=0;
tempP3.PlotType=2;
tempP3.Marker={'d' 's'};

SubFunRateHist_GroupPlot(Spa30Bin,DataResBin30N(2:3),ColorP2,tempP3);
hold on;
plot(Spa30Bin,mean(DataResBin30N{2}),'-','color',ColorP1{1}(2,:))
plot(Spa30Bin,mean(DataResBin30N{3}),'-','color',ColorP1{1}(3,:))

set(gca,'xlim',[0 180],'xtick',[0:30:180],'ylim',[tempP3.GroupPair.LimY(1) tempP3.GroupPair.LimY(2)+0.1],'ytick',[-0.4:0.2:0.4],'yticklabel',[]);
if iG==2
set(gca,'xlim',[0 180],'xtick',[0:30:180],'ylim',[tempP3.GroupPair.LimY(1) tempP3.GroupPair.LimY(2)+0.1],'ytick',[-0.4:0.2:0.4],'yticklabel',[]);
    
end

papersizePX=[0 0 9 4];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'GoalAmpBin' num2str(SpaBinWidth)],'png'); 


end

