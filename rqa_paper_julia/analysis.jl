#using Revise
#using Pkg
using Statistics
#Pkg.activate("rqa_paper_julia")
#includet("raster_utils.jl")
#includet("recurrencequant.jl")

import StatsBase.quantile

using Dates

function prep_data(path, orb::String)
    arr,geoinfo = readasarray(path, "all")
    bandnames = getbandnames(path)
    orbits = getorbits(bandnames)
    indices = find(x->x==orb,orbits)
    arr_small = remove_na(arr)
    arr_small = arr_small[:,indices]
    arr_small, indices
end

function prep_data(path, metapath, startdate::Date, enddate::Date)
    arr, geoinfo = readasarray(path, "all")
    #@show size(arr)
    bandnames = getbandnames(metapath)
    dates = getdates(bandnames)
    #@show dates
    indices = findall(x->startdate<=x<=enddate,dates)
    arr_small =remove_na(arr)
    arr_small = arr_small[:,indices]
    arr_small, indices
end

function prep_data(path)
    arr, geoinfo = readasarray(path, "all")
    #@show typeof(arr)
    remove_na(arr)
end

rmext(path) = splitext(path)[1]
stackpaths(dir) = map(x->joinpath(dir,x), rmext.(filter(x-> occursin(".hdr", x), readdir(dir))))

datdir = "/media/data/rqa_paper/"
plotsdir = joinpath(datdir, "plots")
refstacks = stackpaths(plotsdir)

lastsplit(str, dlm) = String(split(str, dlm)[end])
crop_list = lastsplit.(basename.(refstacks), "_")

metapath = joinpath(datdir, "S1_tile_1_timestack_VH_A___lin")
#arrs_2017_VH_A_ref = map(x->prep_data(x, metapath, Date(2017,1,1),Date(2017,12,31)), refstacks)


tmedian(x)  = dropdims(mapslices(median, x, dims=[1]), dims=1)
medians = tmedian.(prep_data.(refstacks))
nul(x) = x .==0
b = nul.(medians)[3]
dates = getdates(metapath)
gdates = dates[.!b]
goodmedians = getindex.(medians, Ref(.!b))
d = gdates .- gdates[1]
dint = getfield.(d, :value)
