function rm_trd_loess(
    x::Matrix{T} where T <: Real;
    span::Float64 = 0.75)

    x_ = convert(Matrix{Float64}, x)
    r, c = size(x_)
    idx = convert(Vector{Float64}, [1:1:r; ])

    for i = 1:c
        c_loess = loess(idx, x_[:, i], span = span)
        c_trend = Loess.predict(c_loess, idx)

        x_[:, i] = x_[:, i] .- c_trend
    end

    x_
end

function rm_trd_linear(x::Matrix{T} where T <: Real)
    r, c = size(x)
    idx = convert(Vector{Float64}, [1:1:r; ])

    βs = cov(x, idx) ./ var(idx)

    x - idx * βs'
end

function rm_spk(
    x::Matrix{T} where T <: Real,
    method = :loess;
    kwargs...)
    check(x)

    if method == :loess
        rm_trd_loess(x, kwargs...)
    elseif method == :linear
        rm_trd_linear(x)
    else
        throw(ArgumentError("invalid method"))
    end
end
