# Quegan et al 2000
Not exactly clear what they are doing

# Engdahl 2003
## Data and Features
use 14 ERS 1/2 pairs and convert them to 28 intensity images, 14 insar coherences and 2 coherences with long baseline
Make a Principal component analysis of the time series with first substracting the temporal mean.
They used the temporal mean, first principal component both of the insar and the intensity time series
ans well as the average of the two coherence images with long baselines (36 and 246 days)
*All of these features discard the temporal order of the timeseries.*

## Results

we have 6 features and we are looking at 8 reference classes namely:
- water bodies
- Agricultural fields, bare soil
- Dense forest
- Sparse Forest
- Low residential area
- High residential area
- industrial buildings
- Dense urban multistory buildings

They make a water mask using a certain hand picked tandem pairs with calm and windy conditions, this works only when we have different wind conditions and when the water bodies are high enough to be affected by wind.
They do this because otherwise the water body differences would be the main factor in the principal component of the coherence time series.
no seperabiltiy between open fields and the forest classes with mean intensity, longtime coherence, and tandem coherence pc2, hardly any seperability of dense forest and sparse forest
