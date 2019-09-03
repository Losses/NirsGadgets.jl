# Code from https://github.com/toddleo/Outliers.jl/blob/master/outliers.jl, with modification

function outliers_iqr(x::Vector{T} where T <: Real; bar::Float64 = 1.5)
    Q1, Q3 = quantile(x, 0.25), quantile(x, 0.75)
    LIF = Q1 - range * (Q3 - Q1)
    UIF = Q3 + range * (Q3 - Q1)

    .!(LIF .< x .< UIF)
end

function outliers_sd(x::Vector{T} where T <: Real; bar::Float64 = 3.0)
    x = zscore(x)
    μ,σ = mean(x), std(x)

    .!((-1 * abs(bar)) .< (x .- μ) ./  σ .< abs(bar))
end

function outliers(
    x::Vector{T} where T <: Real;
    bar::Union{Float64, Nothing} = nothing,
    method::Symbol = :sd
)
    if method == :sd
        outliers_sd(x, bar = isnothing(bar) ? 3.0 : bar)
    elseif method == :iqr
        outliers_iqr(x, bar = isnothing(bar) ? 1.5 : bar)
    else
        throw(ArgumentError("invalid method"))
    end
end
