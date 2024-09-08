using Documenter, TypedMatrices

DocMeta.setdocmeta!(TypedMatrices, :DocTestSetup, :(using TypedMatrices); recursive=true)

format = Documenter.HTML(
    collapselevel=1,
)

makedocs(
    modules=[TypedMatrices],
    sitename="TypedMatrices.jl",
    checkdocs=:none,
    format=format,
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "manual/1.getting-started.md",
            "manual/2.performance.md",
        ],
        "References" => [
            "references/1.types.md",
            "references/2.interfaces.md",
            "references/3.properties.md",
            "references/4.builtin-matrices.md",
        ],
    ],
)

if "deploy" in ARGS
    deploydocs(
        repo = "github.com/TypedMatrices/TypedMatrices.jl.git",
    )
else
    @info "Skipping deployment ('deploy' not passed)"
end
