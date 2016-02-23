clc; close all; clear all;
filename = 'Talgoxe.mp3'; 
[audio,fs] = audioread(filename);
audio = audio(100000:200000);
% didn't have wav file, but simply replace this with the following
% [audio,fs] = wavread('audioFile.wav')
% temp sampling frequency, will depend on audio input
NFFT = 1*1024; % feel free to change FFT size
hamWin = hamming(NFFT); % window your audio signal to avoid fft edge effects

% get spectral content

% spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -80,'power','centered');
[S,F,T,P,Fc,Tc] = spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -80, 'power','centered');


start = false;
z = 10*log10(P);
zz = sum(z,2);

figure(1);
plot (F,zz,'x');
hold on;

for i = 1:1:NFFT-3
    if ~start && (zz(i) == -Inf) && (zz(i+1) == -Inf) && (zz(i+2) == -Inf) && (zz(i+3) ~= -Inf)
        start = true;
        start_i = i;
    end
    if start && (zz(i) ~= -Inf) && (zz(i+1) == -Inf) && (zz(i+2) == -Inf) && (zz(i+3) == -Inf)
        start = false;
        stop_i = i;
        [frame_max, frame_max_i] = max (zz(start_i:stop_i));
        scatter (F(start_i+frame_max_i-1), frame_max);
    end
end


%%
[~, f_index_max] = max(sum(z,2));




figure;
colormap hot;
surf(T,F,z,'edgecolor','none');