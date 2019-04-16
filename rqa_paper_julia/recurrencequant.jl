using RecurrenceAnalysis

include("raster_utils.jl")

#plotlyjs()

#path = "/home/qe89hep/data/sen4redd/S1_Hidalgo_timestack_VV_lin"
#arr = readasarray(path)


#forest_dist = distancematrix(arr[273,332,:])
#forest_dist2 = distancematrix(arr[274,332,:])
#change_dist = distancematrix(arr[875,907,:])
#agri_dist = distancematrix(arr[772,407,:])


function rec_stats(rec_mat, pixel, output, j,i, funcs)
    rec_mat = RecurrenceMatrix(pixel, 0.01)
    rqas = rqa(rec_mat)
    for (index, func) in enumerate(funcs)
        output[j,i, index]=rqas[func]
    end
    #det_arr[j,i]=determinism(rec_mat)
end

function rec_stats(rec_mat, pixel, output, i, funcs)
    rec_mat = RecurrenceMatrix(pixel, 0.03)
    rqas = rqa(rec_mat)
    for (index, func) in enumerate(funcs)
        output[i, index]=rqas[func]
    end
    #det_arr[j,i]=determinism(rec_mat)
end

function dist_stats(rec_mat, pixel, output, j,i, funcs)
    rec_mat = recurrencematrix(pixel, 0.01, lmin=10)
    rqas = rqa(rec_mat)
    for (index, func) in enumerate(funcs)
        output[j,i, index]=rqas[string(func)]
    end
    #det_arr[j,i]=determinism(rec_mat)
end



function spatial_rec(arr::Array{T,3} where T<:Number)
    funcs = ["RR", "DET", "L", "Lmax", "DIV", "ENTR",
                "TND", "LAM", "TT", "Vmax"]
    rr_arr = zeros(eltype(arr), (size(arr)[1:2]...,length(funcs)))
    #det_arr = zeros(arr[:,:,1])
    rec_mat = RecurrenceMatrix(arr[1,1,:],0.1)
    for i∈1:size(arr,2)
        for j∈1:size(arr,1)
            rec_stats(rec_mat,filter(!isnan, arr[j,i,:]),rr_arr,j,i, funcs)
        end
    end
    println(size(rr_arr))
    #writearray(path*"rec_mat", output)
    rr_arr
end

function spatial_rec(arr::Array{T,2} where T<:Number)
    funcs = [:RR, :DET, :L, :Lmax, :DIV, :ENTR,
                :TREND, :LAM, :TT, :Vmax]
    rr_arr = zeros(eltype(arr), (size(arr,1)...,length(funcs)))
    #det_arr = zeros(arr[:,:,1])
    rec_mat = RecurrenceMatrix(arr[1,1,:],0.00001)
    for j∈1:size(arr,1)
        rec_stats(rec_mat,arr[j,:],rr_arr,j, funcs)
    end
    println(size(rr_arr))
    #writearray(path*"rec_mat", output)
    rr_arr
end

#@time rec_out = spatial_rec(arr)
#recurrencerate(s1_rec)
#writearray(path*"recurrence_stats", rec_out, "ENVI")
