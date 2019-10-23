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
include("./ts_hbt.jl")
include("./cc_avg.jl")
include("./cc_ana.jl")
include("./cc_add.jl")
include("./rs_bnd.jl")

export outliers
export to_1ds
export rm_glb
export rm_spk
export rm_trd
export re_smp
export fl_pas
export an_hbt
export cc_avg
export cc_mod
export cc_arg
export cc_rea
export cc_add
export rs_bnd

export Neuro1DRealSignal
export Neuro1DAnalyticSignal

end # module
