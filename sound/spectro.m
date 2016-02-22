clc; close all; clear all;
filename = 'Talgoxe.mp3'; 
[audio,fs] = audioread(filename);
audio = audio(100000:200000);
% didn't have wav file, but simply replace this with the following
% [audio,fs] = wavread('audioFile.wav')
% temp sampling frequency, will depend on audio input
NFFT = 1024; % feel free to change FFT size
hamWin = hamming(NFFT); % window your audio signal to avoid fft edge effects

% get spectral content
figure;
spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -80,'power','centered');
[~,F,T,P,Fc,Tc] = spectrogram(audio,hamWin,NFFT/2,NFFT,fs, 'yaxis', 'MinThreshold', -80, 'reassigned','centered');
colormap hot
