clc;
clear all;
close all;
% loading input signal%
load foetal_ecg.dat 
t = foetal_ecg(:,1); % loading time 
abdominal = foetal_ecg(:,2:6); % loading  abdominal signals
thoraic = foetal_ecg(:,7:9) ; % loading  thoraic signals
avg_abdominal= mean(abdominal,2);% Average of abdominal signals
reference=thoraic;
avg_thoraic= mean(thoraic,2);
mu=0.0000005;                   % Value of stepsize in LMS%
gamma=0.001;                     % Value of leakyfactor in LLMS%
beta=0.009;                     % Value of stepsize in NLMS%
nord=15;                        % order of the filter
%%
%GENERATING ANC%
%USING LMS ALGORITHM%
[A1,Child_E1,Maternal_Y1] = lms1(reference,avg_abdominal,mu,nord);
figure
plot(t,avg_thoraic,'--k');
hold on
plot(t,Child_E1,'r')
title('MISO System Filter Error & Thoraic LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
%USING NLMS ALGORITHM%
[A2,Child_E2,Maternal_Y2] = nlms1(reference,avg_abdominal,beta,nord);
figure
plot(t,avg_thoraic,'--k');
hold on
plot(t,Child_E2,'r')
title('MISO System Filter Error & Thoraic NLMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
% USING L-LMS ALGORITHM%
[A3,Child_E3,Maternal_Y3] = llms1(reference,avg_abdominal,mu,gamma,nord);
figure
plot(t,avg_thoraic,'--k');
hold on
plot(t,Child_E3,'r')
title('MISO System Filter Error & Thoraic L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
%%
% MISO Fetus signals
figure
subplot(211)
plot(t,Child_E1)
hold on;
plot(t,Child_E2,'--g')
hold on;
plot(t,Child_E3,'--r')
hold off;
title('MISO Fetus signals using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
axis([0 5 -40 40]);
legend('LMS','NLMS','L-LMS')
%%
%ZOOMED MISO Fetus signals
subplot(212)
plot(t,Child_E1)
hold on;
plot(t,Child_E2,'--g')
hold on;
plot(t,Child_E3,'--r')
title('ZOOMED MISO System Fetus signals using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
axis([0 1 -30 20]);
legend('LMS','NLMS','L-LMS')
%%
% MISO Filter outputs
figure
plot(t,Maternal_Y1)
hold on;
plot(t,Maternal_Y2,'--r')
hold on;
plot(t,Maternal_Y3,'--c')
title('MISO System Filter outputs using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('LMS','NLMS','L-LMS')
ylabel('Amplitude [mV]');
legend('LMS','NLMS','L-LMS')
