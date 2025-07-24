setprecision(BigFloat, 512)
SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true

function rmfile(filepath)
    if isfile(filepath)
        rm(filepath)
    end
end

function rmfile(filedir, filename)
    rmfile( joinpath(filedir,filename) )
end

function make_directories(basedir=s"C:/JuliaCon", localdir=s"P3109"; minbits=2, maxbits=16)
    topdir = joinpath(basedir, localdir)

    sfpath = s"signed\finite"
    sepath = s"signed\extended"
    ufpath = s"unsigned\finite"
    uepath = s"unsigned\extended"

    bitdir = [string("bits", bits) for bits in minbits:maxbits]

    base = "base10"
    radixdir = abspath(joinpath(topdir, base))
    sfdir = joinpath(radixdir, sfpath)
    sedir = joinpath(radixdir, sepath)
    ufdir = joinpath(radixdir, ufpath)
    uedir = joinpath(radixdir, uepath)

    # there are no 1-bit formats, reserve index position
    sfdirs10 = [""]
    sedirs10 = [""]
    ufdirs10 = [""]
    uedirs10 = [""]

    append!(sfdirs10, [joinpath(sfdir, bit) for bit in bitdir])
    append!(sedirs10, [joinpath(sedir, bit) for bit in bitdir])
    append!(ufdirs10, [joinpath(ufdir, bit) for bit in bitdir])
    append!(uedirs10, [joinpath(uedir, bit) for bit in bitdir])


    [map(mkpath, d) for d in [sfdirs10, sedirs10, ufdirs10, uedirs10]]
    decimaldirs = (; sfdirs = sfdirs10, sedirs = sedirs10, ufdirs = ufdirs10, uedirs = uedirs10)

    base = "base16"
    radixdir = abspath(joinpath(topdir, base))
    sfdir = joinpath(radixdir, sfpath)
    sedir = joinpath(radixdir, sepath)
    ufdir = joinpath(radixdir, ufpath)
    uedir = joinpath(radixdir, uepath)

    # there are no 1-bit formats, reserve index position
    sfdirs16 = [""]
    sedirs16 = [""]
    ufdirs16 = [""]
    uedirs16 = [""]

    append!(sfdirs16, [joinpath(sfdir, bit) for bit in bitdir])
    append!(sedirs16, [joinpath(sedir, bit) for bit in bitdir])
    append!(ufdirs16, [joinpath(ufdir, bit) for bit in bitdir])
    append!(uedirs16, [joinpath(uedir, bit) for bit in bitdir])

    [map(mkpath, d) for d in [sfdirs16, sedirs16, ufdirs16, uedirs16]]
    hexadecimaldirs = (; sfdirs = sfdirs16, sedirs = sedirs16, ufdirs = ufdirs16, uedirs = uedirs16)

    (; decimaldirs, hexadecimaldirs)
end

