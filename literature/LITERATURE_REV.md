# Literature Review of Recurrence Quantification Analysis in remote sensing

The first aim of this review is to see if and how rqa has been used in the analysis of remote sensing data.
The second aim is to get an overview about the themes
that have been analysed with rqa and with that to understand the strength and weaknesses of rqa.


## Results

### Marwan_2013
Add a confidence measure to the detected variations
Detect significant change in dynamical systems such as
change in control parameters or chaos order and chaos-chaos transitions
Using bootstrapping to gain confidence levels
Looking at DET and LAM explicitly
Compute the RQA measure on a moving window to study time-dependent behaviour.
with a window size w and a step size s with overlap
They have the null hypothesis H_0:
The dynamics of the system X does not change over time
so the recurrence structure does not change, therefore the RQA measure M has
a certain distribution which is around some mean μ(M) and variance σ(M)

The idea is to assume a certain distribution for M
and check if it's pushed out of its normal range

Bootstrap the variance of M via moving windows
This works only under the assumption that the RQA measure is stable over time?
We get this by drawing B times from the local measures
Using a constant recurrence rate to detect the threshold.
Interpolate time series to equal sampling



Books I want to check:
Recurrence Quantification Analysis: Theory and Best practices
https://link.springer.com/book/10.1007/978-3-319-07155-8
Recurrence Plots and their Quantifications: Expanding Horizons
https://link.springer.com/book/10.1007/978-3-319-29922-8

## Recurrence Plots in Remote Sensing
<<<<<<< HEAD
Li_2010

### Marwan_2015

Marwan et al are using 316 MODIS EVI (Enhanced vegetation index) measurements at
a spatial resolution of 250m. They combine 21x21 pixel squares to one recurrence plot.
The find different recurrence plot appearances in Spain compared to Brasil.
They explain these differences with the different vegetatin dynamics in subhumid and semiarid climate.
Why are they combining multiple pixels into one recurrence plot?
What happens when we do this?
=======
How are recurrence plots used in remote sensing and especially on SAR data?

### Li_2010
using ten day NDVI time series
examines the relation between the NDVI time series and temperature and precipitation time series via Joint Recurrence plots
They use JPR to identify the synchronization of NDVI and climatic determinants.
Use RPs because they can handle short timeseries. What is short in this?
Can handle multi-variate data
They use joint recurrence plots, because they are well defined even when the
different time series have different dimensions or different units.
They use the following metrics:
Joint recurrence rate:
quantifies the degree of similarity between the respective recurrences
RR^{x,y} = sum(JR)/N^2

Joint probability of recurrence

??


NDVI data with 10 day temporal resolution and 1km spatial resolution.

### Li_2008

They use rqa on NDVI time series for LULC/LULCC mapping
They see higher determinism and predictability in natural ecosystems
and lower determinism in agriculture.
Best to use non-linear methods which can deal with short data
Using NOAA AVHRR NDVI data
study area around beijing
0m to 2500m above see level
growing season April to September
Vegetation limited by precipitation
8 km pixel with a temporal resolution of 15 days
They use EMD for preprocessing
Embedding, delay time and threshold have an high impact on the Results
538 time steps
Determine the embedding by false nearest neighbor analysis
and the time delay by average mutual information.
Choose the embedding where the false nearest neighbor rate keeps constant.
Spatial pattern of DET is consistent with different land cover classes.
low DET indicating agriculture.
These results are not übertragbar, because they depend on the inter annual
Schwankungen of NDVI
High predictability indicates woodland
all RPs have similar global patterns, relative non-interupted diagonals low number of isolated points
I think this could be due to the large pixel size.


# Open Questions
Maybe we should have another look at NDVI time series?
How good are they?
Do we know that Sentinel-1 time series are non-linear and non-stationary?
How can I conclude this?
How can I describe the Sentinel-1 time series data?
What is Luyapunov exponents, Kolmogorov entropy, correlation dimension, approximate entropy, sample entropy, permutation entropy?
>>>>>>> 7d8dbebf8646961a2f348f425ddee12b08767963
