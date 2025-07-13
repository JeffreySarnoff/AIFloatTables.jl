cd("C:/JuliaCon/juliacon"); using Pkg; Pkg.activate();

using AIFloats; import AIFloats as A; 

using Printf, Quadmath, # Statistics, Plots, Distributions, LinearAlgebra, StatsBase, Random

# cd("c://JuliaCon/Presentation");

sf(n) = [SignedFinite(n,i) for i=1:(n-1)];
se(n) = [SignedExtended(n,i) for i=1:(n-1)];

fsf(n) = [map(floats, SignedFinite(n,i)) for i=1:n];
fse(n) = [map(floats, SignedExtended(n,i)) for i=1:n];

uf(n) = [UnsignedFinite(n,i) for i=1:n];
ue(n) = [UnsignedExtended(n,i) for i=1:n];

fuf(n) = [map(floats, UnsignedFinite(n,i)) for i=1:n];
fue(n) = [map(floats, UnsignedExtended(n,i)) for i=1:n];

bmax = 15;
sfs = [sf(i) for i=2:bmax];
ses = [se(i) for i=2:bmax];
ufs = [uf(i) for i=2:bmax];
ues = [ue(i) for i=2:bmax];

function vecmap(fn, xs, i)
    map(fn, xs[i])
end
#  vecmap(z->Float16.(floats(z)), sfs, 3)

sfsf = [vecmap(floats, sfs, i) for i = length(sfs)][1];
sesf = [vecmap(floats, ses, i) for i = length(ses)][1];
ufuf = [vecmap(floats, ufs, i) for i = length(ufs)][1];
ueuf = [vecmap(floats, ues, i) for i = length(ues)][1];


sff(; nbits=6, minbits=2) = map(float, sf(; nbits, minbits))
sef(; nbits=6, minbits=2) = map(float, se(; nbits, minbits))
uff(; nbits=6, minbits=2) = map(float, uf(; nbits, minbits))
uef(; nbits=6, minbits=2) = map(float, ue(; nbits, minbits))

sf_struct( nbits, minbits ) = [AIFloat(nbits, i, :signed, :finite) for i in minbits:(nbits-1)]
se_struct( nbits, minbits ) = [AIFloat(nbits, i, :signed, :finite) for i in minbits:(nbits-1)]
uf_struct( nbits, minbits ) = [AIFloat(nbits, i, :signed, :finite) for i in minbits:(nbits-1)]
ue_struct( nbits, minbits ) = [AIFloat(nbits, i, :signed, :finite) for i in minbits:(nbits-1)]


uf32 =  ([0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, NaN, -0.25, -0.5, -0.75, -1.0, -1.5, -2.0, -3.0],
         [0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, NaN, -0.25, -0.5, -0.75, -1.0, -1.25, -1.5, -1.75])

uf42 = AIFloat(4, 2, :signed, :finite)

uf(n) = [AIFloat(n, i, :unsigned, :finite   ) for i in 1:(n-0)]
ue(n) = [AIFloat(n, i, :unsigned, :extended ) for i in 1:(n-0)]
sf(n) = [AIFloat(n, i, :signed,   :finite   ) for i in 1:(n-1)]
se(n) = [AIFloat(n, i, :signed,   :extended ) for i in 1:(n-1)]

fuf(n) = map(floats, uf(n))
fue(n) = map(floats, ue(n))
fsf(n) = map(floats, sf(n))
fse(n) = map(floats, se(n))

function floati(::Type{T}) where {T}
   (kind = (signed = is_signed(T), extended = is_extended(T), nvalues = nvalues(T)), 
    bits = (nbits = nbits(T), nbits_sig = nbits_sig(T),      # Bitwidth, Precision
            nbits_frac = nbits_frac(T), nbits_exp = nbits_exp(T)), 
    mags = (nmags = nmagnitudes(T),nvalues_exp = nvalues_exp(T), 
            nmags_frac = nmagnitudes_frac(T)),
    parts = (nmags_prenormal = nmagnitudes_prenormal(T), 
              nmags_normal = nmagnitudes_normal(T), 
              nmags_subnormal = nmagnitudes_subnormal(T))
   )
end

function floatinfo(::Type{T}) where {T}
   info = floati(T)
   k = info.kind
   bits = info.bits
   mags = info.mags
   parts = info.parts

   println(k)
   println(bits)
   println(mags)
   println(parts)
end
