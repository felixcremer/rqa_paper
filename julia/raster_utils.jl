using GDAL
using ArchGDAL; AG=ArchGDAL

function readasarray(inputpath::String)
    ArchGDAL.registerdrivers() do
        ArchGDAL.read(inputpath) do ds

            bands = ArchGDAL.nraster(ds)
            data = Array{Float64}(ArchGDAL.width(ds),ArchGDAL.height(ds), bands)
            ArchGDAL.rasterio!(ds, data,collect(Int32,1:bands))
        end
    end
end

function readasarray(inputpath::String)
    ArchGDAL.registerdrivers() do
        ArchGDAL.read(inputpath) do ds

            bands = ArchGDAL.nraster(ds)
            data = Array{Float64}(ArchGDAL.width(ds),ArchGDAL.height(ds), bands)
            ArchGDAL.rasterio!(ds, data,collect(Int32,1:bands))
        end
    end
end

function writearray(outpath::String, output::Array{Float64}, drivername="ENVI")
    ArchGDAL.registerdrivers() do
    	driver = ArchGDAL.getdriver(drivername)
    	print(driver)
    	rows, cols, bands = map(Int32, size(output))
    	println(rows)
    	println(cols)
    	println(bands)
    	ds = ArchGDAL.unsafe_create(outpath, driver, width=cols, height=rows, nbands=bands,dtype=Float64, options=[] )
    	ArchGDAL.rasterio!(ds, output, collect(Int32, 1:bands), GDAL.GF_Write)
    	#ArchGDAL.close(ds)
    	GDAL.close(ds.ptr)
    end
end
