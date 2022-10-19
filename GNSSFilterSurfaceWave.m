%% Plot Original Position
subplot(2,1,1);
plot(East,'b')
xlabel('Seconds');
ylabel('Meter');
title('EW Position');

subplot(2,1,2);
plot(North,'b')
xlabel('Seconds');
ylabel('Meter');
title('NS Position');

%% Power Spectrum
E_mag=abs(fft(East));
num_bins=length(E_mag);
subplot(2,1,1);
plot([0:1/(num_bins/2-1):1],E_mag(1:num_bins/2),'b')
xlabel('Normalised Frequency');
ylabel('Magnitude');
title('Power Spectrum EW');

N_mag=abs(fft(North));
num_bins=length(N_mag);
subplot(2,1,2);
plot([0:1/(num_bins/2-1):1],N_mag(1:num_bins/2),'b')
xlabel('Normalised Frequency');
ylabel('Magnitude');
title('Power Spectrum NS');

%% Calculate Velocity
E_Vel=diff(East)./(diff(t));
N_Vel=diff(North)./(diff(t));
subplot(2,1,1);
plot(E_Vel,'b');
xlabel('seconds');
ylabel('m/s');
title('EW Velocity')
subplot(2,1,2);
plot(N_Vel,'b');
xlabel('seconds');
ylabel('m/s');
title('NS Velocity')
%% Butterworth Filter
[b,a] = butter(2,[0.008 0.8],'bandpass');
E_Vel_filt=filtfilt(b,a,E_Vel);
N_Vel_filt=filtfilt(b,a,N_Vel);

%% Transform Velocity to Position
e_pos=cumtrapz(E_Vel_filt).*diff(t);
n_pos=cumtrapz(N_Vel_filt).*diff(t);

subplot(2,1,1);
plot(e_pos,'r');
xlabel('seconds');
ylabel('meters');
title('EW Position')
subplot(2,1,2);
plot(n_pos,'r');
xlabel('seconds');
ylabel('meters');
title('NS Position')
%% Plot Position (Raw and Filtered)
subplot(2,1,1);
plot(East,'b');
hold on
plot(e_pos,'r');
hold off
xlabel('seconds');
ylabel('meters');
title('EW Position');
legend('Raw','Filtered');

subplot(2,1,2);
plot(North,'b');
hold on
plot(n_pos,'r');
hold off
xlabel('seconds');
ylabel('meters');
title('NS Position')
legend('Raw','Filtered');
%% Plot Velocity (Raw and Filtered)
subplot(2,1,1);
plot(E_Vel,'b');
hold on
plot(E_Vel_filt,'r');
hold off
xlabel('seconds');
ylabel('meters');
title('EW Velocity');
legend('Raw','Filtered');

subplot(2,1,2);
plot(N_Vel,'b');
hold on
plot(N_Vel_filt,'r');
hold off
xlabel('seconds');
ylabel('meters');
title('NS Velocity')
legend('Raw','Filtered');


%% Surface Wave 
x=45;
m1=[cos(x) sin(x);-sin(x) cos(x)];
m2=[n_pos e_pos];
m3=m2';
m4=m1*m3;
m5=m4';
trans=m5(:,1);
rad=m5(:,2);

subplot(2,1,1);
plot(rad,'b');
xlabel('Seconds');
ylabel('Meter');
title('Rayleigh Wave (Radial)');

subplot(2,1,2);
plot(trans,'b');
xlabel('Seconds');
ylabel('Meter');
title('Love Wave (Transversal)');







