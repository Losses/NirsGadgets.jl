module NirsGadgets

using DSP
using Loess
using StatsBase
using Statistics
using Parameters
using MultivariateStats

include("./check_data.jl")
include("./outliers.jl")
include("./types.jl")
include("./rm_glb.jl")
include("./rm_spk.jl")
include("./rm_trd.jl")
include("./re_smp.jl")
include("./fl_pas.jl")

export outliers
export to_1ds
export rm_glb
export rm_spk
export rm_trd
export re_smp
export fl_pas

end # module
