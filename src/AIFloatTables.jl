module AIFloatTables

# using Pkg
# cd(s"C:\\JuliaCon\\AIFloats\\"); using Pkg; Pkg.activate(pwd());

# export gencsv, genbigcsv, genhexcsv, about

using AIFloats
import AIFloats: typeforcode, typeforfloat
using Quadmath, ArbNumerics, Printf, Tables, CSV, PrettyTables, Latexify
using Printf

import Base: promote_rule, promote_type, convert

function convert(::Type{BigFloat}, x::ArbFloat{P}) where {P}
    str = string(x; base=2, sigdigits=P)
    BigFloat(str)
end

function convert(::Type{BigFloat}, x::ArbReal{P}) where {P}
    af = ArbFloat{P}(x)
    str = string(af; base=2, sigdigits=P)
    BigFloat(str)
end

const U8   = Vector{UInt8};
const U16  = Vector{UInt16};

const V16 = Vector{Float16};
const V32 = Vector{Float32};
const V64 = Vector{Float64};
const V128 = Vector{Float128};
const VBF = Vector{BigFloat};

basefile_dir = abspath(joinpath("C:/JuliaCon", "AIFloats"))

include("c:\\github\\AIFloatTables.jl\\src\\make.jl")

include("c:\\github\\AIFloatTables.jl\\src\\gentables.jl")
include("c:\\github\\AIFloatTables.jl\\src\\makecsvs.jl")


setprecision(BigFloat, 196)

sf14dir = sfdirs16[14]
sf14colsyms = Tuple(map(Symbol, genhexcolnames(14; SignedFloat, FiniteFloat)));
code14s = codes(AIFloat(14,2,:unsigned,:finite));
code14strs = map(x->@sprintf("%#0000x",x), string, code14s);

sf14s = [floats(AIFloat(14,p,:signed,:finite)) for p=1:14-1];
sf14strs = [map(v->map(x->@sprintf("%a", x), v), sf14s)][1];

sf14cols = [code14strs, sf14strs...]
nt = NamedTuple{sf14colsyms}( sf14cols )

coltbl = columntable(nt)
pretty_table(coltbl)

uf14dir = ufdirs16[14]

uf14s = [floats(AIFloat(14,p,:unsigned,:finite)) for p=1:14];
uf14strs = [map(v->map(x->@sprintf("%a",x), v), uf14s)][1];


end # module AIFloatTables