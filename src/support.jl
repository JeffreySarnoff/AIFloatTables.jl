import Quadmath: Float128

HugeFloat()    = setprecision(BigFloat, 4097)  
BiggerFloat()  = setprecision(BigFloat, 512)
LargeFloat()   = setprecision(BigFloat, 256)
SmallerFloat() = setprecision(BigFloat, 196)

code_fmt(bits) = (bits <= 8) ? "%000#4x" : "%00000#6x"

code_map(bits) =
   if (bits <= 8) 
      seq->map(x->@sprintf("%000#4x", x), seq)
   else
       seq->map(x->@sprintf("%00000#6x", x), seq)
   end  

function gendeccolnames(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false,FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    prefix = "binary" * uppercase(string(bits; base=10)) * "p"
    suffix = (SignedFloat ? "s" : "u") * (FiniteFloat ? "f" : "e")
    ["code", [prefix * string(i) * suffix for i in 1:sigbitsmax]...]
end




K=5; 
sf_values = [AIFloat(K, p, :signed, :finite) for p in 1:K-1];
sf_floats = map(floats, sf_values);
# sf_float_strs = map(v->map(x->@sprintf("%a",x)), sf_floats);

sprintfa(x) = @sprintf("%a",x)

function strprintfa(v::Vector{Vector{T}}) where {T}
    res = []
    for avec in v
        t = map(x->sprintfa(x), avec)
        push!(res, t)
    end
    res
end

sf_float_strs = strprintfa(sf_floats)

code_s = codes(AIFloat(K,2,:unsigned,:finite));
code_strs = code_map(K)(code_s);

dir16 = sfdirs16[K]

colnms = gendeccolnames(K; SignedFloat, FiniteFloat)
colsyms = Tuple(map(Symbol, colnms));

colvalues = [code_strs, sf_float_strs...]

nt = NamedTuple{colsyms}(colvalues)

using Tables, PrettyTables, CSV
coltable = columntable(nt);

tf = TextFormat(
    up_right_corner     = ' ',
    up_left_corner      = ' ',
    bottom_left_corner  = ' ',
    bottom_right_corner = ' ',
    up_intersection     = ' ',
    left_intersection   = ' ',
    right_intersection  = ' ',
    middle_intersection = ' ',
    bottom_intersection = ' ',
    column              = ',',
    row                 = ' ',
    hlines              = [:header]
);

str = pretty_table(String, coltable; alignment=:l, tf=tf);
strs = map(string, split(str, '\n'));
prepstrs = vcat(strs[1],strs[4:end]);
cleanstrs = map(x->x[2:end-1], prepstrs);
csv  = join(cleanstrs, '\n');




using Tables, PrettyTables, CSV


tf = TextFormat(
    up_right_corner     = ' ',
    up_left_corner      = ' ',
    bottom_left_corner  = ' ',
    bottom_right_corner = ' ',
    up_intersection     = ' ',
    left_intersection   = ' ',
    right_intersection  = ' ',
    middle_intersection = ' ',
    bottom_intersection = ' ',
    column              = ',',
    row                 = ' ',
    hlines              = [:header]
);

# sfdirs16 = ["", "C:\\JuliaCon\fo\AIFloats\\base16\\signed\\finite\\bits2", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits3", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits4", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits5", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits6", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits7", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits8", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits9", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits10", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits11", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits12", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits13", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits14", "C:\\JuliaCon\\AIFloats\\base16\\signed\\finite\\bits15"]

basefile_dir = abspath(joinpath("C:/JuliaCon", "AIFloats"))
for K in 2:4
    println(K)
    for signedness in (:unsigned, :signed)
        for domain in (:finite, :extended)
            for is16 in (true, false)
                if is16
                    filedir = joinpath(basefile_dir, "base16")
                else
                    filedir = joinpath(basefile_dir, "base10")
                end
                println(filedir)
                if signedness == :signed
                    filedir = joinpath(filedir, "signed")
                else
                    filedir = joinpath(filedir, "unsigned")
                end
                if domain == :finite
                    filedir = joinpath(filedir, "finite")
                else
                    filedir = joinpath(filedir, "extended")
                end
                thisdir, csv = makecsv(K, signedness, domain; is16)
                if is16
                    filename = string("binary",K,".16.csv")
                else
                    filename = string("binary",K,".10.csv")
                end

                println("thisdir = $thisdir")

                fullpath = joinpath(thisdir, filedir)

                 #    filedir  = dir4file()
                 #    fullpath = joinpath(filedir, filname); println(fullpath)
                        open(thisdir, "w") do io
                        write(io, csv)
                    end
            end
        end
    end
end

function makecsv(K, signedness, domain; is16=false)

    SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true
    signedness == :signed && (UnsignedFloat = false;);
    signedness == :unsigned && (SignedFloat = false;);
    domain == :finite && (ExtendedFloat = false;);
    domain == :extended && (UnsignedFloat = false;);

    if UnsignedFloat
        if FiniteFloat
            thisdir = (is16) ? ufdirs16[K] : ufdirs10[K]
        else
            thisdir = (is16) ? uedirs16[K] : uedirs10[K]
        end
    else
        if FiniteFloat
            thisdir = (is16) ? sfdirs16[K] : sfdirs10[K]
        else
            thisdir = (is16) ? sedirs16[K] : sedirs10[K]
        end
    end

    vals = [AIFloat(K, p, signedness, domain) for p in 1:K-SignedFloat];
    float_vals = map(floats, vals);

    float_strs = strprintfa(float_vals)

    code_s = codes(AIFloat(K,2,:unsigned,:finite));
    code_strs = code_map(K)(code_s);

    if hexnames
        colnms = genhexcolnames(K; SignedFloat, FiniteFloat)
    else
        colnms = gendeccolnames(K; SignedFloat, FiniteFloat)
    end

    colsyms = Tuple(map(Symbol, colnms));
    colvalues = [code_strs, float_strs...];

    nt = NamedTuple{colsyms}(colvalues);

    coltable = columntable(nt);
    str = pretty_table(String, coltable; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'));
    prepstrs = vcat(strs[1],strs[4:end]);
    cleanstrs = map(x->x[2:end-1], prepstrs);
    csv  = join(cleanstrs, '\n');

    thisdir, csv
end


# sf_float_strs = map(v->map(x->@sprintf("%a",x)), float_vals);

sprintfa(x) = @sprintf("%a",x)

function strprintfa(v::Vector{Vector{T}}) where {T}
    res = []
    for avec in v
        t = map(x->sprintfa(x), avec)
        push!(res, t)
    end
    res
end







function commondenoms(xs)
    qs = map(rationalize, xs)
    qns = map(numerator, qs)
    qds = map(denominator, qs)
    dmax = round(Int,maximum(qds))
    qds2 = map(x->round(Int, dmax/x), qds)
    qns2 = qns .* qds2
    res = map(x -> Rational(x,dmax), qns2)c
    map(x->(x,dmax), qns2)
end

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

