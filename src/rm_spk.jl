function rm_spk_fill_mean(
    x::Neuro1DRealSignal;
    window_width::Int,
    bar::Float64 = 3.0,
    method::Symbol = :sd)::Neuro1DRealSignal

    x_ = convert(Matrix{Float64}, copy(x.signal))
    r, c = size(x_)
    w = ceil(Int64, window_width * x.sample_rate)

    for i = 1:(r - w)
        window_x = x_[i:(i+w-1), :]
        window_μ = mean(window_x, dims = 1)
        for ch = 1:c
            ch_outlier = outliers(window_x[:, ch], method = method, bar = bar)
            window_x[ch_outlier, ch] .= window_μ[ch]
        end

        x_[i:(i+w-1), :] = window_x
    end


    Neuro1DRealSignal(
        signal = x_,
        sample_rate = x.sample_rate
    )
end

function rm_spk(
    x::Neuro1DRealSignal,
    method = :fill_mean;
    kwargs...)::Neuro1DRealSignal

    if method == :fill_mean
        rm_spk_fill_mean(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
