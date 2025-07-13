module AIFloatTables

export gencsv, genbigcsv, genhexcsv, about

using Printf, Tables, DataFrames, CSV, Latexify, PrettyTables
using FloatsForAI, Quadmath

const U8   = Vector{UInt8}
const U16  = Vector{UInt16}

const V16 = Vector{Float16}
const V32 = Vector{Float32}
const V64 = Vector{Float64}
const V128 = Vector{Float128}


include("gentables.jl")

UnsignedFloat = SignedFloat = FiniteFloat = ExtendedFloat = true
basefiledir = s"C:/JuliaCon/juliacon/floatsforai/"

# include("genfiles.jl")

end # module AIFloatTables