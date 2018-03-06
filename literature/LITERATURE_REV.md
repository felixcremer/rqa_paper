# Literature Review of Recurrence Quantification Analysis in remote sensing

The first aim of this review is to see if and how rqa has been used in the analysis of remote sensing data.
The second aim is to get an overview about the themes
that have been analysed with rqa and with that to understand the strength and weaknesses of rqa.


## Results
Books I want to check:
Recurrence Quantification Analysis: Theory and Best practices
https://link.springer.com/book/10.1007/978-3-319-07155-8
Recurrence Plots and their Quantifications: Expanding Horizons
https://link.springer.com/book/10.1007/978-3-319-29922-8

## Recurrence Plots in Remote Sensing
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
