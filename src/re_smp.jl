function re_smp_deci(x; rate)
    r, c = size(x)

    result = zeros(ceil(Int64, r/rate), c)

    for i = 1:c
        result[:, c] = decimate(x[:, i], rate)
    end

    result
end

function re_smp(
    x::Matrix{T} where T <: Real,
    method = :decimate;
    kwargs...)
    check(x)

    if method == :decimate
        re_smp_deci(x; kwargs...)
    else
        throw(ArgumentError("invalid method"))
    end
end
