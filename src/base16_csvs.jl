sprintfa(x) = @sprintf("%a",x)
lo=14;hi=15;
for i in lo:hi
    suffix = "sf"
    filedir = sfdirs16[i]
    filename = string("binary",i,suffix,".hex.csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    println(filepath)
    code_seq = codes(AIFloat(i, 2, :signed, :finite))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals=[[zero(BigFloat)]]
    append!(vals, [floats(AIFloat(i,p, :signed, :finite)) for p=1:i])
    valstrs = vcat([code_strs], [map(sprintfa, vals[p]) for p=1:i])

    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=1:i])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ i <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i; SignedFloat, FiniteFloat))

    valcols = collect(colsms .=> valstrs)
    coltbl = NamedTuple(valcols)

    str = pretty_table(String, coltbl; alignment=:l, tf=tf);
    strs = map(string, split(str, '\n'))
    prepstrs = vcat(strs[1],strs[4:end])
    cleanstrs = map(x->x[2:end-1], prepstrs)
    csv  = join(cleanstrs, '\n')

    fullpath = joinpath(filedir, filename); println(fullpath)
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
    
    vals=[[zero(BigFloat)]]
    append!(vals, [floats(AIFloat(i,p,:signed, :extended)) for p=1:i])
    valstrs = vcat([code_strs], [map(sprintfa, vals[p]) for p=1:i])

    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=1:i])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ i <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i; SignedFloat, ExtendedFloat))

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
    filename = string("binary",i,suffix,".hex.csv")
    filepath = abspath(joinpath(filedir,filename))
    isfile(filepath) && rm(filepath)
    code_seq = codes(AIFloat(i,2,:unsigned, :finite))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    vals=[[zero(BigFloat)]]
    append!(vals, [floats(AIFloat(i,p,:unsigned, :finite)) for p=1:i])
    valstrs = vcat([code_strs], [map(sprintfa, vals[p]) for p=1:i])

    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=1:i])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ i <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i; SignedFloat, FiniteFloat))

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
    code_seq = codes(AIFloat(i,2,:unsigned, :extended))
    if i <= 8
        code_strs = map(x->@sprintf("%000#4x",x), code_seq)
    else
        code_strs = map(x->@sprintf("%00000#6x",x), code_seq)
    end
    
    vals=[[zero(BigFloat)]]
    append!(vals, [floats(AIFloat(i,p,:unsigned, :extended)) for p=1:i])
    valstrs = vcat([code_strs], [map(sprintfa, vals[p]) for p=1:i])

    colnms = ["codes"]
    append!(colnms, [string("binary",i,"p",p,suffix) for p=1:i])
    colsms = Tuple(map(Symbol, colnms))

    coltyps = [ i <= 9 ? UInt8 : UInt16 ]
    append!(coltyps,  gencoltypes(i; SignedFloat, ExtendedFloat))

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
