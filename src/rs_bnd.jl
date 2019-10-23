function t2i(x::Int, sample_rate::Real) # Time to index
    ceil(Int64, x * sample_rate + 1)
end

function rs_bnd_both(
    x::Neuro1DRealSignal,
    side::Symbol;
    position::Tuple{Int, Int})

    p = t2i.(position, x.sample_rate)

    Neuro1DRealSignal(
        signal = x.signal[minimum(p):maximum(p), :],
        sample_rate = x.sample_rate
    )
end

function rs_bnd_single(
    x::Neuro1DRealSignal;
    position::Int)

    p = t2i(position, x.sample_rate)

    Neuro1DRealSignal(
        signal = side == :right ? x.signal[1:p, :] : x.signal[p:end, :],
        sample_rate = x.sample_rate
    )
end

function rs_bnd(
    x::Neuro1DRealSignal,
    side = :both;
    kwargs...)::Neuro1DRealSignal

    if side == :both
        rs_bnd_both(x, side; kwargs...)
    elseif method in (:left, :right)
        rs_bnd_single(x; kwargs...)
    else
        throw(ArgumentError("invalid side"))
    end
end
