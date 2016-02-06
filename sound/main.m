clc; clear all; close all;

COL_BIRD_NAME = 1; 
COL_STD = 2;
COL_MEAN = 3;
COL_PEAK1_FREQ = 4; 

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
    
    % Fourier transform
    m = length(frame);      % Window length
    n = pow2(nextpow2(m));  % Transform length
    b = fft(frame,n);       % DFT of signal
    f = (0:n-1)*(Fs/n)/10;  % Frequency range
    p = b.*conj(b)/n;       % Power of the DFT
    f = f(1:floor(n/2));    % Cut up to the nyquist frequency
    p = p(1:floor(n/2));    % Cut up to the nyquist frequency
    
    feature = zeros(1);
    feature(COL_BIRD_NAME) = 1;
    feature(COL_STD) = std(frame);
    feature(COL_MEAN) = mean(frame);
    feature(COL_PEAK1_FREQ) = f(find(p==max(p)));
    results = [results; feature]; 
    
    plot(f,p);
    sound(frame, Fs);
    break;
    %pause;
end
results
