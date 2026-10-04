# ECG Arrhythmia Signal Processing, Wavelet Denoising & QRS Detection

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%20%7C%20R2024b-0076A8?logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Domain](https://img.shields.io/badge/Domain-Biomedical%20Engineering%20&%20Signal%20Processing-lightgrey.svg)](#)

A standalone MATLAB implementation of ECG Arrhythmia Signal Processing, Wavelet Denoising. Includes the governing dynamics, analytical formulations, and an executable script you can run directly without proprietary third-party dependencies.

## Overview

This repository provides a digital signal processing pipeline for ECG records. It applies bandpass filtering to remove baseline wander and muscle noise, detects QRS peaks using the Pan-Tompkins algorithm, and calculates RR intervals for heart rate estimation.

## Governing Equations & Mathematical Formulation

### Pan-Tompkins Five-Point Derivative & Squaring

$$
y[n] = \frac{1}{8} \left( 2x[n] + x[n-1] - x[n-3] - 2x[n-4] \right)
$$

$$
z[n] = y[n]^2
$$

### Moving Window Integration

$$
s[n] = \frac{1}{W} \sum_{k=0}^{W-1} z[n-k]
$$

where $W$ corresponds to the expected QRS duration (typically 150 ms).

## Getting Started

### Prerequisites
- MATLAB (tested on R2022b through R2024b)
- Standard base MATLAB installation (no paid external toolboxes required for this starter script)

### Running the Code
1. Clone the repository:
   ```bash
   git clone https://github.com/matlabsolutions-simulink/ecg-arrhythmia-classification-dsp-cnn.git
   cd ecg-arrhythmia-classification-dsp-cnn
   ```
2. Open MATLAB, navigate to the cloned folder, and run:
   ```matlab
   run_ecg_arrhythmia_analysis
   ```

## Need the Complete Simulink or Simscape Model?

If you are working on a university capstone, thesis, or lab assignment and need the complete `.slx` model with Simscape physical networks, custom parameter lookup tables, or automated test harnesses, our team at [MATLABSolutions.com](https://www.matlabsolutions.com/order-now.php?ref=github_ecg_arrhythmia_classification_dsp_cnn) provides custom academic simulation and consulting support.

## Technical Inquiries & Contact
- Website: [matlabsolutions.com](https://www.matlabsolutions.com)
- Custom Consulting Portal: [matlabsolutions.com/order-now.php](https://www.matlabsolutions.com/order-now.php)
- Email: info@matlabsolutions.com

## License
This project is open-source under the [MIT License](LICENSE).
