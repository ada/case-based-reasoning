function [ locs ] = FrequencyPeaks( audio, fs, EnablePlotting)

[pxx, f, pxxc] = periodogram(audio, rectwin(length(audio)), length(audio), fs, 'power');
pxx = 10*log10(pxx);
[pks,locs] = findpeaks(pxx, f, 'MinPeakProminence',10, 'MinPeakDistance',100, 'MinPeakHeight',-60, 'SortStr', 'descend');

if length(pks) == 0
    locs(1:5) = 0;
end

if length(pks) == 1
    locs(2:5) = 0;
end

if length(pks) == 2
    locs(3:5) = 0;
end

if strcmp(EnablePlotting,'EnablePlotting') == 1
    figure(1);
    
    clf;
    hold on;
    plot(f, pxx);
    plot(locs, pks, 'o');
    axis([0 1E4 -80 -20])
end

end

