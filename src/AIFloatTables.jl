module AIFloatTables

using AIFloats, CSV, Tables, PrettyTables, Printf

include("makedirs.jl")
include("gentables.jl")
include("genfiles.jl")

basedir  = s"C:/JuliaCon"
localdir = s"P3109"
minbits, maxbits = 2, 16
dirs = make_directories(basedir, localdir; minbits, maxbits);

generate_files(dirs; minbits, maxbits)


end # module AIFloatTables