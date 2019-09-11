function rm_trd_loess(
    x::Neuro1DRealSignal;
    span::Float64 = 0.75)::Neuro1DRealSignal

    x_ = copy(x)
    r, c = size(x_)
    idx = convert(Vector{Float64}, [1:1:r; ])

    for i = 1:c
        c_loess = loess(idx, x_[:, i], span = span)
        c_trend = Loess.predict(c_loess, idx)

        x_[:, i] = x_[:, i] .- c_trend
    end

    Neuro1DRealSignal(
        signal = x_,
        sample_rate = x.sample_rate
    )
end

function rm_trd_linear(x::Neuro1DRealSignal)::Neuro1DRealSignal
    r, c = size(x.signal)
    idx = convert(Vector{Float64}, [1:1:r; ])

    βs = cov(x.signal, idx) ./ var(idx)

    Neuro1DRealSignal(
        signal = x.signal - idx * βs',
        sample_rate = x.sample_rate
    )
end

function rm_trd(
    x::Neuro1DRealSignal,
    method = :loess;
    kwargs...)::Neuro1DRealSignal

    if method == :loess
        rm_trd_loess(x; kwargs...)
    elseif method == :linear
        rm_trd_linear(x)
    else
        throw(ArgumentError("invalid method"))
    end
end
