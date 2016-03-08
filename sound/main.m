clc; clear all; close all;

point_array_index = 0;
point_array = zeros (10000000, 3);

fnames = dir('*.wav');
id = 0;
step = 10000;
    
for j = fnames 
    id = id + 1; 
    name = j.name
    [y,Fs] = audioread(name);

    % Convert stereo to mono
    if size(y,2) == 2
        y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
    end

    frameSize = Fs * 1;
    
    for i = 1 : step : length(y) - frameSize - step
        % Extacts features for each frame
        frame = y(i : i + frameSize);
        r = FrequencyPeaks(frame, Fs, 'EnablePlotting0');

        if length(r) == 1
            point_array_index = point_array_index + 1;
            point_array (point_array_index, :) = [id, r(1), 0];
        end

        if length(r) > 1
            point_array_index = point_array_index + 1;
            point_array (point_array_index, :) = [id, r(1), r(2)];
        end
    end
    
    csvwrite('class.csv', point_array (:, 1))
    csvwrite('f1.csv', point_array (:, 2))
    csvwrite('f2.csv', point_array (:, 3))
    
end; 


%%
figure(1);
hold on;
ylabel('Frequency');
plot(point_array(1:point_array_index,2),'-r');
plot(point_array(1:point_array_index,3),'-b');
legend('Peak 1', 'Peak 2');


