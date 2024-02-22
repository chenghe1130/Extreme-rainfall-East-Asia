# README

## Overview
This repository contains the code used for the analysis presented in the article "The overlooked health impacts of extreme rainfall exposure in 30 East Asian cities". The code is divided into two main parts: one written in Python and the other in R.

## Python Code
The Python script is used to process time-series daily precipitation data for various cities. By employing the Intensity-Duration-Frequency (IDF) model, it calculates the threshold values for extreme rainfall events across different return periods. Specifically, the code demonstrates this calculation for three distinct return periods: 2, 5, and 10 years.

## R Code
The R script contains the primary analysis model. It utilizes the Generalized Additive Model (GAM) with Distributed Lag Models (DLMs) to assess the impact of extreme rainfall events on respiratory mortality. The analysis is particularly focused on extreme rainfall events with a 5-year return period as an example, which have been identified previously.

## Files in the Repository
- `calculate the threshold value.py`: Python code for calculating the threshold value of extreme rainfall events using the IDF model.
- `main analysis model.R`: R code for analyzing the effects of identified extreme rainfall events on respiratory mortality using GAM and DLMs.

## Usage
To use these scripts, ensure you have the required datasets and dependencies installed in your Python and R environments. 

## Citation
If you use this code in your research, please cite our study:
He, C., Kim, H., Hashizume, M. et al. The overlooked health impacts of extreme rainfall exposure in 30 East Asian cities. Nat Sustain (2024). https://doi.org/10.1038/s41893-024-01294-x

## Acknowledgments
Jesús Casado Rodríguez’s tutorials served as a reference for the IDF model calculations. You can find his work: (https://github.com/casadoj/Clases/tree/master/G1448-Hydrology/Precipitation).


Cheng He, January 2024
Fudan University & Helmholtz Zentrum Muenchen
