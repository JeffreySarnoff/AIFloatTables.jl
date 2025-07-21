bitdir = [string("bits", bits) for bits in lo:hi]

sfdir = s"C:\JuliaCon\AIFloats\signed\finite"
sedir = s"C:\JuliaCon\AIFloats\signed\extended"
ufdir = s"C:\JuliaCon\AIFloats\unsigned\finite"
uedir = s"C:\JuliaCon\AIFloats\unsigned\extended"

sfdirs = [""]
sedirs = [""]
ufdirs = [""]
uedirs = [""]

append!(sfdirs,[joinpath(sfdir, bit) for bit in bitdir])
append!(sedirs,[joinpath(sedir, bit) for bit in bitdir])
append!(ufdirs,[joinpath(ufdir, bit) for bit in bitdir])
append!(uedirs,[joinpath(uedir, bit) for bit in bitdir])

[map(mkpath, d) for d in [sfdirs, sedirs, ufdirs, uedirs]]

sfdir16 = s"C:\JuliaCon\AIFloats\base16\signed\finite"
sedir16 = s"C:\JuliaCon\AIFloats\base16\signed\extended"
ufdir16 = s"C:\JuliaCon\AIFloats\base16\unsigned\finite"
uedir16 = s"C:\JuliaCon\AIFloats\base16\unsigned\extended"

sfdirs16 = [""]
sedirs16 = [""]
ufdirs16 = [""]
uedirs16 = [""]

append!(sfdirs16,[joinpath(sfdir16, bit) for bit in bitdir])
append!(sedirs16,[joinpath(sedir16, bit) for bit in bitdir])
append!(ufdirs16,[joinpath(ufdir16, bit) for bit in bitdir])
append!(uedirs16,[joinpath(uedir16, bit) for bit in bitdir])

[map(mkpath, d) for d in [sfdirs16, sedirs16, ufdirs16, uedirs16]]

SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true

lo, hi = 2,4

for i in lo:hi
    suffix = "sf"
    filedir = sfdirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, FiniteFloat)
end
    
for i in lo:hi
    suffix = "se"
    filedir = sedirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, ExtendedFloat)
endv

for i in lo:hi
    suffix = "uf"
    filedir = ufdirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, UnsignedFloat, FiniteFloat)
end
    
for i in lo:hi
    suffix = "ue"
    filedir = uedirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, ExtendedFloat)
end

# base16
    
for i in lo:hi
    suffix = "sf"
    filedir = sfdirs16[i]
    filename = string("binary",i,suffix,".csv")
    gen_base16_csv(i; filedir, filename, SignedFloat, FiniteFloat)
end
    
for i in lo:hi
    suffix = "se"
    filedir = sedirs16[i]
    filename = string("binary",i,suffix,".csv")
    gen_base16_csv(i; filedir, filename, SignedFloat, ExtendedFloat)
end

for i in lo:hi
    suffix = "uf"
    filedir = ufdirs16[i]
    filename = string("binary",i,suffix,".csv")
    gen_base16_csv(i; filedir, filename, UnsignedFloat, FiniteFloat)
end
    
for i in lo:hi
    suffix = "ue"
    filedir = uedirs16[i]
    filename = string("binary",i,suffix,".csv")
    gen_base16_csv(i; filedir, filename, SignedFloat, ExtendedFloat)
end

