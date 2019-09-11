function re_smp_deci(x::Neuro1DRealSignal; rate::Real)
    r, c = size(x.signal)

    result = zeros(ceil(Int64, r*rate), c)

    for i = 1:c
        result[:, i] = resample(x.signal[:, i], rate)
    end

    Neuro1DRealSignal(
        signal = result,
        sample_rate = x.sample_rate / rate
    )
end

function re_smp(
    x::Neuro1DRealSignal,
    method = :decimate;
    kwargs...)

    if method == :decimate
        re_smp_deci(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
