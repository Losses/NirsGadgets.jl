function re_smp_deci(x::Neuro1DRealSignal; rate::Real)
    r, c = size(x.signal)

    result = nothing

    for i = 1:c
        res_c = resample(x.signal[:, i], rate)

        isnothing(result) && (result = zeros(length(res_c), c))

        result[:, i] = res_c
    end

    Neuro1DRealSignal(
        signal = result,
        sample_rate = x.sample_rate * rate
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
