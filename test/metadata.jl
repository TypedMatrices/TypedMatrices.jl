# list_properties
props = list_properties()
@test isa(props, Vector)
@test all(isa.(props, Property))

# check_propertie_types
@test isnothing(TypedMatrices.check_property_types(PropertyTypes.Symmetric, PropertyTypes.Inverse))
@test_throws ArgumentError TypedMatrices.check_property_types(Int)
@test_throws ArgumentError TypedMatrices.check_property_types(PropertyTypes.Symmetric, Int)

# check_properties_exists
@test isnothing(TypedMatrices.check_properties_exist(Property(:symmetric), Property(:inverse)))
@test_throws ArgumentError TypedMatrices.check_properties_exist(Property(:notexists))
@test_throws ArgumentError TypedMatrices.check_properties_exist(Property(:symmetric), Property(:notexists))

# property_types_to_properties
@test TypedMatrices.property_types_to_properties(PropertyTypes.Symmetric, PropertyTypes.Inverse) == [Property(:symmetric), Property(:inverse)]
@test_throws ArgumentError TypedMatrices.property_types_to_properties(Int)
@test_throws ArgumentError TypedMatrices.property_types_to_properties(PropertyTypes.Symmetric, Int)

# supress method overwritten warning
@suppress_err begin
    # @properties
    @test isnothing(@properties Matrix [:symmetric, :inverse])
    @test_throws ArgumentError @properties Matrix [:symmetric, :notexists]

    # register_properties
    @test isnothing(TypedMatrices.register_properties(Matrix, [Property(:symmetric), Property(:inverse)]))
    @test isnothing(TypedMatrices.register_properties(Matrix, Property(:symmetric), Property(:inverse)))
    @test isnothing(TypedMatrices.register_properties(Matrix, :symmetric, :inverse))
    @test isnothing(TypedMatrices.register_properties(Matrix, [:symmetric, :inverse]))
    @test isnothing(TypedMatrices.register_properties(Matrix, PropertyTypes.Symmetric, PropertyTypes.Inverse))
    @test isnothing(TypedMatrices.register_properties(Matrix, [PropertyTypes.Symmetric, PropertyTypes.Inverse]))
    @test isnothing(TypedMatrices.register_properties(Matrix, PropertyTypes.Symmetric(), PropertyTypes.Inverse()))
    @test isnothing(TypedMatrices.register_properties(Matrix, [PropertyTypes.Symmetric(), PropertyTypes.Inverse()]))
    @test_throws ArgumentError TypedMatrices.register_properties(Matrix, :notexists)
    @test_throws ArgumentError TypedMatrices.register_properties(Matrix, :symmetric, :notexists)
    @properties Matrix Property[]

    # properties
    @test properties(AbstractMatrix) == []
    @properties Matrix [:symmetric, :inverse]
    @test properties(Matrix) == [Property(:symmetric), Property(:inverse)]
    @test properties(Matrix(ones(1, 1))) == [Property(:symmetric), Property(:inverse)]
    @properties Matrix Property[]
end
