using Revise
using Pkg
#Pkg.activate("rqa_paper_julia")
includet("raster_utils.jl")
includet("recurrencequant.jl")

import StatsBase.quantile

using Dates

function prep_data(path, orb::String)
    arr = readasarray(path)
    bandnames = getbandnames(path)
    orbits = getorbits(bandnames)
    indices = find(x->x==orb,orbits)
    arr_small = remove_na(arr)
    arr_small = arr_small[:,indices]
    arr_small, indices
end


function prep_data(path, metapath, startdate::Date, enddate::Date)
    arr = readasarray(path)
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
    arr = readasarray(path)
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

plot!(gdates, [laubmed, laubimfs...], layout=(3,2))
laubimfs = ceemd(laubmed, dint, num_imfs=4)
d = gdates .- gdates[1]