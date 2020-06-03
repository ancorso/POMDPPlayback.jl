# Policy for playing back a sequence of actions
mutable struct PlaybackPolicy <: Policy
    actions
    backup_policy::Policy
    logpdfs::Vector{Float64} # The log probabilities of each action
    i::Int64
end

# Constructor for the PlaybackPolicy
PlaybackPolicy(actions, backup_policy::Policy) = PlaybackPolicy(actions, backup_policy, [], 1)
PlaybackPolicy(actions, logpdfs::Vector{Float64}, backup_policy::Policy) = PlaybackPolicy(actions, backup_policy, logpdfs, 1)

# Action selection for the PlaybackPolicy
function POMDPs.action(p::PlaybackPolicy, s)
    a = p.i <= length(p.actions) ? p.actions[p.i] : action(p.backup_policy, s)
    p.i += 1
    a
end

# Get the logpdf of the history from the playback policy and the backup policy
function Distributions.logpdf(p::PlaybackPolicy, h)
    N = min(length(p.actions), length(h))
    @assert all(collect(action_hist(h))[1:N] .== p.actions[1:N])
    @assert length(p.actions) == length(p.logpdfs)
    if length(h) > N
        return sum(p.logpdfs) + sum(logpdf(p.backup_policy, view(h, N+1:length(h))))
    else
        return sum(p.logpdfs[1:N])
    end
end


