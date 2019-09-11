using JLD

include("../src/NirsGadgets.jl")

data = JLD.load("./test/resting_state.jld")
x = data["resting_state"]

y = x |>
    x -> NirsGadgets.to_1ds(x,             sample_rate = 55.55) |>
    x -> NirsGadgets.rm_spk(x, :fill_mean, window_width = 5*55) |>
    x -> NirsGadgets.rm_glb(x, :pca      , remove_ratio = 0.8 ) |>
    x -> NirsGadgets.rm_glb(x, :glb_mean                      ) |>
    x -> NirsGadgets.rm_trd(x, :linear                        ) |>
    x -> NirsGadgets.fl_pas(x, :low      , w = 1              ) |>
    x -> NirsGadgets.re_smp(x, :decimate , rate = 1/55.55     )
