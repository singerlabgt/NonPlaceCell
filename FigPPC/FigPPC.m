clear all

load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\GDIandPPC.mat')
SavePath='C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\FigPPC\';

%%%%Data PPCspa is 4D: [CellID Fre SpaBin Incorrect&Correct]
FrePlot=mean(passband);
CellPPCInc=CellInc{2};   %%%%%%%%%cells included in spatial PPC analysis,
GenoG=[1 2];        %%%%%%%%%1 for WT, 2 for AD
GenoName={'WT' 'AD'};
CellG=[1 0];        %%%%%%%%%1 for place cell, 0 for non-place cell
CellName={'Place' 'Nonplace'};

mkdir(SavePath);


SpaBinNum=round(180/30);
PlotColor2=[0.4 0.4 0.4;0.02 0.95 0.02;];
PlotColor3=[1 1 1;1 1 1];
PlotColor4={PlotColor2 PlotColor3};

Param2.PlotType=4;
Param2.LegendShow=0;
Param2.Legend=[];
Param2.TimeCol=FrePlot;
Param2.Paired=1;
Param2.BinName='Fre';
Param2.Bin=FrePlot;
Param2.TimeComparison=0;
Param2.Ytick=[0:0.1:0.2];

ylimC=[-0.001 0.004;-0.001 0.003];

%%%%%%%%%%Param for Subplot
P.xLeft=0.01;
P.xRight=0.01;
P.yTop=0.01;
P.yBottom=0.01;
P.xInt=0.02;
P.yInt=0.02;
%%%%%%%%%%Param for Subplot



close all

%%%%%%%%%%Fig 3C; Fig S18B

for iG=1:length(GenoG)

for iCell=1:length(CellG)
% %        i=PlotI(ii);

       CellI=intersect(CellPPCInc,find(GenoCell==GenoG(iG)));   %%%Genotype
       CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place
     figure;

         for ip=1:SpaBinNum

         subplotLU(1,SpaBinNum,1,ip,P)
    
    Param2.Ytick=ylimC(iCell,:);
    clear DataPlot
    DataPlot{1}=squeeze(PPCspa(CellI,:,ip,1));      %%%%%%Incorrect Trial
    DataPlot{2}=squeeze(PPCspa(CellI,:,ip,2));      %%%%%%Correct Trial
    SubFunRateHist_GroupPlot(FrePlot,DataPlot,PlotColor2,Param2);

    
    
    set(gca,'xlim',[-2 151],'xtick',0:50:150,'ylim',ylimC(iCell,:),'ytick',-0.001:0.001:ylimC(iCell,2),'xticklabel',[],'yticklabel',[])
    
         end
        papersizePX=[0 0 12 2.5];
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
        saveas(gcf,[SavePath GenoName{iG} CellName{iCell} 'PPCWR'],'tiff'); 

    end

end

%%%%%%%%%%Fig 3C; Fig S18B
















FreName={'delta' 'theta' 'beta' 'L1' 'L2' 'M1' 'M2' 'F1' 'F2' 'F3'};
BandPlotI{1}=2;     %%%%%%%%theta band Index  
BandPlotI{2}=2;     %%%%%%%%theta band Index  
BandPlotI{3}=[4:10]; %%%%%%%%gamma band Index  
BandPlotI{4}=[4:10]; %%%%%%%%gamma band Index  
BandY=[0 0.003;0 0.003;-0.001 0.002;-0.001 0.002];   %%%%Y axis Lim
iCCI{1}=1;     
iCCI{2}=2;
iCCI{3}=1;
iCCI{4}=2;
ip=3;              %%%%Spatial Bin 3, false goal zone;
P2.xLeft=0.01;
P2.xRight=0.01;
P2.yTop=0.01;
P2.yBottom=0.01;
P2.xInt=0.01;
P2.yInt=0.03;
PlotColor3=[0.8 0.8 0.8;0.7 0.95 0.7;];
SessionI=[1 2];   %%%%%%Incorrect and correct sessions.

