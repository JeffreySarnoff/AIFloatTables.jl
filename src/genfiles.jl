import FloatsForAI: AIFloat, codes, floats

UnsignedFloat = SignedFloat = FiniteFloat = ExtendedFloat = true

basefiledir = s"C:/JuliaCon/juliacon/floatsforai/"

for bits in 2:8
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    unsigned_dir = joinpath(filedir, "unsigned")
    unsigned_hex_dir = joinpath(unsigned_dir, "hex")
    signed_dir = joinpath(filedir, "signed")
    signed_hex_dir = joinpath(signed_dir, "hex")
    
    mkpath(filedir)
    mkpath(unsigned_dir)
    mkpath(unsigned_hex_dir)
    mkpath(signed_dir)
    mkpath(signed_hex_dir)
    
    fileprefix = "binary" * decbits    
    
    filedir = unsigned_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = unsigned_hex_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = signed_dir
    cd(filedir)
    
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, ExtendedFloat)

    filedir = signed_hex_dir
    cd(filedir)

    filename = fileprefix * "sf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end



for bits in 9:10
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    unsigned_dir = joinpath(filedir, "unsigned")
    unsigned_hex_dir = joinpath(unsigned_dir, "hex")
    signed_dir = joinpath(filedir, "signed")
    signed_hex_dir = joinpath(signed_dir, "hex")
    
    mkpath(filedir)
    mkpath(unsigned_dir)
    mkpath(unsigned_hex_dir)
    mkpath(signed_dir)
    mkpath(signed_hex_dir)
    
    fileprefix = "binary" * decbits    
    
    filedir = unsigned_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = unsigned_hex_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = signed_dir
    cd(filedir)
    
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, ExtendedFloat)

    filedir = signed_hex_dir
    cd(filedir)

    filename = fileprefix * "sf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end


for bits in 11:15
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    unsigned_dir = joinpath(filedir, "unsigned")
    unsigned_hex_dir = joinpath(unsigned_dir, "hex")
    signed_dir = joinpath(filedir, "signed")
    signed_hex_dir = joinpath(signed_dir, "hex")
    
    mkpath(filedir)
    mkpath(unsigned_dir)
    mkpath(unsigned_hex_dir)
    mkpath(signed_dir)
    mkpath(signed_hex_dir)
    
    fileprefix = "binary" * decbits    
    
    filedir = unsigned_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = unsigned_hex_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = signed_dir
    cd(filedir)
    
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)

    filedir = signed_hex_dir
    cd(filedir)

    filename = fileprefix * "sf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end

for bits in 16:16
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    unsigned_dir = joinpath(filedir, "unsigned")
    unsigned_hex_dir = joinpath(unsigned_dir, "hex")
    signed_dir = joinpath(filedir, "signed")
    signed_hex_dir = joinpath(signed_dir, "hex")
    
    mkpath(filedir)
    mkpath(unsigned_dir)
    mkpath(unsigned_hex_dir)
    mkpath(signed_dir)
    mkpath(signed_hex_dir)
    
    fileprefix = "binary" * decbits    
    
    filedir = unsigned_dir
    cd(filedir)
#=
    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)
=#
    filedir = unsigned_hex_dir
    cd(filedir)

    filename = fileprefix * "uf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)

    filedir = signed_dir
    cd(filedir)
#=    
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
=#
    filedir = signed_hex_dir
    cd(filedir)

    filename = fileprefix * "sf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end


#    
end