clc; clear all; close all;

% Read sound file
filename = 'Blåhake.mp3';
[y,Fs] = audioread(filename);
y0 = y; 

% Convert stereo to mono
if size(y,2) == 2
    y = ( y(:, 1) + y(:, 2) ) ./ max(abs(y(:, 1)+y(:, 2))) ;
end

% Split into frames
frameLength = 2; % seconds
frameSize = frameLength * Fs; % frames
y = y(1 : floor(size(y, 1) / (Fs * frameLength)) * frameSize); % cut to lowest multiple of frameSize

% Extacts features from each frame
for i = 1 : frameSize : size(y, 1)
    t = y(i:i + frameSize - 1); 
    plot(t);
    sound(t, Fs);
    waitforbuttonpress;
end






%%
for collection = collections 
    for person = people
        personIndex = find(not(cellfun('isempty', strfind(people, char(person))))); 
        for state = states
            postfix = ['_',state{1},'_',person{1},'_',collection{1},'.csv'];
            if size(ls([DIRNAME,'*',postfix])) ~= 0
                
                session.HR = csvread([DIRNAME,'HR',postfix]);
                session.HRV = csvread([DIRNAME,'HRV',postfix]);
                session.FT = csvread([DIRNAME,'FT',postfix]);
                session.RR = csvread([DIRNAME,'RR',postfix]);
                session.SCL = csvread([DIRNAME,'SCL',postfix]);
                session.Duration = floor(size(session.HR,1)/240);
                session.State = find(ismember(states,state))-1; 
       
                for i = 1 : INTERVAL : session.Duration
                   A = (i-1) * 240 + 1; % 240 rows = 1 minute
                   B = A + 240;
                   row = offset + i; 
      
                   [~, m] = freq_mag(session.HR(A:B));
                   [LF, HF] = freq_LF_HF(m); 
                   data(row, COL_HR_LF)        = LF;
                   data(row, COL_HR_HF)        = HF;
                   data(row, COL_HR_D0_STD)    = std(session.HR(A:B));
                   data(row, COL_HR_D0_MEAN)   = mean(session.HR(A:B));
                   data(row, COL_HR_D1_MEAN)   = mean(diff(session.HR(A:B)));
                   data(row, COL_HRV_D0_STD)   = std(session.HRV(A:B));
                   data(row, COL_HRV_D0_STD0)  = std(session.HRV);
                   data(row, COL_HRV_D0_MEAN)  = mean(session.HRV(A:B));
                   data(row, COL_HRV_D0_MEAN0) = mean(session.HRV);
                   data(row, COL_HRV_D1_MEAN)  = mean(diff(session.HRV(A:B)));
                   data(row, COL_FT_D0_STD)    = std(session.FT(A:B));
                   data(row, COL_FT_D0_MEAN)   = mean(session.FT(A:B));
                   data(row, COL_FT_D1_MEAN)   = mean(diff(session.FT(A:B)));
                   data(row, COL_RR_D0_STD)    = std(session.RR(A:B));
                   data(row, COL_RR_D0_MEAN)   = mean(session.RR(A:B));
                   data(row, COL_RR_D1_MEAN)   = mean(diff(session.RR(A:B)));
                   data(row, COL_SCL_D0_MEAN)  = mean(session.SCL(A:B));
                   data(row, COL_SCL_D0_STD)   = std(session.SCL(A:B));
                   data(row, COL_ALC)          = session.State;
                   data(row, COL_MASS)         = mass(personIndex);
                end
                offset = size(data,1);
            end
        end
    end
end


data(1:118,:) = Shuffle(data(1:118,:));

%% Export each column to a seperate file
delete('export/*.csv');
csvwrite('export/HR_D0_STD.csv',    data(:,COL_HR_D0_STD));
csvwrite('export/ALC.csv',          data(:,COL_ALC));