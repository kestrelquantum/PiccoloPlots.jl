```@meta
EditURL = "../../literate/quickstart.jl"
```

# Quickstart Guide

Here is a simple example where we set up a `NamedTrajectory` with some dummy data and plot populations of the columns of the unitary matrix.

First we will load some of the necessary packages

````@example quickstart
using NamedTrajectories
using PiccoloQuantumObjects
using PiccoloPlots
````

Next we will define some Hamiltonians

````@example quickstart
H_drives = [PAULIS[:Z], PAULIS[:Y]]
H_drift = PAULIS[:X]
````

Now we will generate some dummy control data

````@example quickstart
N = 100
Δt = 0.1
ts = 0:Δt:Δt*(N-1)
A = 0.1 * randn(length(H_drives), length(ts))
````

Now we will generate the unitaries

````@example quickstart
Us = exp.(-im * [(H_drift + sum(A[:, k] .* H_drives)) * ts[k] for k = 1:N])
Us[1]
````

And create the trajectory

````@example quickstart
traj = NamedTrajectory(
    (
        Ũ⃗ = hcat(operator_to_iso_vec.(Us)...), # here we store the isomorphisms
        a = A
    );
    controls = :a,
    timestep = Δt
)
````

Finally we will plot the populations

````@example quickstart
plot_unitary_populations(traj)
````

We can also only plot the first column (or any other subset of columns)

````@example quickstart
plot_unitary_populations(traj; unitary_columns=[1])
````

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

