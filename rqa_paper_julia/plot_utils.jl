using PyPlot
using RecurrenceAnalysis

dB(x) = 10 * log10(x)

<<<<<<< HEAD
function plot_ts_rp(dates, ts1, ts2, outpath)
    rp1 = RecurrenceMatrix(dB.(ts1), 1)
    rp2 = RecurrenceMatrix(dB.(ts2), 1)
=======
function plot_ts_rp(dates, ts1, ts2)
    rp1 = RecurrenceMatrix(dB.(ts1), 4)
    rp2 = RecurrenceMatrix(dB.(ts2), 4)
>>>>>>> d529ff5ccef680ea9b48388d8d82125f98a452d4
    figure(figsize=(12,8))
    subplot2grid((3,2), (0,0))
    plot(dB.(ts1))
    subplot2grid((3,2), (0,1))
    plot(dB.(ts2))
    subplot2grid((3,2), (1,0), rowspan=2)
<<<<<<< HEAD
    imshow(grayscale(rp1), extent=(0,length(ts1), 0, length(ts1)), cmap="binary_r")
    subplot2grid((3,2), (1,1), rowspan=2)
    imshow(grayscale(rp2), extent=(0,length(ts2), 0,length(ts2)), cmap="binary_r")
    savefig(outpath)
=======
    imshow(grayscale(rp1), cmap="binary_r")
    subplot2grid((3,2), (1,1), rowspan=2)
    @show rqa(rp1)
    @show rqa(rp2)
    imshow(grayscale(rp2), cmap="binary_r")
>>>>>>> d529ff5ccef680ea9b48388d8d82125f98a452d4
end
