module AIFloatTables

using Printf, Tables, DataFrames, CSV, Latexify, PrettyTables
using AIFloats

const V8   = Vector{UInt8}
const V16  = Vector{UInt16}

const V32 = Vector{Float32}
const V64 = Vector{Float64}

encoding = collect(0x00:0x0f);

colnames = ["uf41", "uf42", "uf43", "uf44"];
colsyms  = map(Symbol, colnames);

values = [
   [0.0, 0.0078125, 0.015625, 0.03125, 0.0625, 0.125, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0, NaN],
   [0.0, 0.0625, 0.125, 0.1875, 0.25, 0.375, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0, NaN],
   [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, NaN],
   [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.125, 1.25, 1.375, 1.5, 1.625, 1.75, NaN]
];

nt4table = NamedTuple{Tuple(colsyms), NTuple{4,V64}};
nt = nt4table(values);
coltable = columntable(nt)

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

nt4table2 = NamedTuple{Tuple(colsyms2), Tuple{V8,V64,V64,V64,V64}};
nt2 = nt4table2(values2);
coltable2 = columntable(nt2);

pretty_table2  = pretty_table(coltable2; alignment=:l)
pretty_string2 = pretty_table(String, coltable2);
pretty_html2   = pretty_table(HTML, coltable2);

#=
julia> @sprintf("%#04x",0x25)
"0x25"

julia> @sprintf("%#04x",0x5)
"0x05"

rstrip0(x) = (!isinteger(x) ? rstrip(@sprintf("%.7f",x),'0') : rstrip(@sprintf("%.7f",x), '0') * '0')
=#

valuematrix = reshape(collect(Iterators.flatten(values)),(4^2,4)); 
valuetable = Tables.table(valuematrix);

end  # AIFloatTables
