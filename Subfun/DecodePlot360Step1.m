function DecodePlot360Step1(Data,Geno,GenoName,ParamN,colorMapPN,SaveFolder1)
%%%%%%


SpaBin=ParamN.SpaBin;

Zone=[[60 90 150 180] [60 90 150 180]+180];


%%%%%%
for iG=1:length(Geno)


PopName={'All','DelPF','DelNPF'};
   P.xLeft=0.06;
   P.xRight=0.02;
   P.yTop=0.06;
   P.yBottom=0.02;
   P.xInt=0.02;
   P.yInt=0.02;

clear GenoPop;

Pop{1}=squeeze(nanmean(Data.All(Geno{iG},:,:),1));
Pop{2}=squeeze(nanmean(Data.deletePF(Geno{iG},:,:),1));
Pop{3}=squeeze(nanmean(Data.deleteNPF(Geno{iG},:,:),1));


   for iPP=1:length(Pop)

figure;
subplot('position',[0.02 0.02 0.96 0.96]);
imagesc(SpaBin,SpaBin,Pop{iPP});axis xy;
hold on;
for iZ=1:length(Zone)
%     plot([Zone(iZ) Zone(iZ)],[0 360],'w:','linewidth',0.8);
    plot([Zone(iZ) Zone(iZ)],[0 360],':','color',[240 100 0]/255,'linewidth',0.8); 

end
grid off
set(gca,'clim',[0.5 2.5],'xtick',[0:90:360],'xticklabel',[],'ytick',[0:90:360],'yticklabel',[],'tickdir','out');
colormap(bone)
papersizePX=[0 0 3 3];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'Ave' PopName{iPP}],'png'); 
% 



   end





clear Pop

Pop{1}=squeeze(nanmean(Data.All(Geno{iG},:,:),1));
Pop{2}=squeeze(nanmean(Data.deletePF(Geno{iG},:,:),1));
Pop{3}=squeeze(nanmean(Data.deleteNPF(Geno{iG},:,:),1));
   for iPP=2:length(Pop)
figure;
subplot('position',[0.02 0.02 0.96 0.96]);

imagesc(SpaBin,SpaBin,Pop{iPP}-Pop{1});axis xy;
set(gca,'xtick',[0:90:360],'ytick',[0:90:360]);
set(gca,'clim',[-0.4 0.4],'xtick',[0:90:360],'xticklabel',[],'ytick',[0:90:360],'yticklabel',[],'tickdir','out');
hold on;
for iZ=1:length(Zone)
    plot([Zone(iZ) Zone(iZ)],[0 360],'k:','linewidth',0.8); 
end
grid off

colormap(colorMapPN)
papersizePX=[0 0 3 3];
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'PaperPosition',papersizePX,'PaperSize',papersizePX(3:4));
saveas(gcf,[SaveFolder1 GenoName{iG} 'AveSTRAll' PopName{iPP}],'png'); 



   end




end

