lo,hi = 2,15
bitdir = [string("bits", bits) for bits in lo:hi]

sfdir = s"C:\JuliaCon\AIFloats\base10\signed\finite"
sedir = s"C:\JuliaCon\AIFloats\base10\signed\extended"
ufdir = s"C:\JuliaCon\AIFloats\base10\unsigned\finite"
uedir = s"C:\JuliaCon\AIFloats\base10\unsigned\extended"

sfdirs10= [""]
sedirs10= [""]
ufdirs10= [""]
uedirs10= [""]

append!(sfdirs10,[joinpath(sfdir, bit) for bit in bitdir])
append!(sedirs10,[joinpath(sedir, bit) for bit in bitdir])
append!(ufdirs10,[joinpath(ufdir, bit) for bit in bitdir])
append!(uedirs10,[joinpath(uedir, bit) for bit in bitdir])

[map(mkpath, d) for d in [sfdirs10, sedirs10, ufdirs10, uedirs10]]

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

