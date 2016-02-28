clc; clear all; close all;

COL_BIRD_NAME = 1; 
COL_PEAK1_FREQ = 2; 
COL_PEAK2_FREQ = 3; 

% Load sound file
filename = 'Gök.mp3'; 
[y,Fs] = audioread(filename);

% Convert stereo to mono
if size(y,2) == 2
    y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
end

frameSize = Fs * 0.2;
step = 1000; 
results = [];
results_time = [];

for i = 1 : step : size(y, 1) - frameSize - step
    % Extacts features for each frame
    frame = y(i : i + frameSize);
    %results_time = [results_time; (i + frameSize)/2.0];
    r = FrequencyPeaks(frame, Fs, 'EnablePlotting');
    %results = [results, r(1:2)];
    %clf;
    %plot (results_time, results(1,:))
    %hold on;
    %plot (results_time, results(2,:))
    %pause(0.1);
    pause;
    %feature = zeros(1);
    %feature(COL_BIRD_NAME) = 1;
    %feature(COL_PEAK1_FREQ) = r(1);
    %feature(COL_PEAK2_FREQ) = r(2);
    %results = [results; feature]; 
end



