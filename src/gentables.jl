using AIFloats: typeforfloat, typeforcode

function gencolumns(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    formats = [AIFloat(bits,i;SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat) for i in 1:sigbitsmax]
    code = codes(formats[1])
    values = map(floats, formats)
    (; code, values)
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

function gencolsyms(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    colnames = gencolnames(bits, sigbits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    Tuple(map(Symbol, colnames))
end

function gencoltypes(bits, sigbits=0; SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    c1 = bits <= 8 ? U8 : U16
    sz = sizeof(typeforfloat(bits))
    cf = sz == 4 ? V32 : (sz == 8 ? V64 : V128)
    Tuple{[c1, fill(cf, bits - SignedFloat)...]...}
end

code_formatter(bits) = bits <= 8 ? ft_printf("%#04x", [1]) : ft_printf("%#06x", [1])
float_format(col) = ft_round(15, col)
hex_format(col) = ft_printf("%a", col)
float_formatters(n) = (ft_printf("%#04x", [1]),ft_printf("%.17g", collect(2:(n+1))))
bigfloat_formatters(n) = (ft_printf("%#04x", [1]),ft_printf("%.36g", collect(2:(n+1))))
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
    vals = (colvalues.code, colvalues.values...)
    fmts = genformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)

    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[5:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

function genbigcsv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colsyms = gencolsyms(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colvalues = gencolumns(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.code, colvalues.values...)
    fmts = genbigformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)

    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[5:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

function genhexcsv(bits, sigbits=0; filedir, filename, SignedFloat=false, UnsignedFloat=false, FiniteFloat=false, ExtendedFloat=false)
    sigbitsmax = bits - SignedFloat
    colsyms = gencolsyms(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    coltypes = gencoltypes(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    colvalues = gencolumns(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)
    vals = (colvalues.code, colvalues.values...)
    fmts = genhexformats(bits; SignedFloat, UnsignedFloat, FiniteFloat, ExtendedFloat)

    nt4table = NamedTuple{colsyms, coltypes}
    nt = nt4table(vals)
    coltable = columntable(nt)

    str = pretty_table(String, coltable; formatters = fmts, alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[5:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

