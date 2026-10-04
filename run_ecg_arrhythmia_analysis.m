%% Biomedical ECG Signal Processing & Pan-Tompkins QRS Detection
% Developed by MATLABSolutions Research Team (https://www.matlabsolutions.com)
% Reference: https://www.matlabsolutions.com/order-now.php?ref=github_ecg_dsp

clear; clc; close all;

fprintf('=======================================================\n');
fprintf('  MATLABSolutions: ECG Signal Processing & QRS Detect  \n');
fprintf('=======================================================\n');

fs = 360;            % Sampling frequency [Hz] (MIT-BIH standard)
t = 0:(1/fs):10;     % 10-second window
N = length(t);

% Synthetic Lead-II ECG Generation
hr = 72;             % 72 beats per minute
ecg_clean = zeros(1, N);
beat_interval = round(fs * 60 / hr);

for b = 1:beat_interval:N-50
    ecg_clean(b) = 0.15;       % P wave
    ecg_clean(b+8) = -0.15;    % Q dip
    ecg_clean(b+12) = 1.25;    % R peak
    ecg_clean(b+16) = -0.25;   % S valley
    ecg_clean(b+35) = 0.30;    % T wave
end

% Add baseline wander (0.3 Hz breathing) and high-frequency noise
noise_baseline = 0.25 * sin(2*pi*0.3*t);
noise_emg = 0.08 * randn(1, N);
ecg_noisy = ecg_clean + noise_baseline + noise_emg;

% Bandpass Filtering (5 - 15 Hz for QRS energy isolation)
[b_filt, a_filt] = butter(2, [5 15]/(fs/2), 'bandpass');
ecg_filtered = filtfilt(b_filt, a_filt, ecg_noisy);

% Derivative & Squaring
ecg_diff = diff([0 ecg_filtered]);
ecg_squared = ecg_diff .^ 2;

% Moving Average Integration
win_len = round(0.15 * fs);
ecg_integrated = movmean(ecg_squared, win_len);

% Peak Detection
[pks, locs] = findpeaks(ecg_integrated, 'MinPeakHeight', 0.15 * max(ecg_integrated), 'MinPeakDistance', round(0.4*fs));
rr_intervals = diff(locs) / fs;
detected_hr = 60 / mean(rr_intervals);

fprintf('ECG Signal Denoised & Processed Successfully!\n');
fprintf('Detected QRS Beats: %d\n', length(pks));
fprintf('Calculated Heart Rate: %.1f BPM (Target: %d BPM)\n', detected_hr, hr);
