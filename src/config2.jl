using AIFloats
import AIFloats: typeforcode, typeforfloat
using Tables, CSV, PrettyTables

UnsignedFloat = SignedFloat = FiniteFloat = ExtendedFloat = true

ufinite_b16_dirs = ["",]
ufinite_b10_dirs = ["",]
sfinite_b16_dirs = ["",]
sfinite_b10_dirs = ["",]

uextended_b16_dirs = ["",]
uextended_b10_dirs = ["",]
sextended_b16_dirs = ["",]
sextended_b10_dirs = ["",]

function config()
    file_dir = abspath(basefile_dir) # joinpath(basefile_dir, "bits$(decbits)")
    
    signed_dir = joinpath(file_dir, "signed")
    unsigned_dir = joinpath(file_dir, "unsigned")

    sfinite_dir = joinpath(signed_dir, "finite")
    sextended_dir = joinpath(signed_dir, "extended")
    ufinite_dir = joinpath(unsigned_dir, "finite")
    uextended_dir = joinpath(unsigned_dir, "extended")
    
    ufinite_b16_dir = joinpath(ufinite_dir, "base16")
    uextended_b16_dir = joinpath(uextended_dir, "base16")
    ufinite_b10_dir = joinpath(ufinite_dir, "base10")
    uextended_b10_dir = joinpath(uextended_dir, "base10")

    sfinite_b16_dir = joinpath(sfinite_dir, "base16")
    sextended_b16_dir = joinpath(sextended_dir, "base16")
    sfinite_b10_dir = joinpath(sfinite_dir, "base10")
    sextended_b10_dir = joinpath(sextended_dir, "base10")

    for bits in 2:15
        decbits = string(bits)
        println("bits = $decbits")
        dirbits = "bits$(decbits)"

        base16_ufdir = abspath(joinpath(ufinite_b16_dir, dirbits))
        base10_ufdir = abspath(joinpath(ufinite_b10_dir, dirbits))
        base16_sfdir = abspath(joinpath(sfinite_b16_dir, dirbits))
        base10_sfdir = abspath(joinpath(sfinite_b10_dir, dirbits))

        base16_uedir = abspath(joinpath(uextended_b16_dir, dirbits))
        base10_uedir = abspath(joinpath(uextended_b10_dir, dirbits))
        base16_sedir = abspath(joinpath(sextended_b16_dir, dirbits))
        base10_sedir = abspath(joinpath(sextended_b10_dir, dirbits))

        push!(ufinite_b16_dirs, base16_ufdir)
        push!(ufinite_b10_dirs, base10_ufdir)
        push!(sfinite_b16_dirs, base16_sfdir)
        push!(sfinite_b10_dirs, base10_sfdir)
        push!(uextended_b16_dirs, base16_uedir)
        push!(uextended_b10_dirs, base10_uedir)
        push!(sextended_b16_dirs, base16_sedir)
        push!(sextended_b10_dirs, base10_sedir)
        
        mkpath(base16_ufdir)
        mkpath(base10_ufdir)
        mkpath(base16_sfdir)
        mkpath(base10_sfdir)
        mkpath(base16_uedir)
        mkpath(base10_uedir)
        mkpath(base16_sedir)
        mkpath(base10_sedir)
    end
end
