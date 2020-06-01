using POMDPPlayback
using POMDPs
using POMDPModels
using POMDPPolicies
using POMDPSimulators
using Test

mdp = SimpleGridWorld(tprob = 1)
hist = simulate(HistoryRecorder(), mdp, RandomPolicy(mdp), GWPos(3,3))

## Test the playback simulator
playback = PlaybackPolicy(collect(action_hist(hist)), RandomPolicy(mdp))
@test all(playback.actions .== action_hist(hist))
@test playback.backup_policy isa RandomPolicy
@test playback.i == 1

hist2 = simulate(HistoryRecorder(), mdp, playback, GWPos(3,3))
@test hist == hist2

