module QuantumObjectPlots

export plot_unitary_populations

using NamedTrajectories
using QuantumCollocationCore
using PiccoloQuantumObjects
using TestItemRunner

function get_layout(index::Int, n::Int)
    √n = isqrt(n) + 1
    return ((index - 1) ÷ √n + 1, (index - 1) % √n + 1)
end

"""
    plot_unitary_populations(
        traj::NamedTrajectory;
        unitary_columns::AbstractVector{Int}=1:2,
        unitary_name::Symbol=:Ũ⃗,
        control_name::Symbol=:a,
        kwargs...
    )

    plot_unitary_populations(
        prob::QuantumControlProblem;
        kwargs...
    )

Plot the populations of the unitary columns of the unitary matrix in the trajectory. `kwargs` are passed to [`NamedTrajectories.plot`](https://aarontrowbridge.github.io/NamedTrajectories.jl/dev/generated/plotting/).

# Keyword Arguments
- `unitary_columns::AbstractVector{Int}`: The columns of the unitary matrix to plot the populations of. Default is `1:2`.
- `unitary_name::Symbol`: The name of the unitary matrix in the trajectory. Default is `:Ũ⃗`.
- `control_name::Symbol`: The name of the control in the trajectory. Default is `:a`.
- `kwargs...`: Additional keyword arguments passed to [`NamedTrajectories.plot`](https://kestrelquantum.github.io/NamedTrajectories.jl/dev/generated/plotting/). 
"""
function plot_unitary_populations end

function plot_unitary_populations(
    traj::NamedTrajectory;
    unitary_columns::AbstractVector{Int}=1:2,
    unitary_name::Symbol=:Ũ⃗,
    control_name::Symbol=:a,
    kwargs...
)

    transformations = OrderedDict(
        unitary_name => [
            x -> abs2.(iso_vec_to_operator(x)[:, i])
                for i ∈ unitary_columns
        ]
    )

    transformation_titles = OrderedDict(
        unitary_name => [
            L"Populations: $\left| U_{:, %$(i)}(t) \right|^2$"
                for i ∈ unitary_columns
        ]
    )

    plot(traj, [control_name];
        transformations=transformations,
        transformation_titles=transformation_titles,
        include_transformation_labels=true,
        kwargs...
    )
end

function plot_unitary_populations(prob::QuantumControlProblem; kwargs...)
    plot_unitary_populations(prob.trajectory; kwargs...)
end

end
