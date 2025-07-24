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

    base = "decimal"
    radixdir = abspath(joinpath(topdir, base))
    sfdir10 = joinpath(radixdir, sfpath)
    sedir10 = joinpath(radixdir, sepath)
    ufdir10 = joinpath(radixdir, ufpath)
    uedir10 = joinpath(radixdir, uepath)

    [mkpath(d) for d in [sfdir10, sedir10, ufdir10, uedir10]]
    decimaldirs = (; sfdir = sfdir10, sedir = sedir10, ufdir = ufdir10, uedir = uedir10)

    base = "hexadecimal"
    radixdir = abspath(joinpath(topdir, base))
    sfdir16 = joinpath(radixdir, sfpath)
    sedir16 = joinpath(radixdir, sepath)
    ufdir16 = joinpath(radixdir, ufpath)
    uedir16 = joinpath(radixdir, uepath)

    [mkpath(d) for d in [sfdir16, sedir16, ufdir16, uedir16]]
    hexadecimaldirs = (; sfdir = sfdir16, sedir = sedir16, ufdir = ufdir16, uedir = uedir16)

    (; decimaldirs, hexadecimaldirs)
end

