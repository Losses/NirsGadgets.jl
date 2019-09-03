module NirsGadgets

using Loess
using StatsBase
using Statistics
using MultivariateStats

include("./check_data.jl")
include("./outliers.jl")
include("./decimate.jl")
include("./rm_glb.jl")
include("./rm_spk.jl")
include("./rm_trd.jl")

export outliers
export decimate
export rm_glb
export rm_spk
export rm_trd

end # module
