function cc_mod(x::Neuro1DAnalyticSignal)::Neuro1DRealSignal
    Neuro1DRealSignal(
        signal = abs.(x.signal),
        sample_rate = x.sample_rate
    )
end

function cc_arg(x::Neuro1DAnalyticSignal)::Neuro1DRealSignal
    Neuro1DRealSignal(
        signal = angle.(x.signal),
        sample_rate = x.sample_rate
    )
end

function cc_rel(x::Neuro1DAnalyticSignal)::Neuro1DRealSignal
    Neuro1DRealSignal(
        signal = real.(x.signal),
        sample_rate = x.sample_rate
    )
end
