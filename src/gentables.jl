
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
    if !iszero(sigbits)
        ["code", prefix * string(sigbits) * suffix ]
    else
        ["code", [prefix * string(i) * suffix for i in 1:sigbitsmax]...]
    end
end

function gencolsyms(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    colnames = gencolnames(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    if !iszero(sigbits)
        colnames = [colnames[1], colnames[sigbits]]
    end
    Tuple(map(Symbol, colnames))
end

function gencoltypes(bits, sigbits=0; SignedFloat=false, FiniteFloat=false, UnsignedFloat=false, ExtendedFloat=false)
    c1 = bits <= 8 ? UInt8 : UInt16
    if SignedFloat
        if bits <= 12
            cf = Float64
            cfs = Tuple(fill(cf, bits - SignedFloat))
        elseif bits <= 24
            cfs = Tuple([fill(BigFloat, bits-12)..., fill(Float64, 11)...])
        else
            throw(ErrorException("bits = $bits is not handled"))
        end
    else
        if bits <= 11
            cf = Float64
            cfs = Tuple(fill(cf, bits - SignedFloat))
        elseif bits <= 24
            cfs = Tuple([fill(BigFloat, bits-11)..., fill(Float64, 11)...])
        else
            throw(ErrorException("bits = $bits is not handled"))
        end
    end
    if !iszero(sigbits)
        println(cfs)
        cfs = (cfs[sigbits],)
    end
    (c1, cfs...)
end

code_formatter(bits) = bits <= 8 ? ft_printf("0x%002x", [1]) : ft_printf("0x%00004x", [1])
code_formatter8() = ft_printf("0x%002x", [1])
code_formatter16() = ft_printf("0x%00004x", [1])

# float_formatter64(n) = ft_printf("%1.19e", collect(2:(n+1)))
float_formatter64(n) = ft_printf("%1.19g", collect(2:(n+1)))
hex_formatter(n) = ft_printf("%a", collect(2:(n+1)))

float_formatters8(n) = (code_formatter8(), float_formatter64(n))
float_formatters16(n) = (code_formatter16(), float_formatter64(n))

hex_formatters8(n) = (code_formatter8(), hex_formatter(n))
hex_formatters16(n) = (code_formatter16(), hex_formatter(n))

function genformats(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    if bits <= 8
       float_formatters8(sigbitsmax)
    else
       float_formatters16(sigbitsmax)
    end
end

function genhexformats(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    if bits <= 8
       hex_formatters8(sigbitsmax)
    else
       hex_formatters16(sigbitsmax)
    end
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

function gen_base10_csv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colvalues = gencolumns(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.encoding, colvalues.values...)
    fmts = genformats(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colsyms = gencolsyms(bits, sigbits;  SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    veccoltypes = map(x->Vector{x}, coltypes)
    veccoltypetuple =  Tuple{veccoltypes...}
    nt4vectable = NamedTuple{colsyms, veccoltypetuple}
    nt = nt4vectable(vals)
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

function gen_base16_csv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colvalues = gencolumns(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.encoding, colvalues.values...)
    fmts = genhexformats(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colsyms = gencolsyms(bits, sigbits;  SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    veccoltypes = map(x->Vector{x}, coltypes)
    veccoltypetuple =  Tuple{veccoltypes...}
    nt4vectable = NamedTuple{colsyms, veccoltypetuple}
    nt = nt4vectable(vals)
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

