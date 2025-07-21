setprecision(BigFloat, 5)
SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true

function rmfile(filepath)
    if isfile(filepath)
        rm(filepath)
    end
end

function rmfile(filedir, filename)
    rmfile( joinpath(filedir,filename) )
end

lo,hi = 2,15

# base10

include("base10_csvs.jl")

# base16

include("base16_csvs.jl")




