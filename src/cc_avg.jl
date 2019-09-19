function cc_avg(x::Neuro1DRealSignal)::Neuro1DRealSignal
    cc_avg(x, channels = [1:1:size(x)[2];])
end

function cc_avg(x::Neuro1DRealSignal; channels::Vector{Int64})::Neuro1DRealSignal
    Neuro1DRealSignal(
        signal = Statistics.mean(x.signal[:, channels]; dims = 2),
        sample_rate = x.sample_rate
    )
end
