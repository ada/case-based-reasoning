function [ locs ] = FrequencyPeaks( audio, fs, EnablePlotting)

%figure(1);
%clf;
%hold on;
%axis([0 1E4 -80 -20])

[pxx, f, pxxc] = periodogram(audio, rectwin(length(audio)), length(audio), fs, 'power');
pxx = 10*log10(pxx);

%plot(f, pxx);

pks = [];
locs = [];

MinPeakHeight = -60;
if max(pxx) > MinPeakHeight
    [pks,locs] = findpeaks(pxx, f, 'MinPeakProminence',30, 'MinPeakDistance',100, 'MinPeakHeight', MinPeakHeight, 'SortStr', 'descend');
    %plot(locs, pks, 'o');
end

end

