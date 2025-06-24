module AIFloatTables

using Printf, Tables, DataFrames, CSV, Latexify, PrettyTables
using AIFloats, BFloat16s

const U8   = Vector{UInt8}
const U16  = Vector{UInt16}

const V16 = Vector{Float16}
const V32 = Vector{Float32}
const V64 = Vector{Float64}

const B16 = Vector{BFloat16}

#=
julia> @sprintf("%#04x",0x25)
"0x25"

julia> @sprintf("%#04x",0x5)
"0x05"

rstrip0(x) = rstrip(@sprintf("%.7f",x),'0') * (isinteger(x) ? '0' : "")
=#

hex_formatter = (v, i, j) -> j==1 ? ifelse(isa(v, UInt8), @sprintf("%#04x", v), @sprintf("%#06x", v)) : v
# float_formatter = (v, i, j) ->  string(@sprintf("%#a",v)," (", @sprintf("%#g", v), ") ")
# formatters = (v, i, j) -> ifelse(j==1, hex_formmater(v), float_formatter(v))
formats=(v,i,j)->ifelse(j>1, round(v; sigdigits=16), hex_formatter(v,i,j))
# rstrip0(x) = rstrip(@sprintf("%.7f",x),'0') * (isinteger(x) ? '0' : "")

encoding = collect(0x00:0x0f);

colnames = ["uf41", "uf42", "uf43", "uf44"];
colsyms  = map(Symbol, colnames);

values = [
   Float32[0.0, 0.0078125, 0.015625, 0.03125, 0.0625, 0.125, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0, NaN],
   Float32[0.0, 0.0625, 0.125, 0.1875, 0.25, 0.375, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0, NaN],
   Float32[0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, NaN],
   Float32[0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, NaN]
];

nt4table = NamedTuple{Tuple(colsyms), NTuple{4,V32}};
nt = nt4table(values);
coltable = columntable(nt)

pretty_table(coltable; formatters = formats, alignment=:l);


function codes_floats(Bits, Signed, Extended)
   typed = type_codes_values(Bits, Signed, Extended)
   encodings = typed[1].codes
   fpvalues = map(floats, typed)
   return encodings, fpvalues
end

function type_codes_values(Bits, Signed, Extended)
    SigBits = Signed ? Bits - 1 : Bits
    [AIFloat(Bits,Sig; signed=Signed, extended=Extended) for Sig in 1:SigBits]
end

pretty_string = pretty_table(String, coltable; header = colnames);
pretty_html   = pretty_table(HTML, coltable; header = colnames);

colnames2 = ["code", "uf41", "uf42", "uf43", "uf44"];
colsyms2  = map(Symbol, colnames2);

values2 = [
  [0x00,  0x01,  0x02,  0x03,  0x04,  0x05,  0x06,  0x07,  0x08,  0x09,  0x0a,  0x0b,  0x0c,  0x0d,  0x0e,  0x0f],
  [0.0, 0.0078125, 0.015625, 0.03125, 0.0625, 0.125, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0, NaN],
  [0.0, 0.0625, 0.125, 0.1875, 0.25, 0.375, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0, NaN],
  [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, NaN],
  [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, NaN]
];

nt4table2 = NamedTuple{Tuple(colsyms2), Tuple{U8,V32,V32,V32,V32}};
nt2 = nt4table2(values2);
coltable2 = columntable(nt2);

pretty_table2  = pretty_table(coltable2; formatters=formats, alignment=:l)
pretty_string2 = pretty_table(String, coltable2; formatters=formats, alignment=:l);
pretty_html2   = pretty_table(HTML, coltable2; formatters=formats, alignment=:l);


valuematrix = reshape(collect(Iterators.flatten(values)),(4^2,4)); 
valuetable = Tables.table(valuematrix);

hexform=(col,val)->@sprintf("%#04x",val)
floatform = (col, val) -> @sprintf("%g",val)
form(col, val) = ifelse(col == 1, hexform(col, val), floatform(col, val))
rowitr = CSV.RowWriter(coltable2;transform=form);for r in rowitr;print(r); end

ufA1 = AIFloat(10,1;signed=true,extended=false);
ufA9 = AIFloat(10,9;signed=true,extended=false);
ufAA = AIFloat(10,10;signed=true,extended=false);

sfA1 = AIFloat(10,1;signed=true,extended=false);
sfA9 = AIFloat(10,9;signed=true,extended=false);

colnames = [:code, :ufA1, :sfA1, :ufA9, :sfA9];
values = [ 
  codes(ufA1), floats(ufA1), floats(sfA1), floats(ufA9), floats(sfA9)
];

nt4table = NamedTuple{Tuple(colnames), Tuple{U16,V64,V64,V64,V64}};
nt = nt4table(values);
coltable = columntable(nt);

prettytable = pretty_table(coltable; formatters=formats, alignment=:l)

end  # AIFloatTables
