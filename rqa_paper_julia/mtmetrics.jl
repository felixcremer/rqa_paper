using Statistics
using Dates


function nanmedian(x)
   ts = filter(!isnan, x)
   if size(ts,1) == 0
       return NaN
   end
   median(ts)
end

function nanquantile5(x)
   ts = filter(!isnan, x)
   if size(ts,1) == 0
       return NaN
   end
   quantile(ts, 0.05)
end

function nanquantile25(x)
   ts = filter(!isnan, x)
   if size(ts,1) == 0
       return NaN
   end
   quantile(ts, 0.25)
end

function nanquantile75(x)
   ts = filter(!isnan, x)
   if size(ts,1) == 0
       return NaN
   end
   quantile(ts, 0.75)
end

function nanquantile95(x)
   ts = filter(!isnan, x)
   if size(ts,1) == 0
       return NaN
   end
   quantile(ts, 0.95)
end

nanmean(x) = mean(filter(!isnan, x))


function mva(x)
    normintensityratio(x1, x2) = max(x1/x2, x2/x1)
    N = length(x)
    acc = zero(eltype(x))
    for i ∈ 1:(N-1), j ∈ (i+1):N
        acc += normintensityratio(x[i], x[j])
    end
    return 10 * log(2/(N*(N-1)) * acc)
end

function nanmva(x)
    ts = filter(!isnan, x)
    if size(ts,1) <= 1
        return NaN
    end
    mva(lin.(ts))
end

lin(x) = exp10(x/10)
dB(x) = 10 * log10(x)

const funcs = [nanmedian, nanmean, nanquantile5,
               nanquantile25, nanquantile75, nanquantile95, nanmva]

function getmetrics(arr::AbstractArray)
   arrs = []
   for func in funcs
      push!(arrs, mapslices(func, arr, dims=[3]))
   end
   return cat(arrs..., dims=3)
end

function getmetrics(path::String, low_value=-99., up_value=Inf; startdate=Date(2014,10,1), enddate=Date(2100,1,1), metapath=path)
    @show path
    dates = getdates(metapath)
    @show dates
    ind = startdate .<= dates .< enddate
    @show size(ind)
    arr, geoinfo = readasarray(path, ind)
    @show size(arr)
    arr[arr .<= low_value] .= NaN
    arr[arr .>= up_value] .=NaN
    metrics = getmetrics(dB.(arr))
    outpath = join([splitext(path)[1], "metrics" ,startdate, enddate])
    writearray(outpath, metrics, geoinfo)
end

function spatial_rec(path::String, ϵ, low_value=-99., up_value=Inf; startdate=Date(2014, 10,1), enddate=Date(2100,1,1))
    outpath = splitext(path)[1] * "rec_$(replace(string(ϵ), "." => "_"))_dist"
    @show outpath
    arr = readasarray(path)
    arr[arr .<= low_value] .= NaN
    arr[arr .>= up_value] .= NaN
    metrics = spatial_rec(dB.(arr), ϵ)
    writearray(outpath, metrics)
end
