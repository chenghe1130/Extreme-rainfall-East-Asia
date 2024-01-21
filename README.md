# README

## Overview
This repository contains the code used for the analysis presented in the article "The Overlooked Health Impacts of Extreme Rainfall Exposure in 32 East Asian Cities". The code is divided into two main parts: one written in Python and the other in R.

## Python Code
The Python script is used to process time-series daily precipitation data for various cities. By employing the Intensity-Duration-Frequency (IDF) model, it calculates the threshold values for extreme rainfall events across different return periods. Specifically, the code demonstrates this calculation for three distinct return periods: 2, 5, and 10 years.

## R Code
The R script contains the primary analysis model. It utilizes the Generalized Additive Model (GAM) with Distributed Lag Models (DLMs) to assess the impact of precipitation on respiratory mortality. The analysis is particularly focused on extreme rainfall events with a 5-year return period as example, which have been identified previously.

## Files in the Repository
- `idf_model.py`: Python code for calculating the threshold value of extreme rainfall events using the IDF model.
- `main analysis model.R`: R code for analyzing the effects of identified extreme rainfall events on respiratory mortality using GAM and DLMs.

## Usage
To use these scripts, ensure you have the required datasets and dependencies installed in your Python and R environments. 

## Citation
If you use this code in your research, please cite it as follows:
updated later

## Acknowledgments
This analysis was made possible by contributions from Jesús Casado Rodríguez, whose tutorials served as a reference for the IDF model calculations. You can find his work: (https://github.com/casadoj/Clases/tree/master/G1448-Hydrology/Precipitation).


Cheng He, January 2024
Fudan University & Helmholtz Zentrum Muenchen
