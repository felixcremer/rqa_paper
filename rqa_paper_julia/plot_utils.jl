using PyPlot
using RecurrenceAnalysis

dB(x) = 10 * log10(x)

function plot_ts_rp(dates, ts1, ts2)
    rp1 = RecurrenceMatrix(dB.(ts1), 4)
    rp2 = RecurrenceMatrix(dB.(ts2), 4)
    figure(figsize=(12,8))
    subplot2grid((3,2), (0,0))
    plot(dB.(ts1))
    subplot2grid((3,2), (0,1))
    plot(dB.(ts2))
    subplot2grid((3,2), (1,0), rowspan=2)
    imshow(grayscale(rp1), cmap="binary_r")
    subplot2grid((3,2), (1,1), rowspan=2)
    @show rqa(rp1)
    @show rqa(rp2)
    imshow(grayscale(rp2), cmap="binary_r")
end
