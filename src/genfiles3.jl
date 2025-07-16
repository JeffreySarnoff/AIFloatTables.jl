sfdir = s"C:\JuliaCon\2025\AIFloats\signed\finite"
sedir = s"C:\JuliaCon\2025\AIFloats\signed\extended"
ufdir = s"C:\JuliaCon\2025\AIFloats\unsigned\finite"
uedir = s"C:\JuliaCon\2025\AIFloats\unsigned\extended"

bitdir = [string("bits", bits) for bits in 2:15]

sfdirs = [""]
sedirs = [""]
ufdirs = [""]
uedirs = [""]

append!(sfdirs,[joinpath(sfdir, bit) for bit in bitdir])
append!(sedirs,[joinpath(sedir, bit) for bit in bitdir])
append!(ufdirs,[joinpath(ufdir, bit) for bit in bitdir])
append!(uedirs,[joinpath(uedir, bit) for bit in bitdir])

SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true
    
for i in 2:12
    suffix = "sf"
    filedir = sfdirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, FiniteFloat)
end
    
for i in 2:12
    suffix = "se"
    filedir = sedirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, ExtendedFloat)
end

for i in 2:11
    suffix = "uf"
    filedir = ufdirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, UnsignedFloat, FiniteFloat)
end
    
for i in 2:11
    suffix = "ue"
    filedir = uedirs[i]
    filename = string("binary",i,suffix,".csv")
    gencsv(i; filedir, filename, SignedFloat, ExtendedFloat)
end
