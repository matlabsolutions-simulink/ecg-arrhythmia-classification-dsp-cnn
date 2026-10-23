# Ecg Arrhythmia Classification Dsp Cnn — Engineering FAQ & Troubleshooting

> Verified solutions to real student and researcher laboratory inquiries.

### Q: How to filter baseline wander and 50/60 Hz power-line interference in raw ECG signals before QRS detection?

**Verified Technical Solution:**

Raw clinical and wearable electrocardiogram (ECG) signals contain baseline wander caused by patient respiration (< 0.5 Hz) and AC power-line electromagnetic coupling (50 Hz or 60 Hz). A standard Pan-Tompkins DSP pre-processing pipeline in MATLAB includes:

1. **Baseline Wander Removal (Two-Stage Median Filter or High-Pass FIR):**
   Use a zero-phase forward-backward Butterworth high-pass filter with cutoff at 0.5 Hz:
   ```matlab
   fs = 360; % Sampling frequency (e.g. MIT-BIH Arrhythmia Database)
   [b_hp, a_hp] = butter(2, 0.5 / (fs/2), 'high');
   ecg_clean = filtfilt(b_hp, a_hp, ecg_raw);
   ```

2. **Power-Line Interference Notch Filter:**
   Apply an IIR Notch filter centered at $f_0 = 50$ or $60$ Hz with quality factor $Q = 35$:
   ```matlab
   f0 = 50; Q = 35;
   wo = f0 / (fs/2);
   bw = wo / Q;
   [b_notch, a_notch] = iirnotch(wo, bw);
   ecg_notch = filtfilt(b_notch, a_notch, ecg_clean);
   ```

3. **Bandpass Filtering for Pan-Tompkins QRS Energy:**
   QRS energy resides between 5 Hz and 15 Hz. Bandpass filtering maximizes the steep slope of the R-wave while suppressing P and T waves before differentiation and moving window integration.

Explore biomedical DSP and neural network architectures at https://www.matlabsolutions.com/projects/biomedical-signal-processing.php.

---

