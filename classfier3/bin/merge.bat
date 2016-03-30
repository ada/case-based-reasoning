@cls
::@merge.exe class.csv frame_fft_area.csv frame_fft_area_delta.csv frame_fft_peak_1.csv frame_fft_peak_2.csv frame_fft_peak_1_delta.csv frame_mean.csv frame_std.csv frame_zcr.csv -o db.csv


@merge.exe -c class.csv -f frame_fft_area.csv frame_fft_area_delta.csv frame_fft_peak_1.csv frame_fft_peak_2.csv frame_fft_peak_1_delta.csv frame_mean.csv frame_std.csv frame_zcr.csv -o db.csv