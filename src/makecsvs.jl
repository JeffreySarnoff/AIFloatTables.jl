setprecision(BigFloat, 128)
SignedFloat = ExtendedFloat = FiniteFloat = UnsignedFloat = true

lo, hi = 13,14
#=
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
=#

# base16

sprintfa(x) = @sprintf("%a",x)

function rmfile(filedir, filename)
    filepath = joinpath(filedir,filename)
    if isfile(filepath)
        rm(filepath)
    end
end

lo,hi = 2,15

for i in lo:hi
    suffix = "sf"
    filedir = sfdirs16[i]
    filename = string("binary",i,suffix,".csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    code_seq = codes(AIFloat(i,2,:signed, :finite))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals =[floats(AIFloat(i,p,:signed, :finite)) for p=2:i-1]
    valstrs = [code_strs, [map(sprintfa, vals[p]) for p=1:i-2]...]
    
    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=2:i-1])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ bits <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i, p; SignedFloat, FiniteFloat))

    valcols = collect(colsms .=> valstrs)
    coltbl = NamedTuple(valcols)

    str = pretty_table(String, coltbl; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

for i in lo:hi
    suffix = "se"
    filedir = sedirs16[i]
    filename = string("binary",i,suffix,".csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    code_seq = codes(AIFloat(i,2,:signed, :extended))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals =[floats(AIFloat(i,p,:signed, :finite)) for p=2:i-1]
    valstrs = [code_strs, [map(sprintfa, vals[p]) for p=1:i-2]...]
    
    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=2:i-1])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ bits <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i, p; SignedFloat, FiniteFloat))

    valcols = collect(colsms .=> valstrs)
    coltbl = NamedTuple(valcols)

    str = pretty_table(String, coltbl; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

for i in lo:hi
    suffix = "uf"
    filedir = ufdirs16[i]
    filename = string("binary",i,suffix,".csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    code_seq = codes(AIFloat(i,2,:signed, :finite))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals =[floats(AIFloat(i,p,:signed, :finite)) for p=2:i-1]
    valstrs = [code_strs, [map(sprintfa, vals[p]) for p=1:i-2]...]
    
    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=2:i-1])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ bits <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i, p; SignedFloat, FiniteFloat))

    valcols = collect(colsms .=> valstrs)
    coltbl = NamedTuple(valcols)

    str = pretty_table(String, coltbl; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end

for i in lo:hi
    suffix = "ue"
    filedir = uedirs16[i]
    filename = string("binary",i,suffix,".csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    code_seq = codes(AIFloat(i,2,:signed, :extended))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals =[floats(AIFloat(i,p,:signed, :finite)) for p=2:i-1]
    valstrs = [code_strs, [map(sprintfa, vals[p]) for p=1:i-2]...]
    
    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=2:i-1])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ bits <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i, p; SignedFloat, FiniteFloat))

    valcols = collect(colsms .=> valstrs)
    coltbl = NamedTuple(valcols)

    str = pretty_table(String, coltbl; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename)
    open(fullpath, "w") do io
        write(io, csv)
    end
end









for i in lo:hi
    suffix = "uf"
    filedir = ufdirs16[i]
    filename = string("binary",i,suffix,".csv")
    rmfile(filedir, filename)
    gen_base16_csv(i; filedir, filename, UnsignedFloat, FiniteFloat)
end
    
for i in lo:hi
    suffix = "ue"
    filedir = uedirs16[i]
    filename = string("binary",i,suffix,".csv")
    rmfile(filedir, filename)
    gen_base16_csv(i; filedir, filename, SignedFloat, ExtendedFloat)
end


