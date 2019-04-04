using PyPlot
using RecurrenceAnalysis

dB(x) = 10 * log10(x)

function plot_ts_rp(dates, ts1, ts2, outpath)
    rp1 = RecurrenceMatrix(dB.(ts1), 1)
    rp2 = RecurrenceMatrix(dB.(ts2), 1)
    figure(figsize=(12,8))
    subplot2grid((3,2), (0,0))
    plot(dates, dB.(ts1))
    subplot2grid((3,2), (0,1))
    plot(dates, dB.(ts2))
    subplot2grid((3,2), (1,0), rowspan=2)
    imshow(grayscale(rp1), extent=(0,length(ts1), 0, length(ts1)), cmap="binary_r")
    subplot2grid((3,2), (1,1), rowspan=2)
    imshow(grayscale(rp2), extent=(0,length(ts2), 0,length(ts2)), cmap="binary_r")
    savefig(outpath)
end
