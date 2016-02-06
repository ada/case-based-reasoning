clc; clear all; close all;

COL_BIRD_NAME = 1; 
COL_STD = 2;
COL_MEAN = 3;

% Load sound file
filename = 'Blåhake.mp3'; 
[y,Fs] = audioread(filename);

% Convert stereo to mono
if size(y,2) == 2
    y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
end

% Split into frames
frameLength = 1; % seconds
frameSize = frameLength * Fs; % frames
nFrame = floor(size(y, 1) / (Fs * frameLength)); % total number of frames
y = y(1 : nFrame * frameSize); % cut to lowest multiple of frameSize
results = [];

for i = 1 : frameSize : size(y, 1)
    % Extacts features for each frame
    frame = y(i:i + frameSize - 1); 
    feature = zeros(1);
    feature(COL_BIRD_NAME) = 1;
    feature(COL_STD) = std(frame);
    feature(COL_MEAN) = mean(frame);
    results = [results; feature]; 
    plot(frame);
    sound(frame, Fs);
    waitforbuttonpress;
end

