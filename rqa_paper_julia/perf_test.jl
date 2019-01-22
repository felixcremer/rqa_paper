include("recurrencequant.jl")
function main()
    path = "/home/crem_fe/Documents/HyperSense/testsites/Hidalgo/S1_Hidalgo_timestack_VV_lin_ceemdan_filtered_20141003_to_20171029_6_1"
    arr = readasarray(path)
    spatial_rec(arr)
end

main()
