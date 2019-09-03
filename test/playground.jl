using JLD

data = JLD.load("./test/resting_state.jld")
x = data["resting_state"]
