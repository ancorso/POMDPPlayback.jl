# POMDPPlayback.jl
[![Build Status](https://travis-ci.org/sisl/POMDPPlayback.jl.svg?branch=master)](https://travis-ci.org/sisl/POMDPPlayback.jl) [![Coverage Status](https://coveralls.io/repos/github/sisl/POMDPPlayback.jl/badge.svg?branch=master)](https://coveralls.io/github/sisl/POMDPPlayback.jl?branch=master) [![codecov](https://codecov.io/gh/sisl/POMDPPlayback.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/sisl/POMDPPlayback.jl)

This package defines a policy for rolling out a pre-defined sequence of actions to an MDP or POMDP defined with the `POMDPs.jl` package.

## Usage
A `PlaybackPolicy` can be constructed in two ways:
1. `PlaybackPolicy(actions, backup_policy::Policy)` - where `actions` is a sequence of actions to output and `backup_policy` is the policy used if the MDP has not terminated by the time all the prescribed actions have been used.
2. `PlaybackPolicy(actions, logpdfs::Vector{Float64}, backup_policy::Policy)` - The only difference for this constructor is the ability to specify the log-probability of the prescribed actions as `logpdfs`. Use this in combination with algorithms that require the probability of actions.

Once defined, get an action using `POMDPs.action(p::PlaybackPolicy, s)`


Maintained by Anthony Corso (acorso@stanford.edu)
