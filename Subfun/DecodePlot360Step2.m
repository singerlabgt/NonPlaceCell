function DecodePlot360Step2(Data,Geno,GenoName,ParamN,SaveFolder1)
%%%%%%

SpaBin=ParamN.SpaBin;
ColorP1{1}=[0.6 0.1 0.8;0.6 0.6 0.6;0.1 .1 0.1];
ColorP1{2}=[0.6 0.1 0.8;1 1 1;1 1 1];
ColorP1{2}=ColorP1{1};



%%%%%%%%%%General parameter setting for rate-histogram;
   GroupPair.Pair=[];
   GroupPair.SignY=3.5;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=1; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=1; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[1 3];
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
tempSave=[SaveFolder1 GenoName{iG} 'CurrDecAll.txt'];
GroupPair1=GroupPair;
GroupPair1.SignY=2.7;
GroupPair1.LimY=[1 2.7];
if iG==2   
  GroupPair1.SignY=2.5;
  GroupPair1.LimY=[1 3.5];
end


SubFunPlotErrorBar(1:3,DataResBinAll,[],ColorP1,2,Datatype,GroupPair1,[1 1 1])
set(gca,'ylim',[GroupPair1.LimY(1) GroupPair1.LimY(2)],'xlim',[0 4],'xtick',1:3,'ytick',[1 2],'yticklabel',[],'xticklabel',[],'box','off');

papersizePX=[0 0 3.5 5];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'CurrDecAll'],'png'); 





end
close all
