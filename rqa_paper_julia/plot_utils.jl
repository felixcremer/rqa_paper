using PyPlot
using RecurrenceAnalysis
using Distributions
using Glob

dB(x) = 10 * log10(x)
dB(x::AbstractArray) = 10 .* log10.(x)

function plot_ts_rp_methods()
    x = range(0,100,length=10000)
    ts1 = sin.(x) + sin.(2 .*x)
    ts3 = sin.(x) .+ 0.03 .*x
    ts2 = zero(x)
    ts2[1:div(end,2)] .= rand.(Normal(3,1))
    ts2[div(end,2):end] .= rand.(Normal(0,1))
    ts3
    rp1 = RecurrenceMatrix(ts1, 0.2)
    rp2 = RecurrenceMatrix(ts2, 0.2)
    rp3 = RecurrenceMatrix(ts3, 0.2)
    figure(figsize=(12,8))
    subplot2grid((3,3), (0,0))
    PyPlot.plot(ts1)
    subplot2grid((3,3), (0,1))
    PyPlot.plot(ts2)
    subplot2grid((3,3), (0,2))
    PyPlot.plot(ts3)
    subplot2grid((3,3), (1,0), rowspan=2)
    imshow(grayscale(rp1), cmap="binary_r")
    subplot2grid((3,3), (1,1), rowspan=2)
    imshow(grayscale(rp2), cmap="binary_r")
    subplot2grid((3,3), (1,2), rowspan=2)
    imshow(grayscale(rp3), cmap="binary_r")
    savefig("latex/figs/rp_methods.png")
end

include("raster_utils.jl")

function set_paths(testsite)
    sendir = "/home/qe89hep/Daten/sen4redd/"
    s1dir = sendir * "S-1"
    s1paths = glob("*" * testsite * "*12", s1dir)
    append!(s1paths, glob("*" * testsite * "*emd_", s1dir))
    s1paths
end

function plotrp_hidalgo(kernel)
    hidalgopaths= set_paths("Hidalgo")
    def_center = [733, 673]
    for_center = [717, 686]

    for path in hidalgopaths
        arr = readasarray(path)
        pixel_def = pixelize(arr[def_center[1]-kernel:def_center[1]+kernel, def_center[2]-kernel:def_center[2]+kernel, :])
        pixel_for = pixelize(arr[for_center[1]-kernel:for_center[1]+kernel, for_center[2]-kernel:for_center[2]+kernel, :])
        plot_ts_rp_many(dB.(pixel_def), dB.(pixel_for))
        savefig(joinpath("latex/figs/", basename(path) * "_rp_deffor_$(kernel).png"))
    end
end

function plot_ts_rp_many(ts1, ts2, eps1=1, eps2=1)
    figure(figsize=(12,8))
    m1 = mean(ts1)
    @show size(m1)
    subplot2grid((3,2), (0,0))
    PyPlot.plot.(ts1, color="grey")
    PyPlot.plot(m1, color="red")
    rp1s = RecurrenceMatrix.(ts1, Ref(eps1))
    @show typeof(rp1s)
    #@show typeof(grayscale.(rp1s))
    rp1 = sum(grayscale.(rp1s))
    @show size(rp1)
    subplot2grid((3,2), (1,0), rowspan=2)
    imshow(rp1, cmap="binary_r")


    subplot2grid((3,2), (0,1))
    m2 = mean(ts2)
    PyPlot.plot.(ts2, color="grey")
    PyPlot.plot(m2, color="green")
    rp2s = RecurrenceMatrix.(ts2, Ref(eps2))
    @show typeof(rp2s)
    #@show typeof(grayscale.(rp1s))
    rp2 = sum(grayscale.(rp2s))
    @show size(rp2)
    subplot2grid((3,2), (1,1), rowspan=2)
    imshow(rp2, cmap="binary_r")
end

function plot_ts_rp(dates, ts1, ts2, eps1=1, eps2=1)
    figure(figsize=(12,8))
    rp1 = RecurrenceMatrix(ts1, eps1)
    rp2 = RecurrenceMatrix(ts2, eps2)

    subplot2grid((3,2), (0,0))
    PyPlot.plot(ts1)
    subplot2grid((3,2), (0,1))
    PyPlot.plot(ts2)
    subplot2grid((3,2), (1,0), rowspan=2)

    imshow(grayscale(rp1), cmap="binary_r")

    subplot2grid((3,2), (1,1), rowspan=2)
    @show rqa(rp1)
    @show rqa(rp2)
    imshow(grayscale(rp2), cmap="binary_r")
end

function pixelize(arr, nodata=-99)
    pixels = []
    for i in 1:size(arr, 1)
       for j in 1:size(arr, 2)
           pix = arr[i,j,:]
           if !all(pix .== nodata)
               push!(pixels, arr[i,j,:])
           end
       end
    end
    pixels
end
