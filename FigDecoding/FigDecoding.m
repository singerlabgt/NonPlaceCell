clear all
load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\Decoding.mat')
load('C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\Data\colorMapPN.mat')

SavePath='C:\Users\lzhang481\SingerLab\Projects\Project7-Aging\SubmitFigCode\FigDecoding\';
mkdir(SavePath)


%%%%DecodeRes(2), result of current position decoding in global frame (0-360 degrees)
%%%%DecodeRes(1), result of current position decoding in distance to goal frame(0-180 degrees)

GenoName={'WT','AD'};
PopName={'All','DelPF','DelNPF'};

Zone=[[60 90 150 180] [60 90 150 180]+180];   %%%%True and False Goal Zone;



%%%%%%%Decoding using global frame (0-360 degrees)
Data=DecodeRes(2).DM;
KeyWord=DecodeRes(2).Name;
%%%%%%
SaveFolder1=[SavePath KeyWord '\'];
mkdir(SaveFolder1);

%%%%%%%%%%%For Fig2AC,
DecodePlot360Step1(Data,GenoI,GenoName,ParamN(2),colorMapPN,SaveFolder1)
%%%%%%%%%%%noted that subgraph of AD produced here is not included in the manuscript


%%%%%%%%%%%For Fig2B ,noted that the x-axis of individual sample is random
%%%%%%%%%%%produced, so those dots position will look slightly different
%%%%%%%%%%%visually from the figure in the paper
DecodePlot360Step2(Data,GenoI,GenoName,ParamN(2),SaveFolder1)
%%%%%%%%%%% noted that subgraph of AD produced here is not included in the manuscript






close all
%%%%%%%Decoding using distance to goal frame (0-180 degrees)
Data=DecodeRes(1).DM;
KeyWord=DecodeRes(1).Name;

NumBin=18;    %%%%%%%%Seperate 0-180 degrees by 18 bins;
%%%%%%
SaveFolder2=[SavePath KeyWord '\'];
mkdir(SaveFolder2);

%%%%%%%%%%%For Fig2DF   
DecodePlot180Step1(Data,GenoI,GenoName,ParamN(1),colorMapPN,SaveFolder2)
%%%%%%%%%%% noted that subgraph of AD produced here is not included in the manuscript

%%%%%%%%%%%For Fig2EG  Fig S16
DecodePlot180Step2(Data,GenoI,GenoName,ParamN(1),NumBin,SaveFolder2)
close all
