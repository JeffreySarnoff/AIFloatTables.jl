
using AIFloats
using AIFloats: typeforfloat, typeforcode
using Tables, CSV, PrettyTables

#=
float64 works for 
:signed 
    bits=2:12
    bits=13, sigbits=3:12
    bits=14, sigbits=4:13
    bits=15, sigbits=5:14
:unsigned 
    bits=2:11
    bits=12, sigbits=2:12
    bits=13, sigbits=3:13
    bits=14, sigbits=4:14
    bits=15, sigbits=5:15

=#

function gencolumns(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    if !iszero(sigbits)
        sigbitsmin = sigbitsmax = sigbits
    else
        sigbitsmin = 1
        sigbitsmax = bits - SignedFloat
    end    

    C = typeforcode(bits)
    F = typeforfloat(bits)

    signedness = SignedFloat ? :signed : :unsigned
    finiteness = FiniteFloat ? :finite : :extended
    
    formats = [AIFloat(bits,i, signedness, finiteness) for i in sigbitsmin:sigbitsmax]

    codemap = map(codes, formats[1])
    valuemap = map(floats, formats)
    encoding = map(C, codemap)
    values = map(x->F.(x), valuemap)
    (; encoding, values)
end

function gencolnames(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    prefix = "binary" * string(bits) * "p"
    suffix = (SignedFloat ? "s" : "u") * (FiniteFloat ? "f" : "e")
    ["code", [prefix * string(i) * suffix for i in 1:sigbitsmax]...]
end

function genhexcolnames(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    prefix = "binary" * uppercase(string(bits; base=16)) * "p"
    suffix = (SignedFloat ? "s" : "u") * (FiniteFloat ? "f" : "e")
    ["code", [prefix * string(i) * suffix for i in 1:sigbitsmax]...]
end

function gendeccolnames(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    prefix = "binary" * uppercase(string(bits; base=10)) * "p"
    suffix = (SignedFloat ? "s" : "u") * (FiniteFloat ? "f" : "e")
    ["code", [prefix * string(i) * suffix for i in 1:sigbitsmax]...]
end

function gencolsyms(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    colnames = gencolnames(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    Tuple(map(Symbol, colnames))
end

function gencoltypes(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    c1 = bits <= 8 ? UInt8 : UInt16
    if SignedFloat
        if bits <= 12
            cf = Float64
            cfs = Tuple(fill(cf, bits - SignedFloat))
        elseif bits == 13
            cfs = Tuple([BigFloat, fill(Float64, 11)...])
        elseif bits == 14
            cfs = Tuple([fill(BigFloat, 2)..., fill(Float64, 10)...])
        elseif bits == 15
            cfs = Tuple([fill(BigFloat, 3)..., fill(Float64, 9)...])
        end
    else
        if bits <= 11
            cf = Float64
            cfs = Tuple(fill(cf, bits - SignedFloat))
        elseif bits == 12
            cfs = Tuple([BigFloat, fill(Float64, 11)...])
        elseif bits == 13
            cfs = Tuple([fill(BigFloat, 2)..., fill(Float64, 11)...])
        elseif bits == 15
            cfs = Tuple([fill(BigFloat, 3)..., fill(Float64, 12)...])
        end
    end
    cfs
end

#=
float64 works for 
:signed 
    bits=2:12
    bits=13, sigbits=3:12
    bits=14, sigbits=4:13
    bits=15, sigbits=5:14
:unsigned 
    bits=2:11
    bits=12, sigbits=2:12
    bits=13, sigbits=3:13
    bits=14, sigbits=4:14
    bits=15, sigbits=5:15
=#

code_formatter(bits) = bits <= 8 ? ft_printf("0x%002x", [1]) : ft_printf("0x%00004x", [1])
float_format(col) = ft_round(15, col)
hex_format(col) = ft_printf("%a", col)
float_formatters(n) = (ft_printf("%#04x", [1]),ft_printf("%.17g", collect(2:(n+1))))
bigfloat_formatters(n) = (ft_printf("%#04x", [1]),ft_printf("%.27g", collect(2:(n+1))))
hex_formatters(n) = (ft_printf("%#04x", [1]),ft_printf("%a", collect(2:(n+1))))
floathex_formatters(n) = (i->float_format(i), hex_format(i+1))

function genformats(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    float_formatters(sigbitsmax)
end

function genbigformats(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    bigfloat_formatters(sigbitsmax)
end

function genhexformats(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    hex_formatters(sigbitsmax)
end

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
)

function gencsv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colsyms = gencolsyms(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colvalues = gencolumns(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.encoding, colvalues.values...)
    fmts = genformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)

    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

#=
float64 works for 
:signed 
    bits=2:12
    bits=13, sigbits=2:12, 13p1=[975:3073] (2099 values),
    bits=14, sigbits=3:13, 14p1=[3023, 5121] (2099 values), s14p2=[1951,6145] (4195 values)
    bits=15, sigbits=4:14, 15p1=[7119, 9317] (2099 values), s15p2=[6047,10241] (4195 values)
:unsigned 
    bits=2:11
    bits=12, sigbits=2:12, 12p1=[975:3073] (2099 values) 
    bits=13, sigbits=3:13
    bits=14, sigbits=4:14
    bits=15, sigbits=5:15
=#
function genbigcsv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    adjust = SignedFloat ? 1 : 0

    if SignedFloat
        if (bits <= 12 ||
            (bits == 13 && sigbits >= 3) ||
            (bits == 14 && sigbits >= 4) ||
            (bits == 15 && sigbits >= 5))
            return gencsv(bits, sigbits; filedir, filename, SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
        end
    end
    if UnsignedFloat
        if (bits <= 11 ||
            (bits == 12 && sigbits >= 2) ||
            (bits == 13 && sigbits >= 3) ||
            (bits == 14 && sigbits >= 4) ||
            (bits == 15 && sigbits >= 5))
            return gencsv(bits, sigbits; filedir, filename, SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
        end
    end

    sigbitsmax = bits - SignedFloat
    colsyms = gencolsyms(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colvalues = gencolumns(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.encoding, colvalues.values...)
    fmts = genbigformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)

    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

function gen_base16_csv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colvalues = gencolumns(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.encoding, colvalues.values...)
    fmts = genhexformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colsyms = gencolsyms(bits;  SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

#=
about_exponents(T) = (bias = expBias(T), exponents = 1 + AIFloats.expMax(T) - AIFloats.expMin(T), 
            exponent_min = AIFloats.expMin(T), exponent_max = AIFloats.expMax(T))

about_prenormals(T) =
            (prenormal_mags = nPrenormalMagnitudes(T),
             subnormal_mags = nSubnormalMagnitudes(T), 
             subnormal_values = AIFloats.nSubnormalValues(T),
             subnormal_min = subnormalMagnitudeMin(T), subnormal_max = subnormalMagnitudeMax(T))

about_normals(T) =
            (normal_mags = nNormalMagnitudes(T), normal_values = AIFloats.nNormalValues(T),
             normal_min = normalMagnitudeMin(T), normal_max = normalMagnitudeMax(T))

about(T) = (
    exponents = about_exponents(T),
    prenormals = about_prenormals(T),
    normals = about_normals(T)
)
=#