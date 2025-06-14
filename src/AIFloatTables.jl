module AIFloatTables

using Printf, Tables, DataFrames, CSV, Latexify, PrettyTables
using AIFloats, BFloat16s, Quadmath

const U8   = Vector{UInt8}
const U16  = Vector{UInt16}

const V16 = Vector{Float16}
const V32 = Vector{Float32}
const V64 = Vector{Float64}
const V128 = Vector{Float128}

const B16 = Vector{BFloat16}

include("gentables.jl")
# include("genfiles.jl")

end # module AIFloatTables