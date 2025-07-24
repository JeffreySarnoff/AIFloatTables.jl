#=
formed in config

 hex_sfinite_dirs,  hex_sextended_dirs,
 hex_ufinite_dirs,  hex_uextended_dirs,

 dec_sfinite_dirs,  dec_sextended_dirs,
 dec_ufinite_dirs,  dec_uextended_dirs,

 '''
julia>     hex_sfinite_dirs
15-element Vector{String}:
 ""
 "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits2"
 "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits3"
 ⋮
 "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits14"
 "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits15"
'''

=#


FloatIds = Dict()
FloatIds["sf"] = (; SignedFloat=true, UnsignedFloat=false, ExtendedFloat=false, FiniteFloat=true)
FloatIds["se"] = (; SignedFloat=true, UnsignedFloat=false, ExtendedFloat=true, FiniteFloat=false)
FloatIds["uf"] = (; SignedFloat=false, UnsignedFloat=true, ExtendedFloat=false, FiniteFloat=true)
FloatIds["ue"] = (; SignedFloat=false, UnsignedFloat=true, ExtendedFloat=true, FiniteFloat=false)

function generate_files(dirs; minbits, maxbits)
    dirs10 = dirs.decimaldirs
    dirs16 = dirs.hexadecimaldirs
    
    for bits in minbits:maxbits
        println("radix 10 bits = $bits")
        for (sfx, filedir) in (("sf", dirs10.sfdir),
                               ("se", dirs10.sedir),
                               ("uf", dirs10.ufdir),
                               ("ue", dirs10.uedir))
            filename = string("binary", bits, sfx, ".dec.csv")
            SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat = FloatIds[sfx]    
            gen_base10_csv(bits; filedir, filename, SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat)
        end
    end

    for bits in minbits:maxbits
        println("radix 16 bits = $bits")
        for (sfx, filedir) in (("sf", dirs16.sfdir),
                               ("se", dirs16.sedir),
                               ("uf", dirs16.ufdir),
                               ("ue", dirs16.uedir))
            filename = string("binary", bits, sfx, ".hex.csv")
            SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat = FloatIds[sfx]    
            gen_base16_csv(bits; filedir, filename, SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat)
        end
    end

end
