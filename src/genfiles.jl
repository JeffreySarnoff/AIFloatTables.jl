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

function generate_files(; minbits, maxbits)
    global sfdirs10, sedirs10, ufdirs10, uedirs10,
           sfdirs16, sedirs16, ufdirs16, uedirs16
    
    for bits in minbits:maxbits
        println("radix 10 bits = $bits")
        for (sfx, fdirs) in (("sf", sfdirs10),
                             ("se", sedirs10),
                             ("uf", ufdirs10),
                             ("ue", uedirs10))
            filedir = fdirs[bits]
            filename = string("binary", bits, sfx, ".base10.csv")
            SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat = FloatIds[sfx]    
            gen_base10_csv(bits; filedir, filename, SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat)
        end
    end

    for bits in minbits:maxbits
        println("radix 16 bits = $bits")
        for (sfx, fdirs) in (("sf", sfdirs16),
                             ("se", sedirs16),
                             ("uf", ufdirs16),
                             ("ue", uedirs16))
            filedir = fdirs[bits]
            filename = string("binary", bits, sfx, ".base16.csv")
            SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat = FloatIds[sfx]    
            gen_base16_csv(bits; filedir, filename, SignedFloat, UnsignedFloat, ExtendedFloat, FiniteFloat)
        end
    end

end
