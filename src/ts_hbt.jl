function ts_hbt(x::Neuro1DRealSignal)::Neuro1DAnalyticSignal
    r, c = size(x.signal)

    result::Array{ComplexF64} = zeros(Float64, r, c) .+ zeros(Float64, r, c)*im

    for i = 1:c
        result[:, i] = hilbert(x.signal[:, i])
    end

    Neuro1DAnalyticSignal(
        signal = result,
        sample_rate = x.sample_rate
    )
end
