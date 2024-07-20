export
    PropertyTypes,
    Property,
    Group

module PropertyTypes
abstract type AbstractProperty end
struct Symmetric <: AbstractProperty end
struct Inverse <: AbstractProperty end
struct IllCond <: AbstractProperty end
struct PosDef <: AbstractProperty end
struct Eigen <: AbstractProperty end
struct Sparse <: AbstractProperty end
struct Random <: AbstractProperty end
struct RegProb <: AbstractProperty end
struct Graph <: AbstractProperty end
end

struct Property
    name::Symbol
end

struct Group
    name::Symbol
end
