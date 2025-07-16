using AIFloats
import AIFloats: typeforcode, typeforfloat
using Tables, CSV, PrettyTables

UnsignedFloat = SignedFloat = FiniteFloat = ExtendedFloat = true

function config()

    file_dir = abspath(basefile_dir) # joinpath(basefile_dir, "bits$(decbits)")
    
    signed_dir = joinpath(file_dir, "signed")
    unsigned_dir = joinpath(file_dir, "unsigned")
    
    b16_unsigned_dir = joinpath(unsigned_dir, "base16")
    b10_unsigned_dir = joinpath(unsigned_dir, "base10")
    b16_signed_dir = joinpath(signed_dir, "base16")
    b10_signed_dir = joinpath(signed_dir, "base10")
    
    for bits in 2:15
        decbits = string(bits)
        println("bits = $decbits")
        dirbits = "bits$(decbits)"

        base16_udir = abspath(joinpath(b16_unsigned_dir, dirbits))
        base10_udir = abspath(joinpath(b10_unsigned_dir, dirbits))
        base16_sdir = abspath(joinpath(b16_signed_dir, dirbits))
        base10_sdir = abspath(joinpath(b10_signed_dir, dirbits))

        push!(b16_unsigned_dirs, base16_udir)
        push!(b10_unsigned_dirs, base10_udir)
        push!(b16_signed_dirs, base16_sdir)
        push!(b10_signed_dirs, base10_sdir)
        
        mkpath(base16_udir)
        mkpath(base10_udir)
        mkpath(base16_sdir)
        mkpath(base10_sdir) 
    end
end
