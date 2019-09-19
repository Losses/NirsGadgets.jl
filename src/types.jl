@with_kw struct Neuro1DRealSignal
    signal::Matrix{Float64}
    sample_rate::Float64
end

@with_kw struct Neuro1DAnalyticSignal
    signal::Matrix{ComplexF64}
    sample_rate::Float64
end

function to_1ds(x::Matrix{T} where T <: Real; sample_rate::Float64)
    check(x)
    Neuro1DRealSignal(
        signal = convert(Matrix{Float64}, x),
        sample_rate = sample_rate
    )
end
