var documenterSearchIndex = {"docs":
[{"location":"manual/getting-started/#Getting-Started","page":"Getting Started","title":"Getting Started","text":"","category":"section"},{"location":"manual/getting-started/#Installation","page":"Getting Started","title":"Installation","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"TypedMatrices.jl is a registered package in the Julia package registry. Use Julia's package manager to install it:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"pkg> add TypedMatrices","category":"page"},{"location":"manual/getting-started/#Setup","page":"Getting Started","title":"Setup","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Use the package:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using TypedMatrices","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"You can list all matrices available with list_matrices:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_matrices()","category":"page"},{"location":"manual/getting-started/#Creating-Matrices","page":"Getting Started","title":"Creating Matrices","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Each type of matrix has its own type and constructors. For example, to create a 5x5 Hilbert matrix:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"h = Hilbert(5)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Most matrices can accept a type parameter to specify the element type. For example, to create a 5x5 Hilbert matrix with Float64 elements:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Hilbert{Float64}(5)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Please check Builtin Matrices in Reference for all available builtin matrices.","category":"page"},{"location":"manual/getting-started/#Properties","page":"Getting Started","title":"Properties","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Matrix has properties like symmetric, illcond, and posdef. Function properties can be used to get the properties of a matrix:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"properties(Hilbert)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"You can also check properties of a matrix instance for convinience:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"properties(h)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"To view all available properties, use list_properties:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_properties()","category":"page"},{"location":"manual/getting-started/#Grouping","page":"Getting Started","title":"Grouping","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"This package has a grouping feature to group matrices. All builtin matrices are in the builtin group, we also create a user group for user-defined matrices. You can list all groups with:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_groups()","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"To add a matrix to groups and enable it to be listed by list_matrices, use add_to_groups:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"add_to_groups(Matrix, :user, :test)\nlist_matrices(Group(:user))","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"We can also add builtin matrices to our own groups:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"add_to_groups(Hilbert, :test)\nlist_matrices(Group(:test))","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"To remove a matrix from a group or all groups, use remove_from_group or remove_from_all_groups. The empty group will automatically be removed:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"remove_from_group(Hilbert, :test)\nremove_from_all_groups(Matrix)\nlist_groups()","category":"page"},{"location":"manual/getting-started/#Finding-Matrices","page":"Getting Started","title":"Finding Matrices","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_matrices is very powerful to list matrices, and filter by groups and properties. All arguments are \"and\" relationship, i.e. listed matrices must satisfy all conditions.","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"For example, to list all matrices in the builtin group, and all matrices with symmetric property:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_matrices(Group(:builtin))\nlist_matrices(Property(:symmetric))","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"To list all matrices in the builtin group with inverse, illcond, and eigen properties:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_matrices(\n    [\n        Group(:builtin),\n    ],\n    [\n        Property(:inverse),\n        Property(:illcond),\n        Property(:eigen),\n    ]\n)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"To list all matrices with symmetric, eigen, and posdef properties:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"list_matrices(:symmetric, :eigen, :posdef)","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"There are many alternative interfaces using list_matrices, please check the list_matrices or use Julia help system for more information.","category":"page"},{"location":"manual/performance/#Performance","page":"Performance","title":"Performance","text":"","category":"section"},{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/#Types","page":"Reference","title":"Types","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"TypedMatrices.PropertyTypes\nTypedMatrices.Property\nTypedMatrices.Group","category":"page"},{"location":"reference/#TypedMatrices.PropertyTypes","page":"Reference","title":"TypedMatrices.PropertyTypes","text":"PropertyTypes\n\nTypes of properties.\n\nSee also TypedMatrices.Property, TypedMatrices.list_properties.\n\nExamples\n\njulia> PropertyTypes.Symmetric\nTypedMatrices.PropertyTypes.Symmetric\n\n\n\n\n\n","category":"module"},{"location":"reference/#TypedMatrices.Property","page":"Reference","title":"TypedMatrices.Property","text":"Property\n\nProperty type. Similar to symbol, just to distinguish it from group.\n\nSee also list_properties, @properties, properties.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Group","page":"Reference","title":"TypedMatrices.Group","text":"Group\n\nGroup type. Similar to symbol, just to distinguish it from property.\n\nSee also list_matrices, list_groups, add_to_groups, remove_from_group, remove_from_all_groups.\n\n\n\n\n\n","category":"type"},{"location":"reference/#Interfaces","page":"Reference","title":"Interfaces","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"TypedMatrices.list_properties\nTypedMatrices.@properties\nTypedMatrices.properties\nTypedMatrices.list_groups\nTypedMatrices.add_to_groups\nTypedMatrices.remove_from_group\nTypedMatrices.remove_from_all_groups\nTypedMatrices.list_matrices","category":"page"},{"location":"reference/#TypedMatrices.list_properties","page":"Reference","title":"TypedMatrices.list_properties","text":"list_properties()\n\nList all properties. ```\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.@properties","page":"Reference","title":"TypedMatrices.@properties","text":"@properties Type [propa, propb, ...]\n\nRegister properties for a type. The properties are a vector of symbols.\n\nSee also: properties.\n\nExamples\n\njulia> @properties Matrix [:symmetric, :inverse, :illcond, :posdef, :eigen]\n\n\n\n\n\n","category":"macro"},{"location":"reference/#TypedMatrices.properties","page":"Reference","title":"TypedMatrices.properties","text":"properties(type)\nproperties(matrix)\n\nGet the properties of a type or matrix.\n\nSee also: @properties.\n\nExamples\n\njulia> @properties Matrix [:symmetric, :posdef]\n\njulia> properties(Matrix)\n2-element Vector{Property}:\n Property(:symmetric)\n Property(:posdef)\n\njulia> properties(Matrix(ones(1, 1)))\n2-element Vector{Property}:\n Property(:symmetric)\n Property(:posdef)\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.list_groups","page":"Reference","title":"TypedMatrices.list_groups","text":"list_groups()\n\nList all matrix groups.\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.add_to_groups","page":"Reference","title":"TypedMatrices.add_to_groups","text":"add_to_groups(type, groups)\n\nAdd a matrix type to groups. If a group is not exists, it will be created.\n\nGroups :builtin and :user are special groups. It is suggested always to add matrices to the :user group.\n\ngroups can be vector/varargs of Group or symbol.\n\nSee also remove_from_group, remove_from_all_groups.\n\nExamples\n\njulia> add_to_groups(Matrix, [Group(:user), Group(:test)])\n\njulia> add_to_groups(Matrix, Group(:user), Group(:test))\n\njulia> add_to_groups(Matrix, [:user, :test])\n\njulia> add_to_groups(Matrix, :user, :test)\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.remove_from_group","page":"Reference","title":"TypedMatrices.remove_from_group","text":"remove_from_group(type, group)\n\nRemove a matrix type from a group. If the group is empty, it will be deleted.\n\nSee also add_to_groups, remove_from_all_groups.\n\nExamples\n\njulia> add_to_groups(Matrix, Group(:user))\n\njulia> remove_from_group(Matrix, Group(:user))\n\njulia> add_to_groups(Matrix, :user)\n\njulia> remove_from_group(Matrix, :user)\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.remove_from_all_groups","page":"Reference","title":"TypedMatrices.remove_from_all_groups","text":"remove_from_all_groups(type)\n\nRemove a matrix type from all groups. If a group is empty, it will be deleted.\n\nSee also add_to_groups, remove_from_group.\n\nExamples\n\njulia> remove_from_all_groups(Matrix)\n\n\n\n\n\n","category":"function"},{"location":"reference/#TypedMatrices.list_matrices","page":"Reference","title":"TypedMatrices.list_matrices","text":"list_matrices(groups, props)\n\nList all matrices that are in groups and have properties.\n\ngroups can be vector/varargs of Group or symbol.\n\nprops can be vector/varargs of Property, symbol, subtype of PropertyTypes.AbstractProperty or instance of AbstractProperty.\n\nExamples\n\njulia> list_matrices()\n\njulia> list_matrices([Group(:builtin), Group(:user)], [Property(:symmetric), Property(:inverse)])\n\njulia> list_matrices(Property(:symmetric), Property(:inverse))\n\njulia> list_matrices([Property(:symmetric), Property(:inverse)])\n\njulia> list_matrices(:symmetric, :inverse)\n\njulia> list_matrices([:symmetric, :inverse])\n\njulia> list_matrices(PropertyTypes.Symmetric, PropertyTypes.Inverse)\n\njulia> list_matrices([PropertyTypes.Symmetric, PropertyTypes.Inverse])\n\njulia> list_matrices(PropertyTypes.Symmetric(), PropertyTypes.Inverse())\n\njulia> list_matrices([PropertyTypes.Symmetric(), PropertyTypes.Inverse()])\n\njulia> list_matrices(Group(:builtin), Group(:user))\n\njulia> list_matrices([Group(:builtin), Group(:user)])\n\n\n\n\n\n","category":"function"},{"location":"reference/#Builtin-Matrices","page":"Reference","title":"Builtin Matrices","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"TypedMatrices.Binomial\nTypedMatrices.Cauchy\nTypedMatrices.ChebSpec\nTypedMatrices.Chow\nTypedMatrices.Circulant\nTypedMatrices.Clement\nTypedMatrices.Companion\nTypedMatrices.Comparison\nTypedMatrices.DingDong\nTypedMatrices.Fiedler\nTypedMatrices.Forsythe\nTypedMatrices.Frank\nTypedMatrices.Golub\nTypedMatrices.Grcar\nTypedMatrices.Hadamard\nTypedMatrices.Hankel\nTypedMatrices.Hilbert\nTypedMatrices.InverseHilbert\nTypedMatrices.Involutory\nTypedMatrices.Kahan\nTypedMatrices.KMS\nTypedMatrices.Lehmer\nTypedMatrices.Lotkin\nTypedMatrices.Magic\nTypedMatrices.Minij\nTypedMatrices.Moler\nTypedMatrices.Neumann\nTypedMatrices.Oscillate\nTypedMatrices.Parter\nTypedMatrices.Pascal\nTypedMatrices.Pei\nTypedMatrices.Poisson\nTypedMatrices.Prolate\nTypedMatrices.Randcorr\nTypedMatrices.Rando\nTypedMatrices.RandSVD\nTypedMatrices.Rohess\nTypedMatrices.Rosser\nTypedMatrices.Sampling\nTypedMatrices.Toeplitz\nTypedMatrices.Triw\nTypedMatrices.Wathen\nTypedMatrices.Wilkinson","category":"page"},{"location":"reference/#TypedMatrices.Binomial","page":"Reference","title":"TypedMatrices.Binomial","text":"Binomial Matrix\n\nThe matrix is a multiple of an involutory matrix.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nG. Boyd, C.A. Micchelli, G. Strang and D.X. Zhou, Binomial matrices, Adv. in Comput. Math., 14 (2001), pp 379-391.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Cauchy","page":"Reference","title":"TypedMatrices.Cauchy","text":"Cauchy Matrix\n\nGiven two vectors x and y, the (i,j) entry of the Cauchy matrix is 1/(x[i]+y[j]).\n\nInput Options\n\nx: an integer, as vectors 1:x and 1:x.\nx, y: two integers, as vectors 1:x and 1:y.\nx: a vector. y defaults to x.\nx, y: two vectors.\n\nReferences\n\nN. J. Higham, Accuracy and Stability of Numerical Algorithms, second edition, Society for Industrial and Applied Mathematics, Philadelphia, PA, USA, 2002; sec. 28.1\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.ChebSpec","page":"Reference","title":"TypedMatrices.ChebSpec","text":"Chebyshev Spectral Differentiation Matrix\n\nIf k = 0,the generated matrix is nilpotent and a vector with         all one entries is a null vector. If k = 1, the generated         matrix is nonsingular and well-conditioned. Its eigenvalues         have negative real parts.\n\nInput Options\n\ndim, k: dim is the dimension of the matrix and       k = 0 or 1.\ndim: k=0.\n\nReferences\n\nL. N. Trefethen and M. R. Trummer, An instability         phenomenon in spectral methods, SIAM J. Numer. Anal., 24 (1987), pp. 1008-1023.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Chow","page":"Reference","title":"TypedMatrices.Chow","text":"Chow Matrix\n\nThe Chow matrix is a singular Toeplitz lower Hessenberg matrix.\n\nInput Options\n\ndim, alpha, delta: dim is dimension of the matrix.           alpha, delta are scalars such that A[i,i] = alpha + delta and           A[i,j] = alpha^(i + 1 -j) for j + 1 <= i.\ndim: alpha = 1, delta = 0.\n\nReferences\n\nT. S. Chow, A class of Hessenberg matrices with known                 eigenvalues and inverses, SIAM Review, 11 (1969), pp. 391-395.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Circulant","page":"Reference","title":"TypedMatrices.Circulant","text":"Circulant Matrix\n\nA circulant matrix has the property that each row is obtained by cyclically permuting the entries of the previous row one step forward.\n\nInput Options\n\nvec: a vector.\ndim: an integer, as vector 1:dim.\n\nReferences\n\nP. J. Davis, Circulant Matrices, John Wiley, 1977.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Clement","page":"Reference","title":"TypedMatrices.Clement","text":"Clement Matrix\n\nThe Clement matrix is a tridiagonal matrix with zero         diagonal entries. If k = 1, the matrix is symmetric.\n\nInput Options\n\ndim, k: dim is the dimension of the matrix.       If k = 0, the matrix is of type Tridiagonal.       If k = 1, the matrix is of type SymTridiagonal.\ndim: k = 0.\n\nReferences\n\nP. A. Clement, A class of triple-diagonal         matrices for test purposes, SIAM Review, 1 (1959), pp. 50-52.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Companion","page":"Reference","title":"TypedMatrices.Companion","text":"Companion Matrix\n\nThe companion matrix to a monic polynomial     a(x) = a_0 + a_1x + ... + a_{n-1}x^{n-1} + x^n     is the n-by-n matrix with ones on the subdiagonal and     the last column given by the coefficients of a(x).\n\nInput Options\n\nvec: vec is a vector of coefficients.\ndim: vec = [1:dim;]. dim is the dimension of the matrix.\npolynomial: polynomial is a polynomial. vector will be appropriate values from coefficients.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Comparison","page":"Reference","title":"TypedMatrices.Comparison","text":"Comparison Matrix\n\nThe comparison matrix for another matrix.\n\nInput Options\n\nB, k: B is a matrix.   k = 0: each element is absolute value of B, except each diagonal element is negative absolute value.   k = 1: each diagonal element is absolute value of B, except each off-diagonal element is negative largest absolute value in the same row.\nB: B is a matrix and k = 1.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.DingDong","page":"Reference","title":"TypedMatrices.DingDong","text":"Dingdong Matrix\n\nThe Dingdong matrix is a symmetric Hankel matrix invented by DR. F. N. Ris of IBM, Thomas J Watson Research Centre. The eigenvalues cluster around π/2 and -π/2.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nJ. C. Nash, Compact Numerical Methods for Computers: Linear Algebra and Function Minimisation, second edition, Adam Hilger, Bristol, 1990 (Appendix 1).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Fiedler","page":"Reference","title":"TypedMatrices.Fiedler","text":"Fiedler Matrix\n\nThe Fiedler matrix is symmetric matrix with a dominant       positive eigenvalue and all the other eigenvalues are negative.\n\nInput Options\n\nvec: a vector.\ndim: dim is the dimension of the matrix. vec=[1:dim;].\n\nReferences\n\nG. Szego, Solution to problem 3705, Amer. Math.             Monthly, 43 (1936), pp. 246-259.\n\nJ. Todd, Basic Numerical Mathematics, Vol. 2: Numerical Algebra,             Birkhauser, Basel, and Academic Press, New York, 1977, p. 159.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Forsythe","page":"Reference","title":"TypedMatrices.Forsythe","text":"Forsythe Matrix\n\nThe Forsythe matrix is a n-by-n perturbed Jordan block. This generator is adapted from N. J. Higham's Test Matrix Toolbox.\n\nInput Options\n\ndim, alpha, lambda: dim is the dimension of the matrix.   alpha and lambda are scalars.\ndim: alpha = sqrt(eps(type)) and lambda = 0.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Frank","page":"Reference","title":"TypedMatrices.Frank","text":"Frank Matrix\n\nThe Frank matrix is an upper Hessenberg matrix with determinant 1. The eigenvalues are real, positive and very ill conditioned.\n\nInput Options\n\ndim, k: dim is the dimension of the matrix, k = 0 or 1.   If k = 1 the matrix reflect about the anti-diagonal.\ndim: the dimension of the matrix.\n\nReferences\n\nW. L. Frank, Computing eigenvalues of complex matrices     by determinant evaluation and by methods of Danilewski and Wielandt,     J. Soc. Indust. Appl. Math., 6 (1958), pp. 378-392 (see pp. 385, 388).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Golub","page":"Reference","title":"TypedMatrices.Golub","text":"Golub Matrix\n\nGolub matrix is the product of two random unit lower and upper     triangular matrices respectively. LU factorization without pivoting     fails to reveal that such matrices are badly conditioned.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nD. Viswanath and N. Trefethen. Condition Numbers of     Random Triangular Matrices, SIAM J. Matrix Anal. Appl. 19, 564-581,     1998.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Grcar","page":"Reference","title":"TypedMatrices.Grcar","text":"Grcar Matrix\n\nThe Grcar matrix is a Toeplitz matrix with sensitive eigenvalues.\n\nInput Options\n\ndim, k: dim is the dimension of the matrix and   k is the number of superdiagonals.\ndim: the dimension of the matrix.\n\nReferences\n\nJ. F. Grcar, Operator coefficient methods     for linear equations, Report SAND89-8691, Sandia National     Laboratories, Albuquerque, New Mexico, 1989 (Appendix 2).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Hadamard","page":"Reference","title":"TypedMatrices.Hadamard","text":"Hadamard Matrix\n\nThe Hadamard matrix is a square matrix whose entries are 1 or -1. It was named after Jacques Hadamard. The rows of a Hadamard matrix are orthogonal.\n\nInput Options\n\ndim: the dimension of the matrix, dim is a power of 2.\n\nReferences\n\nS. W. Golomb and L. D. Baumert, The search for Hadamard matrices, Amer. Math. Monthly, 70 (1963) pp. 12-17\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Hankel","page":"Reference","title":"TypedMatrices.Hankel","text":"Hankel Matrix\n\nA Hankel matrix is a matrix that is symmetric and constant                 across the anti-diagonals.\n\nInput Options\n\nvc, vr: vc and vc are the first column and last row of the      matrix. If the last element of vc differs from the first element               of vr, the last element of rc prevails.\nv: a vector, as vc = v and vr will be zeros.\ndim: dim is the dimension of the matrix. v = [1:dim;].\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Hilbert","page":"Reference","title":"TypedMatrices.Hilbert","text":"Hilbert Matrix\n\nThe Hilbert matrix has (i,j) element 1/(i+j-1). It is notorious for being ill conditioned. It is symmetric positive definite and totally positive.\n\nSee also InverseHilbert.\n\nInput Options\n\ndim: the dimension of the matrix.\nrow_dim, col_dim: the row and column dimensions.\n\nReferences\n\nM. D. Choi, Tricks or treats with the Hilbert matrix, Amer. Math. Monthly, 90 (1983), pp. 301-312.\n\nN. J. Higham, Accuracy and Stability of Numerical Algorithms, second edition, Society for Industrial and Applied Mathematics, Philadelphia, PA, USA, 2002; sec. 28.1.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.InverseHilbert","page":"Reference","title":"TypedMatrices.InverseHilbert","text":"Inverse of the Hilbert Matrix\n\nSee also Hilbert.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nM. D. Choi, Tricks or treats with the Hilbert matrix,     Amer. Math. Monthly, 90 (1983), pp. 301-312.\n\nN. J. Higham, Accuracy and Stability of Numerical Algorithms, second     edition, Society for Industrial and Applied Mathematics, Philadelphia, PA,     USA, 2002; sec. 28.1.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Involutory","page":"Reference","title":"TypedMatrices.Involutory","text":"Involutory Matrix\n\nAn involutory matrix is a matrix that is its own inverse.\n\nInput Options\n\ndim: dim is the dimension of the matrix.\n\nReferences\n\nA. S. Householder and J. A. Carpenter, The         singular values of involutory and of idempotent matrices,         Numer. Math. 5 (1963), pp. 234-237.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Kahan","page":"Reference","title":"TypedMatrices.Kahan","text":"Kahan Matrix\n\nThe Kahan matrix is an upper trapezoidal matrix, i.e., the (i,j) element is equal to 0 if i > j. The useful range of     θ is 0 < θ < π. The diagonal is perturbed by     pert*eps()*diagm([n:-1:1;]).\n\nInput Options\n\nrowdim, coldim, θ, pert: rowdim and coldim are the row and column   dimensions of the matrix. θ and pert are scalars.\ndim, θ, pert: dim is the dimension of the matrix.\ndim: θ = 1.2, pert = 25.\n\nReferences\n\nW. Kahan, Numerical linear algebra, Canadian Math.     Bulletin, 9 (1966), pp. 757-801.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.KMS","page":"Reference","title":"TypedMatrices.KMS","text":"Kac-Murdock-Szego Toeplitz matrix\n\nInput Options\n\ndim, rho: dim is the dimension of the matrix, rho is a   scalar such that A[i,j] = rho^(abs(i-j)).\ndim: rho = 0.5.\n\nReferences\n\nW. F. Trench, Numerical solution of the eigenvalue     problem for Hermitian Toeplitz matrices, SIAM J. Matrix Analysis     and Appl., 10 (1989), pp. 135-146 (and see the references therein).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Lehmer","page":"Reference","title":"TypedMatrices.Lehmer","text":"Lehmer Matrix\n\nThe Lehmer matrix is a symmetric positive definite matrix.             It is totally nonnegative. The inverse is tridiagonal and             explicitly known\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nM. Newman and J. Todd, The evaluation of             matrix inversion programs, J. Soc. Indust. Appl. Math.,             6 (1958), pp. 466-476.             Solutions to problem E710 (proposed by D.H. Lehmer): The inverse             of a matrix, Amer. Math. Monthly, 53 (1946), pp. 534-535.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Lotkin","page":"Reference","title":"TypedMatrices.Lotkin","text":"Lotkin Matrix\n\nThe Lotkin matrix is the Hilbert matrix with its first row         altered to all ones. It is unsymmetric, illcond and         has many negative eigenvalues of small magnitude.\n\nInput Options\n\ndim: dim is the dimension of the matrix.\n\nReferences\n\nM. Lotkin, A set of test matrices, MTAC, 9 (1955), pp. 153-161.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Magic","page":"Reference","title":"TypedMatrices.Magic","text":"Magic Square Matrix\n\nThe magic matrix is a matrix with integer entries such that     the row elements, column elements, diagonal elements and     anti-diagonal elements all add up to the same number.\n\nInput Options\n\ndim: the dimension of the matrix.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Minij","page":"Reference","title":"TypedMatrices.Minij","text":"MIN[I,J] Matrix\n\nA matrix with (i,j) entry min(i,j). It is a symmetric positive      definite matrix. The eigenvalues and eigenvectors are known      explicitly. Its inverse is tridiagonal.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nJ. Fortiana and C. M. Cuadras, A family of matrices,             the discretized Brownian bridge, and distance-based regression,             Linear Algebra Appl., 264 (1997), 173-188.  (For the eigensystem of A.)\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Moler","page":"Reference","title":"TypedMatrices.Moler","text":"Moler Matrix\n\nThe Moler matrix is a symmetric positive definite matrix. It has one small eigenvalue.\n\nInput Options\n\ndim, alpha: dim is the dimension of the matrix,       alpha is a scalar.\ndim: alpha = -1.\n\nReferences\n\nJ.C. Nash, Compact Numerical Methods for Computers:     Linear Algebra and Function Minimisation, second edition,     Adam Hilger, Bristol, 1990 (Appendix 1).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Neumann","page":"Reference","title":"TypedMatrices.Neumann","text":"Neumann Matrix\n\nA singular matrix from the discrete Neumann problem.        The matrix is sparse and the null space is formed by a vector of ones\n\nInput Options\n\ndim: the dimension of the matrix, must be a perfect square integer.\n\nReferences\n\nR. J. Plemmons, Regular splittings and the           discrete Neumann problem, Numer. Math., 25 (1976), pp. 153-161.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Oscillate","page":"Reference","title":"TypedMatrices.Oscillate","text":"Oscillating Matrix\n\nA matrix A is called oscillating if A is totally     nonnegative and if there exists an integer q > 0 such that     A^q is totally positive.\n\nInput Options\n\nΣ: the singular value spectrum of the matrix.\ndim, mode: dim is the dimension of the matrix.       mode = 1: geometrically distributed singular values.       mode = 2: arithmetrically distributed singular values.\ndim: mode = 1.\n\nReferences\n\nPer Christian Hansen, Test matrices for     regularization methods. SIAM J. SCI. COMPUT Vol 16,     No2, pp 506-512 (1995).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Parter","page":"Reference","title":"TypedMatrices.Parter","text":"Parter Matrix\n\nThe Parter matrix is a Toeplitz and Cauchy matrix             with singular values near π.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nThe MathWorks Newsletter, Volume 1, Issue 1,             March 1986, page 2. S. V. Parter, On the distribution of the             singular values of Toeplitz matrices, Linear Algebra and             Appl., 80 (1986), pp. 115-130.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Pascal","page":"Reference","title":"TypedMatrices.Pascal","text":"Pascal Matrix\n\nThe Pascal matrix’s anti-diagonals form the Pascal’s triangle.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nR. Brawer and M. Pirovino, The linear algebra of     the Pascal matrix, Linear Algebra and Appl., 174 (1992),     pp. 13-23 (this paper gives a factorization of L = PASCAL(N,1)                and a formula for the elements of L^k).\n\nN. J. Higham, Accuracy and Stability of Numerical Algorithms, second edition, Society for Industrial and Applied Mathematics, Philadelphia, PA, USA, 2002; sec. 28.4.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Pei","page":"Reference","title":"TypedMatrices.Pei","text":"Pei Matrix\n\nThe Pei matrix is a symmetric matrix with known inversion.\n\nInput Options\n\ndim, alpha: dim is the dimension of the matrix.   alpha is a scalar.\ndim: the dimension of the matrix.\n\nReferences\n\nM. L. Pei, A test matrix for inversion procedures,     Comm. ACM, 5 (1962), p. 508.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Poisson","page":"Reference","title":"TypedMatrices.Poisson","text":"Poisson Matrix\n\nA block tridiagonal matrix from Poisson’s equation.      This matrix is sparse, symmetric positive definite and      has known eigenvalues.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nG. H. Golub and C. F. Van Loan, Matrix Computations,           second edition, Johns Hopkins University Press, Baltimore,           Maryland, 1989 (Section 4.5.4).\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Prolate","page":"Reference","title":"TypedMatrices.Prolate","text":"Prolate Matrix\n\nA prolate matrix is a symmetirc, ill-conditioned Toeplitz matrix.\n\nInput Options\n\ndim, alpha: dim is the dimension of the matrix. w is a real scalar.\ndim: the case when w = 0.25.\n\nReferences\n\nJ. M. Varah. The Prolate Matrix. Linear Algebra and Appl.              187:267–278, 1993.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Randcorr","page":"Reference","title":"TypedMatrices.Randcorr","text":"Random Correlation Matrix\n\nA random correlation matrix is a symmetric positive      semidefinite matrix with 1s on the diagonal.\n\nInput Options\n\ndim: the dimension of the matrix.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Rando","page":"Reference","title":"TypedMatrices.Rando","text":"Random Matrix with Element -1, 0, 1\n\nInput Options\n\nrowdim, coldim, k: row_dim and col_dim are row and column dimensions,  k = 1: entries are 0 or 1.  k = 2: entries are -1 or 1.  k = 3: entries are -1, 0 or 1.\ndim, k: row_dim = col_dim = dim.\ndim: k = 1.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.RandSVD","page":"Reference","title":"TypedMatrices.RandSVD","text":"Random Matrix with Pre-assigned Singular Values\n\nInput Options\n\nrowdim, coldim, kappa, mode: row_dim and col_dim   are the row and column dimensions. kappa is the condition number of the matrix. mode = 1: one large singular value. mode = 2: one small singular value. mode = 3: geometrically distributed singular values. mode = 4: arithmetrically distributed singular values. mode = 5: random singular values with  unif. dist. logarithm.\ndim, kappa, mode: row_dim = col_dim = dim.\ndim, kappa: mode = 3.\ndim: kappa = sqrt(1/eps()), mode = 3.\n\nReferences\n\nN. J. Higham, Accuracy and Stability of Numerical Algorithms, second edition, Society for Industrial and Applied Mathematics, Philadelphia, PA, USA, 2002; sec. 28.3.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Rohess","page":"Reference","title":"TypedMatrices.Rohess","text":"Random Orthogonal Upper Hessenberg Matrix\n\nThe matrix is constructed via a product of Givens rotations.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nW. B. Gragg, The QR algorithm for unitary     Hessenberg matrices, J. Comp. Appl. Math., 16 (1986), pp. 1-8.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Rosser","page":"Reference","title":"TypedMatrices.Rosser","text":"Rosser Matrix\n\nThe Rosser matrix’s eigenvalues are very close together         so it is a challenging matrix for many eigenvalue algorithms.\n\nInput Options\n\ndim, a, b: dim is the dimension of the matrix.           dim must be a power of 2.           a and b are scalars. For dim = 8, a = 2 and b = 1, the generated           matrix is the test matrix used by Rosser.\ndim: a = rand(1:5), b = rand(1:5).\n\nReferences\n\nJ. B. Rosser, C. Lanczos, M. R. Hestenes, W. Karush,             Separation of close eigenvalues of a real symmetric matrix,             Journal of Research of the National Bureau of Standards, v(47)             (1951)\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Sampling","page":"Reference","title":"TypedMatrices.Sampling","text":"Matrix with Application in Sampling Theory\n\nA nonsymmetric matrix with eigenvalues 0, 1, 2, ... n-1.\n\nInput Options\n\nvec: vec is a vector with no repeated elements.\ndim: dim is the dimension of the matrix.           vec = [1:dim;]/dim.\n\nReferences\n\nL. Bondesson and I. Traat, A nonsymmetric matrix             with integer eigenvalues, linear and multilinear algebra, 55(3)             (2007), pp. 239-247\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Toeplitz","page":"Reference","title":"TypedMatrices.Toeplitz","text":"Toeplitz Matrix\n\nA Toeplitz matrix is a matrix in which each descending        diagonal from left to right is constant.\n\nInput Options\n\nvc, vr: vc and vr are the first column and row of the matrix.\nv: symmatric case, i.e., vc = vr = v.\ndim: dim is the dimension of the matrix. v = [1:dim;] is the first       row and column vector.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Triw","page":"Reference","title":"TypedMatrices.Triw","text":"Triw Matrix\n\nUpper triangular matrices discussed by Wilkinson and others.\n\nInput Options\n\nrowdim, coldim, α, k: row_dim and col_dim       are row and column dimension of the matrix. α is a       scalar representing the entries on the superdiagonals.       k is the number of superdiagonals.\ndim: the dimension of the matrix.\n\nReferences\n\nG. H. Golub and J. H. Wilkinson, Ill-conditioned eigensystems and the computation of the Jordan canonical form, SIAM Review, 18(4), 1976, pp. 578-6\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Wathen","page":"Reference","title":"TypedMatrices.Wathen","text":"Wathen Matrix\n\nWathen Matrix is a sparse, symmetric positive, random matrix arose from the finite element method. The generated matrix is the consistent mass matrix for a regular nx-by-ny grid of 8-nodes.\n\nInput Options\n\n[type,] nx, ny: the dimension of the matrix is equal to   3 * nx * ny + 2 * nx * ny + 1.\n[type,] n: nx = ny = n.\n\nGroups: [\"symmetric\", \"posdef\", \"eigen\", \"random\", \"sparse\"]\n\nReferences\n\nA. J. Wathen, Realistic eigenvalue bounds for     the Galerkin mass matrix, IMA J. Numer. Anal., 7 (1987),     pp. 449-457.\n\n\n\n\n\n","category":"type"},{"location":"reference/#TypedMatrices.Wilkinson","page":"Reference","title":"TypedMatrices.Wilkinson","text":"Wilkinson Matrix\n\nThe Wilkinson matrix is a symmetric tridiagonal matrix with pairs of nearly equal eigenvalues. The most frequently used case is matrixdepot(\"wilkinson\", 21). The result is of type Tridiagonal.\n\nInput Options\n\ndim: the dimension of the matrix.\n\nReferences\n\nJ. H. Wilkinson, Error analysis of direct methods of matrix inversion, J. Assoc. Comput. Mach., 8 (1961),  pp. 281-330.\n\n\n\n\n\n","category":"type"},{"location":"#TypedMatrices.jl-Documentation","page":"Home","title":"TypedMatrices.jl Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Welcome to the documentation for TypedMatrices.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"An extensible Julia matrix collection utilizing type system to enhance performance.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Check Getting Started for a quick start.","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Types of matercies, can be used in algorithm tests or other.\nOptimized matrix operations for these types\nProperties (tags) for matrices.\nGrouping matercies and allow user to define their own types.\nFiltering matrices by properties or groups.","category":"page"}]
}
