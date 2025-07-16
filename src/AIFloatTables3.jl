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
    joinpath("C:/JuliaCon", "juliacon", "2025", "AIFloats"))
# index from bits=2  entry

hex_ufinite_dirs = ["",]
dec_ufinite_dirs = ["",]
hex_sfinite_dirs = ["",]
dec_sfinite_dirs = ["",]

hex_uextended_dirs = ["",]
dec_uextended_dirs = ["",]
hex_sextended_dirs = ["",]
dec_sextended_dirs = ["",]

cd("C:/github/AIFloatTables.jl/src")

# basefile_dir = abspath(
#    joinpath("C:/JuliaCon", "juliacon", "AIFloats"))
# include("config2.jl")

basefile_dir = abspath(
    joinpath("C:/JuliaCon", "2025", "AIFloats"))
include("config3.jl")

include("gentables.jl")

config()


for bits in 2:8

    SignedFloat   = true; ExtendedFloat = true;
    UnsignedFloat = true; FiniteFloat   = true;

    println("bits = $bits")

    b16_ufdir = hex_ufinite_dirs[bits]
    b10_ufdir = dec_ufinite_dirs[bits] 
    b16_sfdir = hex_sfinite_dirs[bits]
    b10_sfdir = dec_sfinite_dirs[bits]

    b16_uedir = hex_uextended_dirs[bits]
    b10_uedir = dec_uextended_dirs[bits] 
    b16_sedir = hex_sextended_dirs[bits]
    b10_sedir = dec_sextended_dirs[bits]

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


for bits in 2:8

    SignedFloat   = true; ExtendedFloat = true;
    UnsignedFloat = true; FiniteFloat   = true;

    println("bits = $bits")

    b16_ufdir = hex_ufinite_dirs[bits]
    b10_ufdir = dec_ufinite_dirs[bits] 
    b16_sfdir = hex_sfinite_dirs[bits]
    b10_sfdir = dec_sfinite_dirs[bits]

    b16_uedir = hex_uextended_dirs[bits]
    b10_uedir = dec_uextended_dirs[bits] 
    b16_sedir = hex_sextended_dirs[bits]
    b10_sedir = dec_sextended_dirs[bits]

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