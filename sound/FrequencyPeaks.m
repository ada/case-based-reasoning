function [ locs, area ] = FrequencyPeaks( audio, fs, MinPeakHeight, MinPeakProminence, MinPeakDistance)

%figure(1);
%clf;
%hold on;
%axis([0 1E4 -80 -20])

[pxx, f, pxxc] = periodogram(audio, rectwin(length(audio)), length(audio), fs, 'power');
pxx = 10*log10(pxx);

area = sum(pxx.^2);

pxx = smooth (pxx);

%plot(f, pxx);

pks = [];
locs = [];

if max(pxx) > MinPeakHeight
    [pks,locs] = findpeaks(pxx, f, 'MinPeakProminence', MinPeakProminence, 'MinPeakDistance',MinPeakDistance, 'MinPeakHeight', MinPeakHeight, 'SortStr', 'descend');
    %plot(locs, pks, 'o');
end

%pause

end

