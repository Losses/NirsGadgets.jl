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

    reconstruct(new_mod, transform(new_mod, _x))'
end

function rm_glb_mean(x::Matrix{T} where T <: Real)
    glb_μ = mean(x, dims = 2)

    βs = cov(x, glb_mean) ./ var(glb_μ)

    x - glb_μ * βs'
end

function rm_glb(
    x,
    method = :glb_mean;
    kwargs...)
    check(x)

    if method == :glb_mean
        rm_glb_mean(x)
    elseif method == :pca
        rm_glb_pca(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
