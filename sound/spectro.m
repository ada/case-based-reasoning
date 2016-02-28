clc; close all; clear all;
[audio,fs] = audioread('Talgoxe.wav');
audio = audio(195000:200000);
NFFT = 2*1048; % feel free to change FFT size
hamWin = hamming(NFFT); % window your audio signal to avoid fft edge effects

figure(15);
hold on;
[pxx, f, pxxc] = periodogram(audio, rectwin(length(audio)), length(audio), fs, 'power');
pxx = 10*log10(pxx); 
plot(f, pxx);
[pks,locs] = findpeaks(pxx, f, 'MinPeakProminence',23, 'MinPeakDistance',500, 'MinPeakHeight',-80, 'SortStr', 'descend')
plot(locs, pks, 'o'); 
pks


%%



% get spectral content
% spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -80,'power','centered');
[S,F,T,P,Fc,Tc] = spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -140, 'power','centered');


start = false;
z = 10*log10(P);
z = z(1:NFFT/2,:);
F = F(1:NFFT/2);

zz = sum(z, 2);
figure(1);
plot (F, zz);
hold on;

fmax = [];
fmax_index = 0;

for i = 1:1:NFFT/2-3
    if ~start && (zz(i) == -Inf) && (zz(i+1) == -Inf) && (zz(i+2) == -Inf) && (zz(i+3) ~= -Inf)
        start = true;
        start_i = i+3;
    end
    if start && (zz(i) ~= -Inf) && (zz(i+1) == -Inf) && (zz(i+2) == -Inf) && (zz(i+3) == -Inf)
        start = false;
        stop_i = i;
        [frame_max, frame_max_i] = max (zz(start_i:stop_i));
        
        fmax = [fmax; F(start_i + frame_max_i - 1)];

        scatter (F(start_i + frame_max_i - 1), frame_max, 'LineWidth', 2);
    end
end
fmax

[~, f_index_max] = max(sum(z,2));
figure;
colormap hot;
surf(T,F,z,'edgecolor','none');