function check(x::Matrix{T} where T <: Real)
    r, c = size(x)
    if c > r
        @warn "the column size is greater than row size, you may need to transform your data"
    end
end
