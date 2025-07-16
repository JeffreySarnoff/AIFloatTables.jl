module AIFloatTables

export gencsv, genbigcsv, genhexcsv, about

using AIFloats
import AIFloats: typeforcode, typeforfloat
using Quadmath, Printf, Tables, CSV, PrettyTables, Latexify

const U8   = Vector{UInt8}
const U16  = Vector{UInt16}

const V16 = Vector{Float16}
const V32 = Vector{Float32}
const V64 = Vector{Float64}
const V128 = Vector{Float128}

basefile_dir = abspath(
    joinpath("C:/JuliaCon", "juliacon", "AIFloats"))

# index from bits=2  entry

ufinite_b16_dirs = ["",]
ufinite_b10_dirs = ["",]
sfinite_b16_dirs = ["",]
sfinite_b10_dirs = ["",]

uextended_b16_dirs = ["",]
uextended_b10_dirs = ["",]
sextended_b16_dirs = ["",]
sextended_b10_dirs = ["",]

cd("C:/github/AIFloatTables.jl/src")

basefile_dir = abspath(
   joinpath("C:/JuliaCon", "juliacon", "AIFloats"))
include("config2.jl")

# basefile_dir = abspath(
#    joinpath("C:/JuliaCon", "juliacon", "2025", "AIFloats"))
# include("config3.jl")

include("gentables.jl")

config()

for bits in 2:15
    println("bits = $bits")

    b16_ufdir = ufinite_b16_dirs[bits]
    b10_ufdir = ufinite_b10_dirs[bits] 
    b16_sfdir = sfinite_b16_dirs[bits]
    b10_sfdir = sfinite_b10_dirs[bits]

    b16_uedir = uextended_b16_dirs[bits]
    b10_uedir = uextended_b10_dirs[bits] 
    b16_sedir = sextended_b16_dirs[bits]
    b10_sedir = sextended_b10_dirs[bits]

    fileprefix = string("binary", bits)

    gencsv(bits ; filedir = b16_ufdir, filename = string(fileprefix, "uf", ".hex.csv"), UnsignedFloat, FiniteFloat)
    gencsv(bits ; filedir = b16_uedir, filename = string(fileprefix, "ue", ".hex.csv"), UnsignedFloat, ExtendedFloat)
    gencsv(bits ; filedir = b16_sfdir, filename = string(fileprefix, "sf", ".hex.csv"), SignedFloat, FiniteFloat)
    gencsv(bits ; filedir = b16_sedir, filename = string(fileprefix, "se", ".hex.csv"), SignedFloat, ExtendedFloat)

    gencsv(bits ; filedir = b10_ufdir, filename = string(fileprefix, "uf", ".csv"), UnsignedFloat, FiniteFloat)
    gencsv(bits ; filedir = b10_uedir, filename = string(fileprefix, "ue", ".csv"), UnsignedFloat, ExtendedFloat)
    gencsv(bits ; filedir = b10_sfdir, filename = string(fileprefix, "sf", ".csv"), SignedFloat, FiniteFloat)
    gencsv(bits ; filedir = b10_sedir, filename = string(fileprefix, "se", ".csv"), SignedFloat, ExtendedFloat)
end 

end # module AIFloatTables