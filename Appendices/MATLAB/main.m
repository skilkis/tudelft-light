clear all;
close all;
clc;

gamma=1.4; %Ratio of Specific Heats (Air)

%% Importing Tables from Nozzle1.csv and Nozzle2.csv

global NoZ1 NoZ2

NoZ1.data=readtable('Nozzle1.csv'); %NoZ1 = Nozzle1
NoZ2.data=readtable('Nozzle2.csv'); %NoZ2 = Nozzle2

%% Importing Experimental Data

NoZ1.ExperimentSUP=readtable('2017-02-17_12-21-48.txt'); 
NoZ1.ExperimentSUB=readtable('2017-02-17_12-24-22.txt');
NoZ2.Experiment1=readtable('2017-02-17_12-37-39.txt');
NoZ2.Experiment2=readtable('2017-02-17_12-31-42.txt');
NoZ2.Experiment3=readtable('2017-02-17_12-34-20.txt');

%% Theoretical Supersonic Flow for First Nozzle [Choked Flow Conditions At=A*]

NoZ1.SUP.A=NoZ1.data.A;
NoZ1.SUP.MACH=zeros(length(NoZ1.SUP.A),1);
NoZ1.SUP.P=zeros(length(NoZ1.SUP.A),1);
for i=1:length(NoZ1.SUP.A);
    if i<6
        [NoZ1.SUP.MACH(i), ~, NoZ1.SUP.P(i), ~, ~]=flowisentropic(gamma, NoZ1.SUP.A(i), 'sub');
    else
        [NoZ1.SUP.MACH(i), ~, NoZ1.SUP.P(i), ~, ~]=flowisentropic(gamma, NoZ1.SUP.A(i), 'sup');
    end
end

%% Theoretical Subsonic Flow for First Nozzle [Non-Choked Flow Conditions At=/=A*]

PRatio=NoZ1.ExperimentSUB.P_Pt(1); % Measured Pressure Ratio at First Pressure Measurement

[~, ~, ~, ~, NoZ1.SUB.A_star]=flowisentropic(gamma, PRatio, 'pres');
NoZ1.SUB.A_correction=NoZ1.SUB.A_star*(1/NoZ1.data.A(1)); %A(x0)/A_star * A_t/A(x0) = A_t/A_star
NoZ1.SUB.A=NoZ1.SUB.A_correction.*NoZ1.data.A;

for i=1:length(NoZ1.SUB.A);
    [NoZ1.SUB.MACH(i), ~, NoZ1.SUB.P(i), ~, ~]=flowisentropic(gamma, NoZ1.SUB.A(i), 'sub');
end

%% Obtaining Experimental Mach Number using Isentropic Relations

NoZ1.SUP.MACH_EXP=zeros(length(NoZ1.ExperimentSUP.mm),1);
NoZ1.SUB.MACH_EXP=zeros(length(NoZ1.ExperimentSUP.mm),1);

for i=1:length(NoZ1.ExperimentSUP.mm)
        [NoZ1.SUP.MACH_EXP(i), ~, ~, ~, ~]=flowisentropic(gamma, NoZ1.ExperimentSUP.P_Pt(i), 'pres');
        [NoZ1.SUB.MACH_EXP(i), ~, ~, ~, ~]=flowisentropic(gamma, NoZ1.ExperimentSUB.P_Pt(i), 'pres');
end

%% Calculating Area Ratio at Shock Location

NoZ2.x_shock=[390 530 630];
[hk2,dh,h0]=meter2geo(15,10); %Input Experiment Meter Values Here (meter4,meter5)
A_ratio=(dh*NoZ2.x_shock(2:3)+h0)/hk2;

for i=1:length(A_ratio)
    [~, ~, NoZ2.SUB.Pe3(i), ~, ~]=flowisentropic(gamma, A_ratio(i), 'sub');
    [NoZ2.SUP.MACH_XSHOCK(i), ~, NoZ2.SUP.Pe6(i), ~, ~]=flowisentropic(gamma, A_ratio(i), 'sup');
    [~, ~, NoZ2.SUP.Pe5(i), ~, ~, ~, ~]=flownormalshock(gamma, NoZ2.SUP.MACH_XSHOCK(i), 'mach');
    NoZ2.SUP.Pe5(i)=NoZ2.SUP.Pe5(i)*NoZ2.SUP.Pe6(i);
end

%% Plotting Fiures

%Part I:

Margin=0.125; %Control Figure Margins
LabelSize=9; %Control Label Text Size
AR=[8 5]; %Aspect Ratio
NF=0.01; %Distance to Nudge Plot to Compensate for Axis Labels

