function __fl_pass(x::Neuro1DRealSignal, response)
    design = Butterworth(4)

    Neuro1DRealSignal(
        signal = filt(digitalfilter(response, design), x.signal),
        sample_rate = x.sample_rate
    )
end

function fl_highpass(x::Neuro1DRealSignal; w::Real)
    response = Highpass(w; fs = x.sample_rate)

    __fl_pass(x, response)
end

function fl_lowpass(x::Neuro1DRealSignal; w::Real)
    response = Lowpass(w; fs = x.sample_rate)

    __fl_pass(x, response)
end

function fl_bandpass(x::Neuro1DRealSignal; w::Tuple{Real, Real})
    response = Bandpass(w1, w2; fs = x.sample_rate)

    __fl_pass(x, response)
end

function fl_pas(
    x::Neuro1DRealSignal,
    method = :band;
    kwargs...)::Neuro1DRealSignal

    if method == :high
        fl_highpass(x; kwargs...)
    elseif method == :low
        fl_lowpass(x; kwargs...)
    elseif method == :band
        fl_bandpass(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
