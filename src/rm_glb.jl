function rm_glb_pca(x::Neuro1DRealSignal; remove_ratio = 0.9)::Neuro1DRealSignal
    local _x = x.signal'
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

    Neuro1DRealSignal(
        signal = convert(
            Matrix{Float64},
            MultivariateStats.reconstruct(new_mod, transform(new_mod, _x)
        )'),
        sample_rate = x.sample_rate
    )
end

function rm_glb_mean(x::Neuro1DRealSignal)::Neuro1DRealSignal
    glb_μ = mean(x.signal, dims = 2)

    βs = cov(x.signal, glb_μ) ./ var(glb_μ)

    Neuro1DRealSignal(
        signal = x.signal - glb_μ * βs',
        sample_rate = x.sample_rate
    )
end

function rm_glb(
    x::Neuro1DRealSignal,
    method = :glb_mean;
    kwargs...)::Neuro1DRealSignal

    if method == :glb_mean
        rm_glb_mean(x)
    elseif method == :pca
        rm_glb_pca(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
