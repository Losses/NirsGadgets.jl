function rm_spk_fill_mean(
    x::Matrix{T} where T <: Real;
    window_width::Int,
    bar::Float64 = 3.0,
    methdod::Symbol = :sd)

    x_ = copy(x)
    r, c = size(x_)

    for i = 1:(r - window_width)
        window_x = x_[i:(i+window_width-1), :]
        window_μ = mean(window_x, dims = 1)
        for ch = 1:c
            ch_outlier = outliers(window_x[:, ch], method = method, bar = bar)
            window_x[ch_outlier, ch] .= window_μ[ch]
        end

        x_[i:(i+window_width-1), :] = window_x
    end

    x_
end

function rm_spk(x, method = :fill_mean; kwargs...)
    if method == :fill_mean
        rm_glb_pca(x, kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end