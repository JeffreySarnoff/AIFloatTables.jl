setprecision(BigFloat, 1024)
Quadmath.Float128(str::String) = Float128(BigFloat(str))

const float128safemin = Float128("9.16801933777423582810706196024241583e-2467")
const float128safemax = Float128("5.45374067809707964731492122366891431e+2465")

function scalb(significand::F, binary_exponent::S) where {F<:AbstractFloat, S<:Signed}
    res = ldexp(significand, binary_exponent)
    fr, xp = frexp(res)
    xp -= binary_exponent
    cmp = ldexp(fr, xp)
    if cmp != res
        sig = BigFloat(significand)
        binary_exponent = Int128(binary_exponent)
        res = ldexp(sig, binary_exponent)
        cmp = F(res)
        if cmp == res
            res = cmp
        end
    end
    res
end

function safe_bounds(::Type{T}) where {T<:AbstractFloat}
    mn = (sqrt(floatmin(T))) / 2
    mx = (sqrt(floatmax(T))) / 2
    mn_exp = exponent(mn)
    mx_exp = exponent(mx)
    ldexp(one(T), mn_exp), ldexp(one(T), mx_exp)
end


dr = "C:\\JuliaCon\\juliacon\\aifloats"
decdr = "C:\\JuliaCon\\juliacon\\aifloats_decfmt"
hexdr = "C:\\JuliaCon\\juliacon\\aifloats_hexfmt"
bdirs = Tuple([joinpath(dr, string("bits",i)) for i in 2:15]);
decdirs = Tuple([joinpath(decdr, string("bits",i)) for i in 2:15]);
hexdirs = Tuple([joinpath(hexdr, string("bits",i)) for i in 2:15]);

# remove any unorganized files
for d in bdirs
    cd(d)
    files = filter(isfile, readdir())
    map(rm, files)
end

udirs = Tuple([joinpath(bitsdir, "unsigned") for bitsdir in bdirs])
sdirs = Tuple([joinpath(bitsdir, "signed") for bitsdir in bdirs])

udecdirs = Tuple([joinpath(bitsdir, "unsigned") for bitsdir in decdirs])
sdecdirs = Tuple([joinpath(bitsdir, "signed") for bitsdir in decdirs])

uhexdirs = Tuple([joinpath(bitsdir, "unsigned") for bitsdir in hexdirs])
shexdirs = Tuple([joinpath(bitsdir, "signed") for bitsdir in hexdirs])

udecdirsin = Tuple([joinpath(bitsdir, "decimal") for bitsdir in udecdirs])
sdecdirsin = Tuple([joinpath(bitsdir, "decimal") for bitsdir in sdecdirs])

uhexdirsin = Tuple([joinpath(bitsdir, "hex") for bitsdir in uhexdirs])
shexdirsin = Tuple([joinpath(bitsdir, "hex") for bitsdir in shexdirs])



for (indir, outdir) in zip(udecdirsin, udecdirs)
    cd(indir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(indir, x), files)
    outfiles = map(x-> joinpath(outdir, x), files)
    for (infi, outfi) in zip(curfiles, outfiles)
        mv(infi, outfi)
    end
    # rm(indir; force=true)
end    
        
for (indir, outdir) in zip(sdecdirsin, sdecdirs)
    cd(indir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(indir, x), files)
    outfiles = map(x-> joinpath(outdir, x), files)
    for (infi, outfi) in zip(curfiles, outfiles)
        mv(infi, outfi)
    end
    # rm(indir; force=true)
end    
        
for (indir, outdir) in zip(shexdirsin, shexdirs)
    cd(indir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(indir, x), files)
    outfiles = map(x-> joinpath(outdir, x), files)
    for (infi, outfi) in zip(curfiles, outfiles)
        mv(infi, outfi)
    end
    # rm(indir; force=true)
end    

for (indir, outdir) in zip(uhexdirsin, uhexdirs)
    cd(indir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(indir, x), files)
    outfiles = map(x-> joinpath(outdir, x), files)
    for (infi, outfi) in zip(curfiles, outfiles)
        mv(infi, outfi)
    end
    # rm(indir; force=true)
end    
         



for (indir, outdir) in zip(udecdirsin, udecdirs)
    files = filter(isfile, readdir(indir))
    curfiles = map(x-> joinpath(indir, x), files)
    dirfiles = map(x-> joinpath(outdir, x), files)
    for (cf,df) in zip(curfiles, dirfiles)
       if isfile(cf) 
          if isfile(df)
             rm(df)
          end 
          cp(cf, df)
          if !isfile(df)
            error("Copy failed for $cf to $df")
          end
          rm(cf)
       end
    end
end


for (indir, outdir) in zip(udecdirsin, udecdirs)
          if isdir(indir)
                rm(indir)
          end
        end



# make csv subdirs
for d in udirs
    cd(d)
    decdir = joinpath(d, "decimal")
    mkpath(decdir)
    # cd(decdir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(d, x), files)
    dirfiles = map(x-> joinpath(decdir, x), files)
    # map(x->cp(x,decdir ), files)
    for (cf,df) in zip(curfiles, dirfiles)
       cp(cf, df)
       rm(cf)
    end
end

for d in sdirs
    cd(d)
    decdir = joinpath(d, "decimal")
    mkpath(decdir)
    # cd(decdir)
    files = filter(isfile, readdir())
    curfiles = map(x-> joinpath(d, x), files)
    dirfiles = map(x-> joinpath(decdir, x), files)
    # map(x->cp(x,decdir ), files)
    for (cf,df) in zip(curfiles, dirfiles)
       cp(cf, df)
       rm(cf)
    end
end

uhexdirs = Tuple([joinpath(bitsdir, "unsigned", "hex") for bitsdir in bdirs])
shexdirs = Tuple([joinpath(bitsdir, "signed", "hex") for bitsdir in bdirs])

udecdirs = Tuple([joinpath(bitsdir, "unsigned", "decimal") for bitsdir in bdirs])
sdecdirs = Tuple([joinpath(bitsdir, "signed", "decimal") for bitsdir in bdirs])


hexdir = joinpath(basefiledir, "aifloats_hexfmt")
decdir = joinpath(basefiledir, "aifloats_decfmt")



#=

C:\JuliaCon\juliacon\aifloats\bits11\unsigned\hex
C:\JuliaCon\juliacon\aifloats\bits11\unsigned\decimal


C:\JuliaCon\juliacon\aifloats\bits11\signed\hex
C:\JuliaCon\juliacon\aifloats\bits11\signed\decimal
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
=#