figure('Name','MachNoZ1');
hold on; grid on; grid minor;
line([65 65],[0 NoZ1.SUP.MACH(5)],'Color','k','LineStyle','- -'); %Drawing a Vertical Line to Indicate Throat Sonic Value
line([0 65],[1 1],'Color','k','LineStyle','- -'); %Drawing a Horizontal Line to Indicate Throat Sonic Value
line([0 194.8],[2.1 2.1],'Color','k','LineStyle','- -'); %Drawing a Horizontal Line to Indicate Throat Sonic Value
text(65.5,0.75,'$\leftarrow x_t = 65 \left[ mm \right]$','Interpreter','LaTex','FontSize',8)
text(50,1.05,'M = 1','Interpreter','LaTex','FontSize',8)
text(120,2.15,['$M_{e} =$ ' num2str(NoZ1.SUP.MACH(26))],'Interpreter','LaTex','FontSize',8)
line1=plot(NoZ1.data.x,NoZ1.SUB.MACH,'LineWidth',1);
line2=plot(NoZ1.data.x,NoZ1.SUP.MACH,'LineWidth',1);
line3=plot(NoZ1.ExperimentSUB.mm,NoZ1.SUB.MACH_EXP,'Color',[0 174 255]/255,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
line4=plot(NoZ1.ExperimentSUP.mm,NoZ1.SUP.MACH_EXP,'Color',[221 135 51]/255,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
axis([44.8 194.8 0 2.5])
xlabel('Position [mm]','fontsize',12,'Interpreter','LaTex');
ylabel('Mach Number [-]','fontsize',12,'Interpreter','LaTex');
legend([line1,line3,line2,line4],{'Subsonic [Theory]','Subsonic [EXP1A]','Supersonic [Theory]','Supersonic [EXP2A]'},'Location','East'); %Creating Legend
set(gca,... %Formatting Axis Text
    'XMinorTick','on',...
    'YMinorTick','on',...
    'FontSize',LabelSize/1.5,...
    'TickLabelInterpreter','LaTex',...
    'LabelFontSizeMultiplier',1.5,...
    'Position',[((Margin+NF)/2) ((0+((AR(1)/AR(2))*(Margin)))/2) (1-Margin) (1-((AR(1)/AR(2))*Margin))]);
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'PaperPosition', [0 0 AR(1) AR(2)]); %Position plot at left hand corner with width 6 and height 5.
set(gcf, 'PaperSize', [AR(1) AR(2)]); %Set the paper to have width 6 and height 5.

figure('Name','PressureNoZ1');
hold on; grid on; grid minor;
line([65 65],[0 NoZ1.SUB.P(5)],'Color','k','LineStyle','- -'); %Drawing a Vertical Line to Indicate Throat Sonic Value
line([0 65],[0.528 0.528],'Color','k','LineStyle','- -'); %Drawing a Horizontal Line to Indicate Throat Sonic Value
text(65.5,0.1,'$\leftarrow x_t = 65 \left[ mm \right]$','Interpreter','LaTex','FontSize',8)
text(66,0.528,'$\leftarrow \frac{p}{p_t}=0.528$','Interpreter','LaTex','FontSize',8)
line1=plot(NoZ1.data.x,NoZ1.SUB.P,'LineWidth',1);
line2=plot(NoZ1.data.x,NoZ1.SUP.P,'LineWidth',1);
line3=plot(NoZ1.ExperimentSUB.mm,NoZ1.ExperimentSUB.P_Pt,'Color',[0 174 255]/255,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
line4=plot(NoZ1.ExperimentSUP.mm,NoZ1.ExperimentSUP.P_Pt,'Color',[221 135 51]/255,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
xlabel('Position [mm]','Interpreter','LaTex','Color','k');
ylabel('Pressure Ratio $\left[ \frac{p}{p_{t}} \right]$','Interpreter','LaTex','Color','k');
legend([line1,line3,line2,line4],{'Subsonic [Theory]','Subsonic [EXP1]','Supersonic [Theory]','Supersonic [EXP2]'},'Location','East'); %Creating Legend
axis([44.8 194.8 0 1]) %Setting Axis Limits
set(gca,... %Formatting Axis Text
    'XMinorTick','on',...
    'YMinorTick','on',...
    'FontSize',LabelSize/1.5,...
    'TickLabelInterpreter','LaTex',...
    'LabelFontSizeMultiplier',1.5,...
    'Position',[((Margin+NF)/2) ((0+((AR(1)/AR(2))*(Margin)))/2) (1-Margin) (1-((AR(1)/AR(2))*Margin))]);
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'PaperPosition', [0 0 AR(1) AR(2)]); %Position plot at left hand corner with width 6 and height 5.
set(gcf, 'PaperSize', [AR(1) AR(2)]); %Set the paper to have width 6 and height 5.

%Part II:

figure('Name','PressureNoZ2');
hold on; grid on; grid minor;
line1=plot(NoZ2.Experiment1.mm,NoZ2.Experiment1.P_Pt,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
line2=plot(NoZ2.Experiment2.mm,NoZ2.Experiment2.P_Pt,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
line3=plot(NoZ2.Experiment3.mm,NoZ2.Experiment3.P_Pt,'marker','o','MarkerFaceColor','w','MarkerSize',3,'LineWidth',1);
line4=line([NoZ2.x_shock(1) NoZ2.x_shock(1)],[0 1],'Color','k','LineStyle','-.');
line5=line([NoZ2.x_shock(2) NoZ2.x_shock(2)],[0 1],'Color','k','LineStyle','--');
line6=line([NoZ2.x_shock(3) NoZ2.x_shock(3)],[0 1],'Color','k');
point1=scatter(NoZ2.x_shock(2:3),NoZ2.SUB.Pe3,'*','MarkerEdgeColor',[0 0.60 0.50]);
point2=scatter(NoZ2.x_shock(2:3),NoZ2.SUP.Pe5,'*','MarkerEdgeColor',[0.80 0.40 0]);
point3=scatter(NoZ2.x_shock(2:3),NoZ2.SUP.Pe6,'*');
xlabel('Position [mm]','Interpreter','LaTex','Color','k');
ylabel('Pressure Ratio $\left[ \frac{p}{p_{t}} \right]$','Interpreter','LaTex','Color','k');
legend([line1,line2,line3,line4,line5,line6,point1,point2,point3],{'Experiment 3A','Experiment 4A','Experiment 5A','Shock at Throat','Shock at $x=530$ [mm]','Shock at $x=630$ [mm]','Maximum Pressure Ratio [$p_{e3}/{p_t}$]','Pressure Ratio After Norm. Shock [$p_{e5}/{p_t}$]','Minumum Pressure Ratio [$p_{e6}/{p_t}$]'},'Location','West','Interpreter','LaTex'); %Creating Legend
set(gca,... %Formatting Axis Text
    'XMinorTick','on',...
    'YMinorTick','on',...
    'FontSize',LabelSize/1.5,...
    'TickLabelInterpreter','LaTex',...
    'LabelFontSizeMultiplier',1.5,...
    'Position',[((Margin+NF)/2) ((0+((AR(1)/AR(2))*(Margin)))/2) (1-Margin) (1-((AR(1)/AR(2))*Margin))]);
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'PaperPosition', [0 0 AR(1) AR(2)]); %Position plot at left hand corner with width 6 and height 5.
set(gcf, 'PaperSize', [AR(1) AR(2)]); %Set the paper to have width 6 and height 5.

clear vars Margin LabelSize AR NF

%% Saving/Overwriting Figures in the Images Folder as a .pdf

choice=questdlg('Would you like to close and save all figures to ../Figures?',...
    'Figure Save Dialog', ...
    'Yes','Just Save','Specify Directory','Specify Directory');
switch choice
    case 'Yes'
        if exist('Figures','dir')==0
        mkdir('Figures')
        end
        cd('Figures')
        b1=waitbar(0,'1','Name','Please Wait');
        H=gcf;
        i_prime=H.Number;
        for i=1:i_prime
            waitbar(i/i_prime,b1,sprintf('Saving Figure (%d/%d)',i,i_prime))
            saveas(i, get(i,'Name'), 'pdf')
        end
        cd('../')
        close all
        delete(b1)
        b2=msgbox('Operation Completed','Success');
    case 'Just Save'
        if exist('Figures','dir')==0
        mkdir('Figures')
        end
        cd('Figures')
        b1=waitbar(0,'1','Name','Please Wait');
        H=gcf;
        i_prime=H.Number;
        for i=1:i_prime
            waitbar(i/i_prime,b1,sprintf('Saving Figure (%d/%d)',i,i_prime))
            saveas(i, get(i,'Name'), 'pdf')
        end
        cd('../')
        delete(b1)
        b2=msgbox('Operation Completed','Success');
    case 'Specify Directory'
        old_dir=cd;
        new_dir=uigetdir('','Select Figure Saving Directory');
        cd(new_dir)
        b1=waitbar(0,'1','Name','Please Wait');
        H=gcf;
        i_prime=H.Number;
        for i=1:i_prime
            waitbar(i/i_prime,b1,sprintf('Saving Figure (%d/%d)',i,i_prime))
            saveas(i, get(i,'Name'), 'pdf')
        end
        cd(old_dir)
        close all
        delete(b1)
        b2=msgbox('Operation Completed','Success');
end