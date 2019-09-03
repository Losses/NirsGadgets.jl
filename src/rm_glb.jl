function rm_glb_pca(x::Matrix{T} where T <: Real; remove_ratio = 0.9)
    local _x = x'
    local M = fit(PCA, _x, pratio=1.0)
    local p_ratio = M.prinvars ./ M.tprinvar

    local cum_ratio = 0
    local pc_idx = 0

    for i = 1:length(p_ratio)
        local _cum_ratio = cum_ratio + p_ratio[i]

        if (_cum_ratio >= remove_ratio)
            pc_idx = i
            break
        end

        cum_ratio = _cum_ratio
    end

    local new_mod = PCA(
        M.mean,
        M.proj[:, pc_idx:end],
        M.prinvars[pc_idx:end],
        sum(M.prinvars[pc_idx:end]),
        M.tvar)

    reconstruct(new_mod, transform(new_mod, _x))
end

function rm_glb_mean(x::Matrix{T} where T <: Real)
    glb_μ = mean(x, dims = 2)

    βs = cov(x, glb_mean) ./ var(glb_μ)

    x - glb_μ * βs'
end

function rm_glb(x, method = :glb_mean; kwargs...)
    if method == :glb_mean
        rm_glb_mean(x)
    elseif method == :pca
        rm_glb_pca(x, kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end

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
