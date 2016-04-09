clc; clear all; close all;

point_array_index = 1;
point_array = zeros (10000000, 8);
fnames = dir('*.mp3');
id = 0;
step = 1000; 
frameLength = 1; %seconds
maxDuration = 5; %seconds

for j = fnames'
    fftAreaPrev = 0;
    fftPeakPrev = 0;
    id = id + 1; 
    name = j.name

    [y,Fs] = audioread(name);
    if length(y) >  Fs * maxDuration 
        y = y(1:Fs*10);
    end;
    
    figure;
    plot(y);
    xlabel('Time'); 
    ylabel('Amplitude');
    pause;
    

    % Convert stereo to mono
    if size(y,2) == 2
        y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
    end

    frameSize = Fs * frameLength;
    point_array_start = point_array_index;
    
    for i = 1 : step : length(y) - frameSize - step
        % Extacts features for each frame
        frame = y(i : i + frameSize);
        [r, fftArea] = FrequencyPeaks(frame, Fs, -70, 15, 250);
        
        if length(r) == 1
            point_array (point_array_index, 1) = id;
            point_array (point_array_index, 2) = r(1);
            point_array (point_array_index, 3) = 0;
            point_array_index = point_array_index + 1;
        end

        if length(r) > 1
            point_array (point_array_index, 1) = id;
            point_array (point_array_index, 2) = r(1);
            point_array (point_array_index, 3) = r(2);
            point_array_index = point_array_index + 1;
        end
        
        if length(r) >= 1
            point_array (point_array_index, 4) = r(1) - fftPeakPrev;
            point_array (point_array_index, 5) = mean(frame);
            point_array (point_array_index, 6) = std(frame); 
            point_array (point_array_index, 7) = ZCR(frame); 
            point_array (point_array_index, 8) = fftArea;
            point_array (point_array_index, 9) = fftArea - fftAreaPrev; 
            
            fftAreaPrev = fftArea;
            fftPeakPrev = r(1);
        end
        

    end
    
    point_array_index = point_array_index - 2;
    point_array (point_array_start, :) = [];
end;

% Normalize
for i = 1:size(point_array, 2) 
    point_array(:,i) = mat2gray(point_array(:,i));
end    

%%  
csvwrite('class.csv', point_array (:, 1));
csvwrite('f1.csv', point_array (:, 2));
csvwrite('f2.csv', point_array (:, 3));
csvwrite('f3.csv', point_array (:, 4));
csvwrite('f4.csv', point_array (:, 5));

%%
point_array(1:point_array_index,1) = point_array(1:point_array_index,1) * 1E7;



%%
figure(1);
hold on;
ylabel('Frequency');

plot(point_array(1:point_array_index,1),'-g');
plot(point_array(1:point_array_index,2),'-r');
%plot(point_array(1:point_array_index,3),'-b');
%plot(point_array(1:point_array_index,4),'-c');
%plot(point_array(1:point_array_index,6));
%plot(point_array(1:point_array_index,5));
%plot(point_array(1:point_array_index,6));
%plot(point_array(1:point_array_index,7));
%plot(point_array(1:point_array_index,8));

legend('Class', 'delta peak f1');



