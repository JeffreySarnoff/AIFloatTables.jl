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

basefile_dir = abspath(joinpath("C:/JuliaCon", "AIFloats"))

function fullpath(is16, K, args...; P=0, ext=is16 ? ".csv" : ".csv")
    dirpath = fulldir(is16, K, args)
    sfx = suffix(args)
    if !iszero(P)
        fname = string("binary", K, "p", P, sfx, ext)
    else     
        fname = string("binary", K, sfx, ext)
    end
    !isdir(dirpath) && mkpath(dirpath)
    abspath(joinpath(dirpath, fname))
end

function suffix(args...)
    if :signed in args
        sfx = "s"
    else
        sfx = "u"
    end
    if :finite in args
        sfx = string(sfx, "f")
    else
        sfx = string(sfx, "e")
    end
    sfx
end

function fulldir(is16, K, args...; UnsignedFloat=false, SignedFloat=false, ExtendedFloat=false, FiniteFloat=false)
    (:unsigned in args) && (UnsignedFloat=true;);
    (:signed in args) && (SignedFloat=true;);
    (:finite in args) && (FiniteFloat=true;);
    (:extended in args) && (ExtendedFloat=true;);
    # (; UnsignedFloat, SignedFloat, ExtendedFloat, FiniteFloat)
    if is16
        fullpath = joinpath(basefile_dir, "base16")
    else
        fullpath = joinpath(basefile_dir, "base10")
    end
    if SignedFloat
        fullpath = joinpath(fullpath, "signed")
    else
        fullpath = joinpath(fullpath, "unsigned")
    end
    if FiniteFloat
        fullpath = joinpath(fullpath, "finite")
    else
        fullpath = joinpath(fullpath, "extended")
    end
    fullpath = joinpath(fullpath, string("bits",K))
    fullpath
end

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
