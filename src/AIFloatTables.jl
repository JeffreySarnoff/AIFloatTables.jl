module AIFloatTables

using Pkg
cd(s"C:\\JuliaCon\\AIFloats\\"); using Pkg; Pkg.activate(pwd());

# export gencsv, genbigcsv, genhexcsv, about

using AIFloats
import AIFloats: typeforcode, typeforfloat
using Quadmath, Printf, Tables, CSV, PrettyTables, Latexify
using Printf

const U8   = Vector{UInt8}
const U16  = Vector{UInt16}

const V16 = Vector{Float16}
const V32 = Vector{Float32}
const V64 = Vector{Float64}
const V128 = Vector{Float128}

basefile_dir = abspath(
    joinpath("C:/JuliaCon", "AIFloats"))

# include("config.jl")
include("c:\\github\\AIFloatTables.jl\\src\\make.jl")

include("c:\\github\\AIFloatTables.jl\\src\\gentables.jl")
include("c:\\github\\AIFloatTables.jl\\src\\makecsvs.jl")


end # module AIFloatTables