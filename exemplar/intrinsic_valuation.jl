
cd("C:/JuliaCon/juliacon"); using Pkg; Pkg.activate();

using AIFloats; import AIFloats as A; 

using Printf, Quadmath, Statistics, Plots, Distributions, LinearAlgebra, StatsBase, Random

cd("c://JuliaCon/Presentation");

sf(n) = [SignedFinite(n,i) for i=1:(n-1)];
se(n) = [SignedExtended(n,i) for i=1:(n-1)];

fsf(n) = [map(floats, SignedFinite(n,i)) for i=1:n];
fse(n) = [map(floats, SignedExtended(n,i)) for i=1:n];

uf(n) = [UnsignedFinite(n,i) for i=1:n];
ue(n) = [UnsignedExtended(n,i) for i=1:n];

fuf(n) = [map(floats, UnsignedFinite(n,i)) for i=1:n];
fue(n) = [map(floats, UnsignedExtended(n,i)) for i=1:n];

bmax = 12;
sfs = [sf(i) for i=2:bmax];
ses = [se(i) for i=2:bmax];
ufs = [uf(i) for i=2:bmax];
ues = [ue(i) for i=2:bmax];

function vecmap(fn, xs, i)
    map(fn, xs[i])
end
#  vecmap(z->Float16.(floats(z)), sfs, 3)

sfsf = [vecmap(floats, sfs, i) for i = length(sfs)][1];
sese = [vecmap(floats, ses, i) for i = length(ses)][1];
ufuf = [vecmap(floats, ufs, i) for i = length(ufs)][1];
ueue = [vecmap(floats, ues, i) for i = length(ues)][1];

map_frexp(vecvec, i) =  map(frexp, vecvec[i])
map_frexps(vecvec)   = [map_frexp(vecvec, i) for i = 1:length(vecvec)]

sfsf_fx  = map_frexps(sfsf)
ssese_fx = map_frexps(sese)
ufuf_fx  = map_frexps(ufuf)
ueue_fx  = map_frexps(ueue)


#=

julia> map(Float32, ufuf_fx[6][end-3])
(0.9375f0, 64.0f0)

julia> map(Float32, sfsf_fx[6][end-3])
(-0.9375f0, 32.0f0)


julia> map(Float32, ufuf_fx[3][end-3])
(0.5f0, 512.0f0)

julia> map(Float32, sfsf_fx[3][end-3])
(-0.5f0, 256.0f0)

=#

nbits_max = 12

uf(n) = [typeof(AIFloat(n, i, :unsigned, :finite))   for i=1:n];
ue(n) = [typeof(AIFloat(n, i, :unsigned, :extended)) for i=1:n];
sf(n) = [typeof(AIFloat(n, i, :signed, :finite))     for i=1:n-1];
se(n) = [typeof(AIFloat(n, i, :signed, :extended))   for i=1:n-1];

ufv(n) = [uf(i) for i in 1:n];
uev(n) = [ue(i) for i in 1:n];
sfv(n) = [sf(i) for i in 1:n-1];
sev(n) = [se(i) for i in 1:n-1];

ufvv = [ufv(i) for i in 1:nbits_max];
uevv = [uev(i) for i in 1:nbits_max];
sfvv = [sfv(i) for i in 1:nbits_max];
sevv = [sev(i) for i in 1:nbits_max];


ufvT = map(z->map(w->map(AIFloat, w), z), ufvv);
uevT = map(z->map(w->map(AIFloat, w), z), uevv);
sfvT = map(z->map(w->map(AIFloat, w), z), sfvv);
sevT = map(z->map(w->map(AIFloat, w), z), sevv);

# vecvecs floats with NaN
ufvn = map(z->map(w->map(floats, w), z), ufvT);
uevn = map(z->map(w->map(floats, w), z), uevT);
sfvn = map(z->map(w->map(floats, w), z), sfvT);
sevn = map(z->map(w->map(floats, w), z), sevT);

# nn is nonan
ufvnn(i) = map(vecs -> map(x->filter(!isnan,x), vecs), ufvn[i])
ufvf = [ufvnn(i) for i in nbits_max];


ufvf = map(z->filter(w->map(!isnan, w), z), ufvn);


ufvf = map(z->map(floats, z), ufvv)
ufvf = map(z->map(!isnan, z), ufve)


aiuft(i) = [ map(AIFloat, ufv(i)) ];
uft = [aiuft(i) for i in 1:7]
uft  for i in 1:length(ufv)];
uet = [ map(AIFloat, uev[i]) for i in 1:length(uev)];
sft = [ map(AIFloat, sfv[i]) for i in 1:length(sfv)];
set = [ map(AIFloat, sev[i]) for i in 1:length(sev)];

# 8 vector of vectors of floats
uff = [map(floats, uft[i]) for i in 1:length(uft)];
uef = [map(floats, uet[i]) for i in 1:length(uet)];
sff = [map(floats, sft[i]) for i in 1:length(sft)];
sef = [map(floats, set[i]) for i in 1:length(set)];


