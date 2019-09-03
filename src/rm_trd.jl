function rm_trd_loess(
    x::Matrix{T} where T <: Real;
    span = 0.75)

    x_ = copy(x)
    r, c = size(x_)
    idx = convert(Vector{Float64}, [1:1:r; ])

    for i = 1:c
        c_loess = loess(idx, x_[:, i], span = span)
        c_trend = predict(c_loess, idx)

        x_[:, i] = x_[:, i] .- c_trend
    end

    x_
end

function rm_spk(
    x::Matrix{T} where T <: Real,
    method = :loess;
    kwargs...)
    check(x)
    
    if method == :loess
        rm_glb_pca(x, kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end