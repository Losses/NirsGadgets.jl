function cc_add(x::Neuro1DRealSignal, y::Neuro1DRealSignal)::Neuro1DRealSignal
    if x.sample_rate != y.sample_rate
        throw(ArgumentError("the sample rate of x and y should be identical"))
    end

    if size(x.signal) != size(x.signal)
        throw(ArgumentError("the size of x and y should be identical"))
    end

    Neuro1DRealSignal(
        signal = x.signal .+ y.signal,
        sample_rate = x.sample_rate
    )
end
