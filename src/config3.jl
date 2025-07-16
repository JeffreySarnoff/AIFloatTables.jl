using AIFloats
import AIFloats: typeforcode, typeforfloat
using Tables, CSV, PrettyTables

UnsignedFloat = SignedFloat = FiniteFloat = ExtendedFloat = true

function config()
    file_dir = abspath(basefile_dir) # joinpath(basefile_dir, "bits$(decbits)")
    
    dec_dir = file_dir # joinpath(file_dir, "base10")
    hex_dir = joinpath(file_dir, "base16")
    
    dec_signed_dir = joinpath(dec_dir, "signed")
    dec_unsigned_dir = joinpath(dec_dir, "unsigned")
    hex_signed_dir = joinpath(hex_dir, "signed")
    hex_unsigned_dir = joinpath(hex_dir, "unsigned")

    dec_sfinite_dir = joinpath(dec_signed_dir, "finite")
    dec_sextended_dir = joinpath(dec_signed_dir, "extended")
    dec_ufinite_dir = joinpath(dec_unsigned_dir, "finite")
    dec_uextended_dir = joinpath(dec_unsigned_dir, "extended")
    
    hex_sfinite_dir = joinpath(hex_signed_dir, "finite")
    hex_sextended_dir = joinpath(hex_signed_dir, "extended")
    hex_ufinite_dir = joinpath(hex_unsigned_dir, "finite")
    hex_uextended_dir = joinpath(hex_unsigned_dir, "extended")
    
    for bits in 2:15
        decbits = string(bits)
        println("bits = $decbits")
        dirbits = "bits$(decbits)"

        base16_ufdir = abspath(joinpath(hex_ufinite_dir, dirbits))
        base10_ufdir = abspath(joinpath(dec_ufinite_dir, dirbits))
        base16_sfdir = abspath(joinpath(hex_sfinite_dir, dirbits))
        base10_sfdir = abspath(joinpath(dec_sfinite_dir, dirbits))

        base16_uedir = abspath(joinpath(hex_uextended_dir, dirbits))
        base10_uedir = abspath(joinpath(dec_uextended_dir, dirbits))
        base16_sedir = abspath(joinpath(hex_sextended_dir, dirbits))
        base10_sedir = abspath(joinpath(dec_sextended_dir, dirbits))

        push!(hex_ufinite_dirs, base16_ufdir)
        push!(dec_ufinite_dirs, base10_ufdir)
        push!(hex_sfinite_dirs, base16_sfdir)
        push!(dec_sfinite_dirs, base10_sfdir)
        push!(hex_uextended_dirs, base16_uedir)
        push!(dec_uextended_dirs, base10_uedir)
        push!(hex_sextended_dirs, base16_sedir)
        push!(dec_sextended_dirs, base10_sedir)
        
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
