using GDAL
using ArchGDAL; AG=ArchGDAL
using DataArrays

function readasarray(inputpath::String)
    println("Start")
    ArchGDAL.registerdrivers() do
        ArchGDAL.read(inputpath) do ds
            #@show ds
            bands = ArchGDAL.nraster(ds)
            #@show bands
            data = Array{Float64}(ArchGDAL.width(ds),ArchGDAL.height(ds), bands)
            ArchGDAL.rasterio!(ds, data,collect(Int32,1:bands))        end
    end
end

function writearray(outpath::String, output::Array{Float64}, drivername="ENVI")
    ArchGDAL.registerdrivers() do
    	driver = ArchGDAL.getdriver(drivername)
    	#print(driver)wr
    	rows, cols, bands = map(Int32, size(output))
    	#println(rows)
    	#println(cols)
    	#println(bands)
    	ds = ArchGDAL.unsafe_create(outpath, driver, width=cols, height=rows, nbands=bands,dtype=Float64, options=[] )
    	ArchGDAL.rasterio!(ds, output, collect(Int32, 1:bands), GDAL.GF_Write)
    	#ArchGDAL.close(ds)
    	GDAL.close(ds.ptr)
    end
end

function remove_na(arr, na_value=-99)
    arr_re = reshape(arr, :,size(arr)[3])
    ind_re = mapslices(x->all(y->y!=na_value,x), arr_re, [2])
    arr_re_small = arr_re[find(ind_re),:]
end

function getdates(inputpath)
    ArchGDAL.registerdrivers() do
        ArchGDAL.read(inputpath) do dataset
             #band = ArchGDAL.getband(dataset, 1)
             #print(AG.metadata(dataset))
             bands = getbandnames(dataset)
             dates = getdates(bands)
        end
    end
end

function getbandnames(inputpath::AbstractString)
    ArchGDAL.registerdrivers() do
        AG.read(inputpath) do dataset
            #@show typeof(dataset)
            getbandnames(dataset)
        end
    end
end

function getbandnames(dataset)
    meta = AG.metadata(dataset)
    #@show meta
    meta_split = map(x->split(x, "="),meta)
    #by_func = x -> parse(Int,replace(match(r"_\d",x[1]).match,"_",""))
    filter!(x->ismatch(r"^Band",x[1]),meta_split)
    by_func =  x-> parse(Int, replace(match(r"_(?<number>\d+)",x[1])[:number], "_",""))

    sort!(meta_split, by = by_func)
    map(x->x[2],meta_split)
end

getname(band) = getbandnames(AG.getdataset(band))[AG.getnumber(band)]

#AG.registerdrivers() do
#    AG.read("/home/qe89hep/data/temp/S1_Hidalgo_timestack_VV_lin") do dataset
#        band = AG.getband(dataset, 1)
#        #print(AG.getdataset(band))
#        println(getname(band))
#    end
#end


#meta_split = getbandnames("/home/qe89hep/data/temp/S1_Hidalgo_timestack_VV_lin")
#getbandnames("/home/qe89hep/data/temp/S1_Hidalgo_timestack_VV_lin_forest_092016_102017")

"""function getorbits(inputpath)
    ArchGDAL.registerdrivers() do
        ArchGDAL.read(inputpath) do dataset
             #band = ArchGDAL.getband(dataset, 1)
             print(AG.metadata(dataset))
             reg = r"_(A|D)_"
             dates = map(x->replace(match(reg, x).match,"_",""), AG.metadata(dataset))
        end
    end
end"""

function getdates(input::Array{T} where T<:AbstractString,reg = r"[0-9]{8}", df = dateformat"yyyymmdd")

            dates = map(x->Date(match(reg, x).match,df), input)
end

function getorbits(input::Array{T} where T<:AbstractString)
          reg = r"_(?<orbit>A|D)_"
          orbits = map(x->match(reg,x)[:orbit], input)
end