papersizePX=[0 0 18 6];
Param3=Param2;



%%%%%%%%%%Fig 4B left
figure;
P2.xInt=0.02;
for iP=1:2
    iCell=iCCI{iP};
    
     A = subplotLU(1,2,1,iP,P2);
     PositionA=A.Position;
     
    DataPlot={};
        for iss=1:length(SessionI)
        
             for iG=1:length(GenoG)
                  CellI=intersect(CellPPCInc,find(GenoCell==GenoG(iG)));   %%%Genotype
                  CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place

                 DataPlot{end+1}=squeeze(PPCspa(CellI,BandPlotI{iP},ip,SessionI(iss)));
             end
        end
    Param3.Paired=0;
    Param3.PathSave=[];
    Param3.TimeCol=BandPlotI{iP};
    Param3.Bin=BandPlotI{iP};
    Param3.Pair=[];
    Param3.Marker={'o','^'};
    Param3.Ytick=BandY(iP,:);

    SubFunRateHist_GroupPlot2V2(BandPlotI{iP},DataPlot([1 2]),[PlotColor2(1,:);PlotColor3(1,:)],Param3);

    hold on;
    
% % 
    SubFunRateHist_GroupPlot2V2(BandPlotI{iP}+0.35,DataPlot([3 4]),[PlotColor2(2,:);PlotColor3(2,:)],Param3);


    set(gca,'xlim',[BandPlotI{iP}(1)-0.4 BandPlotI{iP}(end)+0.6],'xtick',BandPlotI{iP},'xticklabel',[],'ylim',BandY(iP,:),'ytick',BandY(iP,1):0.001:BandY(iP,2),'yticklabel',[])

% 
end
        papersizePX=[0 0 3.5 2];
        papersizePX=[0 0 2 2];

        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
        saveas(gcf,[SavePath 'GenoPPCTheta'],'png'); 
%%%%%%%%%%Fig 4B left

 
%%%%%%%%%%Fig 4B right
figure;
P2.xInt=0.02;
for iP=3:length(BandPlotI)
    iCell=iCCI{iP};
    
     A = subplotLU(1,2,1,iP-2,P2);
     PositionA=A.Position;
     
    DataPlot={};
        for iss=1:length(SessionI)
        
             for iG=1:length(GenoG)
                 
                  CellI=intersect(CellPPCInc,find(GenoCell==GenoG(iG)));   %%%Genotype
                  CellI=intersect(CellI,find(CellAllProp.PlaceCellI==CellG(iCell))); %%%Place or Non-Place

                 DataPlot{end+1}=squeeze(PPCspa(CellI,BandPlotI{iP},ip,SessionI(iss)));

                 
             end
        end
%     end
    Param3.Paired=0;
    Param3.PathSave=[];
    Param3.TimeCol=BandPlotI{iP};
    Param3.Bin=BandPlotI{iP};
    Param3.Pair=[];
    Param3.Marker={'o','^'};
    Param3.Ytick=BandY(iP,:);

    SubFunRateHist_GroupPlot2V2(BandPlotI{iP},DataPlot([1 2]),[PlotColor2(1,:);PlotColor3(1,:)],Param3);

    hold on;
    SubFunRateHist_GroupPlot2V2(BandPlotI{iP}+0.35,DataPlot([3 4]),[PlotColor2(2,:);PlotColor3(2,:)],Param3);


    set(gca,'xlim',[BandPlotI{iP}(1)-0.4 BandPlotI{iP}(end)+0.6],'xtick',BandPlotI{iP},'xticklabel',[],'ylim',BandY(iP,:),'ytick',BandY(iP,1):0.001:BandY(iP,2),'yticklabel',[])

% 
end
        papersizePX=[0 0 7 2];
        papersizePX=[0 0 8.5 2];

        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
        saveas(gcf,[SavePath 'GenoPPCGamma'],'png'); 
%%%%%%%%%%Fig 4B right








