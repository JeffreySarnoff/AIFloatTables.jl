basefiledir = s"C:/JuliaCon/juliacon/tables/"

for bits in 2:10
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    mkpath(filedir)
    cd(filedir)
    fileprefix = "binary" * decbits
    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    gencsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end

for bits in 11:15
    println("bits = $bits")
    decbits = string(bits)
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    mkpath(filedir)
    cd(filedir)
    fileprefix = "binary" * decbits
    filename = fileprefix * "uf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)
    filename = fileprefix * "sf" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".csv"
    isfile(filename) && rm(filename); println(filename)
    genbigcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end

for bits in 2:15
    println("bits = $bits")
    hexbits = uppercase(string(bits; base=16))
    filedir = joinpath(basefiledir, "bits$(bits)")
    mkpath(filedir)
    cd(filedir)
    fileprefix = "binary" * string(bits)
    filename = fileprefix * "uf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, FiniteFloat)
    filename = fileprefix * "ue" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, UnsignedFloat, ExtendedFloat)
    filename = fileprefix * "sf" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, FiniteFloat)
    filename = fileprefix * "se" * ".hex.csv"
    isfile(filename) && rm(filename); println(filename)
    genhexcsv(bits; filedir, filename, SignedFloat, ExtendedFloat)
end

for bits in 2:15
#    
end