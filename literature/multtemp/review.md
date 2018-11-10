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


They aggregate the residential areas and the industrial buildings into a mixed urban class.
At least 100 reference points per class
The reference points are detected using high resolution aerial images and the national forest inventory.
They make a water mask using certain hand picked tandem pairs with calm and windy conditions, this works only when we have different wind conditions and when the water bodies are large enough to be affected by wind.
They do this because otherwise the water body differences would be the main factor in the principal component of the coherence time series.
no seperabiltiy between open fields and the forest classes with mean intensity, longtime coherence, and tandem coherence pc2, hardly any seperability of dense forest and sparse forest
Very large boxes for the Urban classes espacially in the mean backscatter intensity. *This is explainable by looking direction i think, mean backscatter in urban areas is mostly driven by double bounce and this is influenced by the direction of the walls.*
Very similar intensity pc1 for every class except fields.

*So this study showed, that using backscatter intensity with non-ordered metrics, we can distinguish between field and everything else with PCT and between Dense urban areas and everything else by the mean backscatter.
This is not surprising, because in dense urban areas we have a high amount of double bounce. This study shows, that we should have a look into insar coherence time series but this is something i want to investigate in another paper. I Should talk with Clemence about that.*

# De Grandi 2004
Not interesting for our study

# Yan 2017

Use 50 Images from Sentinel1 from March 8 2015 till august 18 2017
They use pca and ica spatially (I think) so this is also not relevant for this study.

# Santoro 2012
They show that the combination of minimum backscatter and mva mean annual variability (measure devoloped by Quegan) is suitable to detect constant water bodies with a straight forward thresholding approach.
From Figure 2 it is visible that the combination of min and mva is needed to distinguish water from artificial surfaces because mva is not enough and it is hard to make a clear threshold for water vs cropland in both metrics.
*Maybe i should also look into the combinated seperability using two metrics*

# Thiel 2009
Histogram analysis of multi-temporal statistics derived from 13 ERS and ENVISAT acquisitions in VV and 14 Enivsat HH HV scenes
They use the metrics, minimum, maximum mean, and mean annual variation (mva)
and look at Forest, Settlement, Grassland and Agriculture

## Results
High separability of water to anything else in VV MVA and VV min, hv mean, hv max, hh min, hh mva,
weak separability of grassland in vv max
high separability of grassland in hv max
separability of agriculture in hv mva
differentiation of forest and grassland is possible in mean, max and min of all three polarisations
No separability of forest and settlement with these multi-temporal metrics


# Bruzzone 2004
uses 8 ERS scenes
uses long term coherence and temporal variability using standard deviation
They use these features as input for a neural net, but I didn't look at that.
They don't show the histogram of std, the histogram of long term coherence indicates a lala separability of urban areas and no other separability.
Every other land cover class decoherenced with a long enough baseline.


# Park 2008
Use average backscatter intensity, temporal variability and long time coherence
as well as principal component analysis
using 9 radarsat-1 scenes ascending  HH and 11 envisat asar scenes descending VV
envisat is one year, radarsat is april to october 2005
Good separability of water and urban areas using the mean *they say* from the boxplot I only see good separability of water to all other classes on the radarsat mean


# Summary
The hard part is distinguishing between forest, agriculture ( includes paddy and dry fields),
but it is easier to distinguish between water and rest and urban and rest.
So I should focus on the separability between agriculture and forest.
