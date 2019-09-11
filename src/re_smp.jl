function re_smp_deci(x::Neuro1DRealSignal; rate::Real)
    r, c = size(x.signal)

    resampled_data::Vector{Vector{Float64}} = []

    for i = 1:c
        append!(resampled_data, [resample(x.signal[:, i], rate)])
    end

    new_r = minimum(length.(resampled_data))
    result = zeros(new_r, c)

    for i = 1:c
        result[:, c] = resampled_data[i][1:new_r]
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
