push!(LOAD_PATH, "../src/")

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
        ],
        "Reference" => "reference.md",
    ],
)
