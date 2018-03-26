## Recurrence Quantification Analysis for remote sensing time series

We explore Recurrence Quantification Analysis for hyper-temporal time series of Sentinel-1 data.


### What is that ?

Recurrence Quantification Analysis is another possibility to do multi-temporal metrics.
In this paper we want to explore the advantages and disadvantages of RQA compared to simple multi-temporal statistics.

For RQA have a look at http://www.recurrence-plot.tk/glance.php.

## Recurrence Plots

Recurrence plots have been proposed by Eckmann et al 1987. They are method to visualize the recurrences of a time series. They are a quadratic matrix which entries are defined as follows:
$R_{i,j} = θ(ϵ - \abs{x_i - x_j}, i,j = 1,...,N$
