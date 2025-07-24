using AIFloats, CSV, Tables, PrettyTables, Printf

include("makedirs.jl")
include("gentables.jl")
include("genfiles.jl")

basedir  = s"C:/JuliaCon"
localdir = s"P3109"
minbits, maxbits = 2, 16
dirs10, dirs16 = make_directories(basedir, localdir; minbits, maxbits);

sfdirs10, sedirs10, ufdirs10, uedirs10 = dirs10;
sfdirs16, sedirs16, ufdirs16, uedirs16 = dirs16;

generate_files(; minbits, maxbits)


