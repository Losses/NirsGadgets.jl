module NirsGadgets

using DSP
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
include("./re_smp.jl")

export outliers
export rm_glb
export rm_spk
export rm_trd
export re_smp

end # module
