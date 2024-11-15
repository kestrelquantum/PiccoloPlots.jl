using PiccoloPlots
using Documenter

DocMeta.setdocmeta!(PiccoloPlots, :DocTestSetup, :(using PiccoloPlots); recursive=true)

makedocs(;
    modules=[PiccoloPlots],
    authors="Aaron Trowbridge <aaron.j.trowbridge@gmail.com> and contributors",
    sitename="PiccoloPlots.jl",
    format=Documenter.HTML(;
        canonical="https://aarontrowbridge.github.io/PiccoloPlots.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aarontrowbridge/PiccoloPlots.jl",
    devbranch="main",
)
