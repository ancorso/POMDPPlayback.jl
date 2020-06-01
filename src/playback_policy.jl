# Policy for playing back a sequence of actions
mutable struct PlaybackPolicy <: Policy
    actions
    backup_policy::Policy
    i::Int64
end

# Constructor for the PlaybackPolicy
PlaybackPolicy(actions, backup_policy::Policy) = PlaybackPolicy(actions, backup_policy, 1)

# Action selection for the PlaybackPolicy
function POMDPs.action(p::PlaybackPolicy, s)
    a = p.i <= length(p.actions) ? p.actions[p.i] : action(p.backup_policy, s)
    p.i += 1
    a
end