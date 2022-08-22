---
title: "ENSO (El Nino-Southern Oscillation) prediction with Deep Learning"
excerpt: "Comparing deep learning models to predict ENSO (Summer Quarter 2022) <br/><img src='/personal_page/images/oceanhwlogo.png'>"
date: 2022-08-19
collection: portfolio
---

Project Summary
-----
We propose a project to develop a framework for ENSO prediction using a range of machine learning approaches and benchmark their skill against other methods. Identify observables that are most relevant for ENSO predictability at a particular timescale.

Data Description
-----
- Coarsened CESM2 Large Ensemble members (SST fields) from 1° to 3° resolution 
- Used the first 10 of 100 CESM2 LE members

Deep Learning Components
-----
- 2D CNN (ReLU/SeLU, adam/nadam/adamx)
- 3D CNN (ReLU/SeLU, adam/nadam/adamx)
- EOF/LSTM
- CNN/LSTM
- Baseline method (Persistence method, AR1 model)

You can see the ENSO prediction project from [this website](https://docs.google.com/presentation/d/12yYrVOETeDXEHKlPZ1OPy8gSXGozRJ72/edit?usp=sharing&ouid=111659501692119805685&rtpof=true&sd=true).
