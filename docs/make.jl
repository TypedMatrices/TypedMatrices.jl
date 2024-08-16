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
            "manual/getting-started.md",
            "manual/performance.md",
        ],
        "Reference" => "reference.md",
    ],
)

if "deploy" in ARGS
    deploydocs(
        repo = "github.com/TypedMatrices/TypedMatrices.jl.git",
    )
else
    @info "Skipping deployment ('deploy' not passed)"
end
