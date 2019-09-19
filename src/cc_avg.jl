function cc_avg(x::Neuro1DRealSignal; channels::Union{Vector{Int64}, Nothing} = nothing)::Neuro1DRealSignal
    if (channels == nothing)
        return cc_avg(x, channels = [1:1:size(x.signal)[2];])
    end

    Neuro1DRealSignal(
        signal = Statistics.mean(x.signal[:, channels]; dims = 2),
        sample_rate = x.sample_rate
    )
end
