using SimpleParticleInCell
using Documenter

makedocs(;
    modules=[SimpleParticleInCell],
    authors="Dominik Stańczak <stanczakdominik@gmail.com> and contributors",
    repo="https://github.com/StanczakDominik/SimpleParticleInCell.jl/blob/{commit}{path}#L{line}",
    sitename="SimpleParticleInCell.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://StanczakDominik.github.io/SimpleParticleInCell.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/StanczakDominik/SimpleParticleInCell.jl",
)
