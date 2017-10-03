%clearing commands%
clc;
clear all;
close all;
%loading input signal%
load foetal_ecg.dat 
t = foetal_ecg(:,1);%loading time
abdominal = foetal_ecg(:,2:6); %loading  abdominal signals 
thoraic = foetal_ecg(:,7:9) ; %loading  thoraic signals 
avg_abdominal= mean(abdominal,2); %Average of abdominal signals
avg_thoraic= mean(thoraic,2); %Average of thoraic signals
reference=avg_thoraic;
figure
subplot(211);
plot(t,avg_abdominal);
title('Average of Abdominal Signals')
xlabel('Time [sec]');
ylabel('Amplitude [mV]');
subplot(212);%
plot(t,reference,'r');
title('Average of Thoraic Signals')
xlabel('Time [sec]');
ylabel('Amplitude [mV]');
%%
% GENERATING ANC 
% USING LMS ALGORITHM%
nord1 = 8; %order of the filter
mu = .00000001; %value of step size
[W1,Child_E1,Maternal_Y1] = lms(reference,avg_abdominal,mu,nord1);
figure
plot(t,reference,'--k');
hold on
plot(t,Child_E1,'r')
title('SISO System Filter Error & Thoraic LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
% USING NLMS ALGORITHM%
nord2 = 8; %order of the filter
beta = 0.00009; %value of beta in NLMS
[W2,Child_E2,Maternal_Y2] = nlms(reference,avg_abdominal,beta,nord2);
figure
plot(t,reference,'--k');
hold on
plot(t,Child_E2,'r')
title('SISO System Filter Error & Thoraic NLMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
% USING L-LMS ALGORITHM%
nord3 = 20; %order of the filter
gamma = 0.0005; %value of gamma in LLMS
ss3 = 0.000000075; % value of step size
[W3,Child_E3,Maternal_Y3] = llms(reference,avg_abdominal,ss3,gamma,nord3);
figure
plot(t,reference,'--k');
hold on
plot(t,Child_E3,'r')
title('SISO System Filter Error & Thoraic L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('Mother HB','Child HB');
%%
% SISO Fetus signals
figure
subplot(211)
plot(t,Child_E1)
hold on;
plot(t,Child_E2,'--g')
hold on;
plot(t,Child_E3,'--r')
title('SISO Fetus signals using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
axis([0 5 -40 40]);
legend('LMS','NLMS','L-LMS')
%%
%ZOOMED SISO Fetus signals
subplot(212)
plot(t,Child_E1)
hold on;
plot(t,Child_E2,'--g')
hold on;
plot(t,Child_E3,'--r')
title('ZOOMED SISO System Fetus signals using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
axis([0 1 -25 14]);
legend('LMS','NLMS','L-LMS')
%%
% SISO Filter outputs
figure
plot(t,Maternal_Y1)
hold on;
plot(t,Maternal_Y2,'--r')
hold on;
plot(t,Maternal_Y3,'--c')
title('SISO System Filter outputs using LMS,NLMS,L-LMS');
xlabel('Time [Sec]');
ylabel('Amplitude [mV]');
legend('LMS','NLMS','L-LMS')
ylabel('Amplitude [mV]');
legend('LMS','NLMS','L-LMS')