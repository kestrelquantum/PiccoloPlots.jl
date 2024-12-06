using PiccoloPlots
using Documenter
using Literate

push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

pages = [
    "Home" => "index.md",
    "Quickstart Guide" => "generated/quickstart.md",
    "Library" => "lib.md"
]

format = Documenter.HTML(;
    prettyurls=get(ENV, "CI", "false") == "true",
    canonical="https://aarontrowbridge.github.io/NamedTrajectories.jl",
    edit_link="main",
    assets=String[],
    mathengine = MathJax3(Dict(
        :loader => Dict("load" => ["[tex]/physics"]),
        :tex => Dict(
            "inlineMath" => [["\$","\$"], ["\\(","\\)"]],
            "tags" => "ams",
            "packages" => [
                "base",
                "ams",
                "autoload",
                "physics"
            ],
            "macros" => Dict(
                "minimize" => ["\\underset{#1}{\\operatorname{minimize}}", 1],
            )
        ),
        # :TeX => Dict(
        #     :Macros => Dict(
        #         :minimize => ["\\underset{#1}{\\operatorname{minimize}}", 1],
        #     )
        # )
    )),
)

src = joinpath(@__DIR__, "src")
lit = joinpath(@__DIR__, "literate")

lit_output = joinpath(src, "generated")

for (root, _, files) ∈ walkdir(lit), file ∈ files
    splitext(file)[2] == ".jl" || continue
    ipath = joinpath(root, file)
    opath = splitdir(replace(ipath, lit=>lit_output))[1]
    Literate.markdown(ipath, opath)
end

makedocs(;
    modules=[PiccoloPlots],
    authors="Aaron Trowbridge <aaron.j.trowbridge@gmail.com> and contributors",
    sitename="PiccoloPlots.jl",
    warnonly = [:missing_docs],
    format=format,
    pages=pages,
)

deploydocs(;
    repo="github.com/kestrelquantum/PiccoloPlots.jl.git",
    devbranch="main",
)
