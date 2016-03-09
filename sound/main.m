clc; clear all; close all;

point_array_index = 1;
point_array = zeros (10000000, 5);
fnames = dir('*.wav');
id = 0;
step = 1000;

for j = fnames'
    id = id + 1; 
    
    name = j.name

    [y,Fs] = audioread(name);
    y = y(1:Fs*10);

    % Convert stereo to mono
    if size(y,2) == 2
        y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
    end

    frameSize = Fs * 0.2;
    point_array_start = point_array_index;
    
    for i = 1 : step : length(y) - frameSize - step
        % Extacts features for each frame
        frame = y(i : i + frameSize);
        r = FrequencyPeaks(frame, Fs, -70, 15, 250);
        
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
    end
    
    point_array_index = point_array_index - 1;
    
    point_array (point_array_start:point_array_index, 4) = mean (point_array (point_array_start:point_array_index, 2));
    point_array (point_array_start:point_array_index, 5) = std (point_array (point_array_start:point_array_index, 2)); 
    
end;





point_array = point_array(1:point_array_index,:);

%%  
csvwrite('class.csv', point_array (:, 1));
csvwrite('f1.csv', point_array (:, 2));
csvwrite('f2.csv', point_array (:, 3));
csvwrite('f3.csv', point_array (:, 4));
csvwrite('f4.csv', point_array (:, 5));

%%
point_array(1:point_array_index,1) = point_array(1:point_array_index,1) * 1000;

%%
figure(1);
hold on;
ylabel('Frequency');

plot(point_array(1:point_array_index,1),'-g');
plot(point_array(1:point_array_index,2),'-r');
plot(point_array(1:point_array_index,3),'-b');
plot(point_array(1:point_array_index,4),'-c');
plot(point_array(1:point_array_index,5),'-m');
legend('Class', 'Peak 1', 'Peak 2', 'Peak 1 mean', 'Peak 1 std');