clear all

load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\GDIandPPC.mat')
SavePath='C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\FigGDI\';
mkdir(SavePath);

binPos=1:2:360;   %%%%%%%%%Center of 180 Spatial Bin (0-360 Degree)

xc=-2:0.05:2;
Param.SignY=0.3;
Param.Plot=1;
Param.Std=1;      %%%%%%%%%using standard deviation as errorbar
Param.alpha=0.3; %%%%%%%%%Dash line for paired comparison sample
Param.Normalized=1; %%%%%%%%%0 by counts;1 by percentage;


   close all   
   P.xLeft=0.08;
   P.xRight=0.02;
   P.yTop=0.02;
   P.yBottom=0.06;
   P.xInt=0.08;
   P.yInt=0.02;





SavePath1=[SavePath 'Corr\'];
mkdir(SavePath1);
clear rdata pdata
close all

[Peak,PeakBin]=max(CellAllProp.SpaMap');


Peak=nanmax(CellAllProp.SpaMap');
NormSpaMap=(CellAllProp.SpaMap)./repmat(Peak(:),1,length(binPos));


ClimCell{1}=[0.4 0.9];
ClimCell{2}=[0.4 0.9];


HalfN=size(CellAllProp.SpaMap,2)/2;    %%%%%%%%
QuarterMap={};
for iqq=1:4
    QuarterMap{iqq}=CellAllProp.SpaMap(:,[1:HalfN/2]+(iqq-1)*HalfN/2);
end

%%Average the iqq quater and the jqq of spatial map, and sort the maxiumal firing bin. This provide infro. for later organization of raw spatial map
%%for true goal and flase goal similarity
for iqq=1:4
    for jqq=iqq+1:4
        Map90Mat{iqq,jqq}=(QuarterMap{iqq}+QuarterMap{jqq})/2;
        [Peak90Mat{iqq,jqq},Peak90MatBin{iqq,jqq}]=max(Map90Mat{iqq,jqq}');
    end
end



%%Average the iqq quater and the jqq of spatial map, and sort the maxiumal firing bin. This provide infro. for later organization of raw spatial map
%%for goal similarity
Map180=(CellAllProp.SpaMap(:,1:HalfN)+CellAllProp.SpaMap(:,[1:HalfN]+HalfN))/2;
[Peak180,PeakBin180]=max(Map180');


% % Map90Z1=(CellAllProp.SpaMap(:,1:HalfN/2)+CellAllProp.SpaMap(:,[1:HalfN/2]+HalfN/2))/2;
% % Map90Z2=(CellAllProp.SpaMap(:,[1:HalfN/2]+HalfN)+CellAllProp.SpaMap(:,[1:HalfN/2]+HalfN*3/2)/2)/2;
% % 
% % 

% % Map90=(Map90Z1+Map90Z2)/2;
[Peak,PeakBin]=max(CellAllProp.SpaMap');
[Peak180,PeakBin180]=max(Map180');
% % [Peak90Z1,PeakBin90Z1]=max(Map90Z1');
% % [Peak90Z2,PeakBin90Z2]=max(Map90Z2');
% % [Peak90,PeakBin90]=max(Map90');

CorrType={'Pearson','Spearman'};

SimiAllRaw=SimiAll;
QuarterSimiRaw=QuarterSimi;

%%%%%%%Fisher Transform of Pearson correlation
SimiAll=atanh(SimiAllRaw);
QuarterSimi=atanh(QuarterSimiRaw);
%%%%%%%Fisher Transform of Pearson correlation


close all
%%%%%%%%%%%%Previously used snowflake plot
iD=1;
Pth=0.1;
%%%%%%%%%%%%Previously used snowflake plot

TopNum=40;     %%%%%Plot Top 40 Cells in Similarity

close all

CellSpa=CellInc{1};   %%%%%%%%%cells included in spatial analysis,
GenoG=[1 2];        %%%%%%%%%1 for WT, 2 for AD
GenoName={'WT' 'AD'};
CellG=[1 0];        %%%%%%%%%1 for place cell, 0 for non-place cell
CellName={'Place' 'Nonplace'};

SavePath2=[SavePath 'RowPlot\'];
mkdir(SavePath2)

%%%%%%%%%%%%Fig1 AC; Fig S14 AC
for iG=1:length(GenoG)
    pAll=[];

   DisX=-1:0.1:1;
   P2.xLeft=0.01;
   P2.xRight=0.01;
   P2.yTop=0.01;
   P2.yBottom=0.01;
   P2.xInt=0.03;
   P2.yInt=0.01;

for iCell=1:length(CellG)
% %        i=PlotI(ii);

       CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
       CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
       length(CellI)

       DataCal=[];
       DataN1={};
       DataMat={};
       SampleMat={};
       BarP={};
       NodeX={};
       NodeY={};
       

       NeedSimiI=[1 2;3 4];
       for iii=1:length(NeedSimiI)
        iqq=NeedSimiI(1,iii);jqq=NeedSimiI(2,iii);
        DataCal(:,end+1)=squeeze(QuarterSimi(CellI,iqq,jqq));
        DataN1{end+1}=['SimiQuarter' num2str(iqq) '-' num2str(jqq)];  
       [~,I]=sort(squeeze(QuarterSimi(CellI,iqq,jqq)),'descend');
        TopNum1=min([TopNum length(I)]);
        II=I(1:TopNum1);
        CellTemp=sort(CellI(II));
        [~,s1]=sort(Peak90MatBin{iqq,jqq}(CellTemp),'descend');
        SampleMat{end+1}=NormSpaMap(CellTemp(s1),:);
        BarP{end+1}=[iqq;jqq];
        
        
        NodeX{end+1}='Position Degree';
        NodeY{end+1}(1,:)='     Cell ID    ';
        NodeY{end}(2,:)='Top40 Similarity';
       
       end


        DataCal(:,end+1)=squeeze(SimiAll(CellI,:));
        DataN1{end+1}=['SimiZ1-Z2'];
        [~,I]=sort(SimiAll(CellI),'descend');
        TopNum1=min([TopNum length(I)]);
        II=I(1:TopNum1);
        CellTemp=sort(CellI(II));
        [~,s1]=sort(PeakBin180(CellTemp),'descend');
        SampleMat{end+1}=NormSpaMap(CellTemp(s1),:);
        BarP{end+1}=[1 2;3 4];
        NodeX{end+1}='Position Degree';
        NodeY{end+1}(1,:)='     Cell ID    ';
        NodeY{end}(2,:)='Top40 Similarity';

               DataCal(:,end+1)=SpaSig(CellI);   
       DataN1{end+1}='SpaInfo Sig.';
       CellTemp=sort(CellI);
        [~,s1]=sort(PeakBin(CellTemp),'descend');
        SampleMat{end+1}=NormSpaMap(CellTemp(s1),:);
        BarP{end+1}=[];
        NodeX{end+1}='Position Degree';
        NodeY{end+1}='Cell ID All';

  
       

       
       iN=4;
       figure;    
       subplot('position',[0.01 0.01 0.98 0.98]);
       imagesc(SampleMat{iN});axis xy;hold on;
       colormap(gray)       %%%%%%%GlobalMap

       set(gca,'xlim',[0 size(SampleMat{iN},2)],'ylim',[0 size(SampleMat{iN},1)])

       set(gca,'clim',ClimCell{iCell},'xtick',[0:45:180],'xticklabel',[],'ytick',[0 size(SampleMat{iN},1)],'yticklabel',[]);

       papersizePX=[0 0 6.5 3.2];
       set(gcf, 'PaperUnits', 'centimeters');
       set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
       saveas(gcf,[SavePath2 'GlobalSpa' GenoName{iG} CellName{iCell}],'png'); 


       %%%%%%%GlobalMap

       
       PlotSeq=[3 1 2];
       figure;
       for iNN=1:length(PlotSeq)
           
       
           
       subplotLU(1,length(PlotSeq),1,iNN,P2);
       iN=PlotSeq(iNN);
       
       
       imagesc(SampleMat{iN});axis xy;hold on;
       set(gca,'xlim',[0 size(SampleMat{iN},2)],'ylim',[0 size(SampleMat{iN},1)])
       colormap(gray)
       set(gca,'clim',ClimCell{iCell},'xtick',[0:45:180],'xticklabel',[],'ytick',[0 size(SampleMat{iN},1)],'yticklabel',[]);
       
    end
       papersizePX=[0 0 14 2.5];
       set(gcf, 'PaperUnits', 'centimeters');
       set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
       saveas(gcf,[SavePath2 'MultiPlex' GenoName{iG} CellName{iCell}],'png'); 
end


end
%%%%%%%%%%%%Fig1 AC; Fig S14 AC













%%%%%%%%%%%DiscriI, Goal discrimination Index (GDI);
temp1=(squeeze(QuarterSimi(:,2,4)));         %%%%True goal similarity
temp2=(squeeze(QuarterSimi(:,1,3)));         %%%%False goal similarity


DiscriI=(temp1-temp2)./(abs(temp1)+abs(temp2));    %%%%GDI
SavePath3=[SavePath 'GDIsimi\'];
mkdir(SavePath3)
GroupPair.SignY=0.38;
LimY=[-0.4 0.4];
%%%%%%%%%%%DiscriI, Goal discrimination Index (GDI);


 
labeltemp={};
THSimi=[-1 0:0.1:0.3];   %%%%Threshold of Goal similarity to include cells, noted this is for Raw similarity value (from -1 to 1), not the fisher transform.
for iTh=1:length(THSimi)
    labeltemp{iTh}=['SimiGoalTh',showNum(THSimi(iTh),1)];
end

clear GroupPair
%%%%%%%%%%%%Fig1D left panel; Fig S14D left panel
 for iG=1:length(GenoG)
    DataCom={};

     for iTh=1:length(THSimi)
     g1=[];  %%%%%%%%geno
     g2=[];  %%%%%%%%celltype
     dataTemp=[];
    
     


         for iCell=1:length(CellG)

             CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
             CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
             Index2=find(SimiAllRaw>=THSimi(iTh));  %%%%Threshold of Goal similarity to include cells, noted this is for Raw similarity value (from -1 to 1), not the fisher transform.
             CellI=intersect(CellI,Index2);
             nSimi{iG}(iCell,iTh)=length(CellI);  %%%%%Num. of Cells

                         
              DataCom{end+1}=DiscriI(CellI);
                    
         end

   
     end
     
x1=[2:length(THSimi)];
x2=x1+0.3;
x=sort([x1 x2]);
x=[0.5 0.8 x];
   clear tempPair
   tempPair(1,:)=[1:2:length(DataCom)];
   tempPair(2,:)=[2:2:length(DataCom)];

   GroupPair.Pair=tempPair;
   GroupPair.SignY=0.36;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=0; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=0; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker=repmat({'d','s'},1,length(THSimi));
   RGroupID=1:length(DataCom);
   Color1=repmat([0.8 0.8 0.8;0.1 .1 0.1],length(THSimi),1);
figure;
subplot('position',[0.05 0.05 0.9 0.9])
SubFunPlotErrorBar(x,DataCom,[],Color1,2,0,GroupPair,RGroupID);
hold on;
plot([0 8],[0 0],'k:')
set(gca,'ylim',[-0.4 0.4],'ytick',[-0.4:0.2:.4],'xtick',[0.65 (x1+x2)/2],'xticklabel',labeltemp,'box','off','xlim',[0 6])
set(gca,'yticklabel',[],'xticklabel',[])

papersizePX=[0 0 14 8];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath3 GenoName{iG} 'GDIvsGoalSimi' ],'png'); 


 end
%%%%%%%%%%%%Fig1D left panel; Fig S14D left panel

 

%%%%%%%%%%%%FigS4A
figure;
for iTh=1:length(THSimi)
     g1=[];  %%%%%%%%geno
     g2=[];  %%%%%%%%celltype
     dataTemp=[];
    
     
     for iG=1:length(GenoG)

         subplotLU(length(GenoG),length(THSimi),iG,iTh)
         SubCom={};

         for iCell=1:length(CellG)

             CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
             CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
             Index2=find(SimiAllRaw>=THSimi(iTh));  %%%%Threshold of Goal similarity to include cells, noted this is for Raw similarity value (from -1 to 1), not the fisher transform.
             CellI=intersect(CellI,Index2);
                    
              SubCom{end+1}=squeeze(real(QuarterSimi(CellI,1,3)));      %%%%%False Goal Similarity
              dataTemp=[dataTemp;SubCom{end}];
              
              SubCom{end+1}=squeeze(real(QuarterSimi(CellI,2,4)));      %%%%%True Goal Similarity
              dataTemp=[dataTemp;SubCom{end}];
     
              
                    
         end
         
%    SubCom=SubCom([1 3 2 4]);%%%%%%%%%% re-organize to Simi(1-3) for place and non-place cell Simi 2-4 for place and non-place cell
         
         
   RGroupID= [1 1 2 2];   %%%repeated groupID;
   GroupPair.Pair=[];
   GroupPair.SignY=0.5;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=0; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=0; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker={'d' 'd' 's' 's'};
   GroupPair.SignY=[0.5 0.88];
   GroupPair.LimY=[0 1];
   GroupPair.Pair=[1 3 1 2;2 4 3 4];

%    PlotColor2=[0.1 0.1 0.1;0.5 0.1 0.1;0.1 0.1 0.1;0.5 0.1 0.1];
%    PlotColor2=[0.8 0.8 0.8;0.1 .1 0.1;0.8 0.8 0.8;0.1 .1 0.1];
   PlotColor3{1}=[0.8 0.8 0.8;0.8 0.8 0.8;0.1 .1 0.1;0.1 .1 0.1];
   PlotColor3{2}=[1 1 1;0.8 0.8 0.8;1 1 1;0.1 .1 0.1];

%    PlotColor2=[0.8 0.8 0.8;0.8 0.8 0.8;0.1 .1 0.1;0.1 .1 0.1];

   LimY=[0 1];
   Dy=diff(LimY)/4;
   x=[1 1.4 2 2.4];
   SavePathTemp=[SavePath  GenoName{iG} labeltemp{iTh} '.txt'];
   SubFunPlotErrorBar(x,SubCom,[],PlotColor3,2,1,GroupPair,RGroupID);

 
   set(gca,'ylim',LimY,'ytick',LimY(1):Dy:LimY(2),'xtick',[1.2 2.2],'xlim',[x(1)-0.2 x(end)+0.2],'xticklabel',[],'box','off');
   set(gca,'xticklabel',[],'yticklabel',[])
   
   
     end
     


 end
papersizePX=[0 0 25 15];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath  'SimiQuaterSimiGoalSimiTh'],'png'); 
%%%%%%%%%%%%FigS4A








labeltemp={};

THSimi=[0:2:8];    %%%%%%Threshold of Spatial Significance to include cells
for iTh=1:length(THSimi)
    labeltemp{iTh}=['SpaSigTh',showNum(THSimi(iTh),1)];
end

%%%%%%%%%%%%Fig1D right panel; Fig S14D right panel
 for iG=1:length(GenoG)
    DataCom={};

     for iTh=1:length(THSimi)
     g1=[];  %%%%%%%%geno
     g2=[];  %%%%%%%%celltype
     dataTemp=[];
    
     


         for iCell=1:length(CellG)


             CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
             CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
              Index2=find(SpaSig>=THSimi(iTh));
              CellI=intersect(CellI,Index2);
               nSpaSig{iG}(iCell,iTh)=length(CellI); %%%%Num. of Cells
              
              DataCom{end+1}=DiscriI(CellI);
                    
         end

   
     end
     
x1=[1:length(THSimi)];
x2=x1+0.3;
x=sort([x1 x2]);
   clear tempPair
   tempPair(1,:)=[1:2:length(DataCom)];
   tempPair(2,:)=[2:2:length(DataCom)];

   GroupPair.Pair=tempPair;
   GroupPair.SignY=0.36;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=0; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=0; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker=repmat({'d','s'},1,length(THSimi));
   RGroupID=1:length(DataCom);
   Color1=repmat([0.8 0.8 0.8;0.1 .1 0.1],length(THSimi),1);
figure;
subplot('position',[0.05 0.05 0.9 0.9])
SubFunPlotErrorBar(x,DataCom,[],Color1,2,0,GroupPair,RGroupID);
hold on;
plot([0 8],[0 0],'k:')
set(gca,'ylim',[-0.4 0.4],'ytick',[-0.4:0.2:.4],'xtick',[(x1+x2)/2],'xticklabel',labeltemp,'box','off','xlim',[0 6])
set(gca,'yticklabel',[],'xticklabel',[])

papersizePX=[0 0 14 8];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath3 GenoName{iG} 'GDIvsSpaSig' ],'png'); 


 end
%%%%%%%%%%%%Fig1D right panel; Fig S14D right panel



%%%%%%%%%%%%FigS4B

figure;
for iTh=1:length(THSimi)
     g1=[];  %%%%%%%%geno
     g2=[];  %%%%%%%%celltype
     dataTemp=[];
    
     
     for iG=1:length(GenoG)

         subplotLU(length(GenoG),length(THSimi),iG,iTh)
         SubCom={};

         for iCell=1:length(CellG)


             CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
             CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
              Index2=find(SpaSig>=THSimi(iTh));
              CellI=intersect(CellI,Index2);
                    
              SubCom{end+1}=squeeze(real(QuarterSimi(CellI,1,3)));
              dataTemp=[dataTemp;SubCom{end}];
              
              SubCom{end+1}=squeeze(real(QuarterSimi(CellI,2,4)));
              dataTemp=[dataTemp;SubCom{end}];
     
              
                    
         end
   RGroupID= [1 1 2 2];   %%%repeated groupID;
   GroupPair.CorrName='fdr';
   GroupPair.Q=0.1;
   GroupPair.Pair=[];
   GroupPair.SignY=0.5;
   GroupPair.Plot=1;
   GroupPair.Std=0;      %%%%%%%%%using standard deviation as errorbar
   GroupPair.SamplePlot=0; %%%%%%%%%Plot Individual Sample Point
   GroupPair.SamplePairedPlot=0; %%%%%%%%%Dash line for paired comparison sample
   GroupPair.LimY=[0 GroupPair.SignY*1.2];
   GroupPair.Marker={'d' 'd' 's' 's'};
   GroupPair.SignY=[0.4 0.55];
   GroupPair.LimY=[0 0.58];
   GroupPair.Pair=[1 3 1 2;2 4 3 4];
   GroupPair.Crit_p=0.05;
%    PlotColor2=[0.8 0.8 0.8;0.1 .1 0.1;0.8 0.8 0.8;0.1 .1 0.1];
%    PlotColor2=[0.8 0.8 0.8;0.8 0.8 0.8;0.1 .1 0.1;0.1 .1 0.1];
   PlotColor3{1}=[0.8 0.8 0.8;0.8 0.8 0.8;0.1 .1 0.1;0.1 .1 0.1];
   PlotColor3{2}=[1 1 1;0.8 0.8 0.8;1 1 1;0.1 .1 0.1];

   LimY=[-0.2 0.6];
   Dy=diff(LimY)/4;
   x=[1 1.4 2 2.4];
   SavePathTemp=[SavePath  GenoName{iG} labeltemp{iTh} '.txt'];
   SubFunPlotErrorBar(x,SubCom,[],PlotColor3,2,1,GroupPair,RGroupID);
   set(gca,'ylim',LimY,'ytick',LimY(1):Dy:LimY(2),'xtick',[1.2 2.2],'xlim',[x(1)-0.2 x(end)+0.2],'xticklabel',[],'box','off');
   set(gca,'xticklabel',[],'yticklabel',[])
   
     end
     


 end
papersizePX=[0 0 25 15];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SavePath  'SimiQuaterSpaSigTh'],'png'); 
saveas(gcf,[SavePath  'SimiQuaterSpaSigTh.eps'],'epsc'); 
%%%%%%%%%%%%FigS4B









%%%%%%%%%%%%FigS15
DataPerf=[];
DataPerf(:,1)=SuccRCell;
CellMarker={'d','s'};
CellColor=[0.8 0.8 0.8;0.1 .1 0.1];
DataPerfN={'SuccR'};
SaveP1=[SavePath 'GDIvsSuccR\'];
mkdir(SaveP1);
DataScale=[0.2 0.6 1];
Param.Color=[0.2 0.2 0.2];
Param.Marker='o';
Param.MarkerSize=6;
Param.Rtype='spearman';
Param.xLabel=[];
Param.yLabel=[];
   P.xLeft=0.06;
   P.xRight=0.02;
   P.yTop=0.05;
   P.yBottom=0.1;
   P.xInt=0.04;
   P.yInt=0.1; 
   figure;
   %%%%%%%%%%Merge WT and AD
for iCell=1:length(CellG)
        CellI=intersect(CellSpa,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
        
        Param.Marker=CellMarker{iCell};
        Param.Color=CellColor(iCell,:);

        
        clear data1 data2
        subplotLU(2,3,iCell,1,P);
        data1=SuccRCell(CellI);
        data2=DiscriI(CellI);
        length(data1)
        data3=DataPerf(CellI,end);

        Param.xLim=DataScale([1 end]);
        Param.yLim=[-1 1];

        LuPairRegressPlot(data1(:),data2(:),Param);
        set(gca,'xtick',DataScale,'xlim',DataScale([1 end]),'ylim',[-1 1],'ytick',[-1:0.5:1]);
        set(gca,'xticklabel',[],'yticklabel',[]);
        box off
        if iCell==1
           set(gca,'xticklabel',[])            
        else
%            xlabel(DataPerfN{iData});  
        end
        

   end
   %%%%%%%%%%Merge WT and AD

%%%%%%%%%%separate WT and AD
DataNeedI=[1];
for iCell=1:length(CellG)
    
        Param.Marker=CellMarker{iCell};
        Param.Color=CellColor(iCell,:);

for iG=1:length(GenoG)
   


             CellI=intersect(CellSpa,find(GenoCell==GenoG(iG)));   %%%Genotype
             CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
       
        clear data1 data2
        subplotLU(2,3,iCell,iG+1,P);

        data1=SuccRCell(CellI);
        data2=DiscriI(CellI);

        length(data1)
        Param.xLim=DataScale([1 end]);
        Param.yLim=[-1 1];

        LuPairRegressPlot(data1(:),data2(:),Param);
        set(gca,'xtick',DataScale,'xlim',DataScale([1 end]),'ylim',[-1 1],'ytick',[-1:0.5:1]);
        box off
        set(gca,'xticklabel',[],'yticklabel',[]);

        box off
        if iG==1
           set(gca,'xticklabel',[])
           
        elseif iG==2
   
        end
        

end


end
%%%%%%%%%%separate WT and AD

papersizePX=[0 0 (length(DataNeedI)+2)*3.5+1 8];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveP1 'Raw' Param.Rtype 'AllGDIvsPerformance'],'png'); 

%%%%%%%%%%%%FigS15








