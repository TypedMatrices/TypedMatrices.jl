# constructors
@test allequal([
    Orthog(5),
    Orthog(5, 1),
    Orthog{Float64}(5),
    Orthog{Float64}(5, 1),
])

# linear algebra functions
run_test_linearalgrbra_functions(Orthog.(1:5))

# eltype
@test test_matrix_elements(Orthog{Float64}(5))

# content
@test Orthog(5) ≈ Orthog(5, 1) ≈ [0.2886751345948128 0.49999999999999994 0.5773502691896257 0.5 0.2886751345948128; 0.49999999999999994 0.5 7.070501591499379e-17 -0.4999999999999999 -0.49999999999999994; 0.5773502691896257 7.070501591499379e-17 -0.5773502691896257 -1.4141003182998758e-16 0.5773502691896257; 0.5 -0.4999999999999999 -1.4141003182998758e-16 0.5000000000000002 -0.5; 0.2886751345948128 -0.49999999999999994 0.5773502691896257 -0.5 0.2886751345948132]
@test Orthog(5, 2) ≈ [0.32601867960931696 0.5485287319805897 0.5968847876668415 0.4557341406552499 0.16989112404918136; 0.5485287319805897 0.4557341406552499 -0.1698911240491812 -0.5968847876668415 -0.3260186796093169; 0.5968847876668415 -0.1698911240491812 -0.5485287319805898 0.3260186796093167 0.4557341406552506; 0.4557341406552499 -0.5968847876668415 0.3260186796093167 0.1698911240491815 -0.5485287319805897; 0.16989112404918136 -0.3260186796093169 0.4557341406552506 -0.5485287319805897 0.5968847876668415]
@test Orthog{Complex{Float64}}(5, 3) ≈ [0.4472135954999579+0.0im 0.4472135954999579+0.0im 0.4472135954999579+0.0im 0.4472135954999579+0.0im 0.4472135954999579+0.0im; 0.4472135954999579+0.0im 0.13819660112501053+0.42532540417601994im -0.3618033988749894+0.26286555605956685im -0.36180339887498947-0.26286555605956674im 0.13819660112501042-0.42532540417602im; 0.4472135954999579+0.0im -0.3618033988749894+0.26286555605956685im 0.13819660112501042-0.42532540417602im 0.13819660112501064+0.42532540417601994im -0.3618033988749896-0.26286555605956663im; 0.4472135954999579+0.0im -0.36180339887498947-0.26286555605956674im 0.13819660112501064+0.42532540417601994im 0.1381966011250103-0.42532540417602005im -0.36180339887498936+0.262865556059567im; 0.4472135954999579+0.0im 0.13819660112501042-0.42532540417602im -0.3618033988749896-0.26286555605956663im -0.36180339887498936+0.262865556059567im 0.13819660112501084+0.42532540417601983im]
@test Orthog(5, 4) ≈ [0.4472135954999579 0.4472135954999579 0.4472135954999579 0.4472135954999579 0.4472135954999579; 0.7071067811865475 -0.7071067811865475 0.0 0.0 0.0; 0.4082482904638631 0.4082482904638631 -0.8164965809277261 0.0 0.0; 0.2886751345948129 0.2886751345948129 0.2886751345948129 -0.8660254037844387 0.0; 0.22360679774997896 0.22360679774997896 0.22360679774997896 0.22360679774997896 -0.8944271909999159]
@test Orthog(5, 5) ≈ [0.4472135954999579 0.4472135954999579 0.4472135954999579 0.4472135954999579 0.4472135954999579; 0.4472135954999579 0.5635220053010305 -0.09893784281542256 -0.6246689549345562 -0.2871288030510096; 0.4472135954999579 -0.09893784281542256 -0.2871288030510096 0.5635220053010306 -0.6246689549345562; 0.4472135954999579 -0.6246689549345562 0.5635220053010306 -0.28712880305100974 -0.09893784281542234; 0.4472135954999579 -0.2871288030510096 -0.6246689549345562 -0.09893784281542234 0.5635220053010307]
@test Orthog(5, 6) ≈ [0.6246689549345563 0.5635220053010305 0.447213595499958 0.2871288030510095 0.09893784281542271; 0.5635220053010305 0.09893784281542271 -0.4472135954999579 -0.6246689549345563 -0.2871288030510095; 0.447213595499958 -0.4472135954999579 -0.44721359549995804 0.4472135954999578 0.44721359549995804; 0.2871288030510095 -0.6246689549345563 0.4472135954999578 0.09893784281542342 -0.5635220053010304; 0.09893784281542271 -0.2871288030510095 0.44721359549995804 -0.5635220053010304 0.6246689549345564]
@test Orthog(5, -1) ≈ [1.0 1.0 1.0 1.0 1.0; 1.0 0.7071067811865476 6.123233995736766e-17 -0.7071067811865475 -1.0; 1.0 6.123233995736766e-17 -1.0 -1.8369701987210297e-16 1.0; 1.0 -0.7071067811865475 -1.8369701987210297e-16 0.7071067811865477 -1.0; 1.0 -1.0 1.0 -1.0 1.0]
@test Orthog(5, -2) ≈ [1.0 1.0 1.0 1.0 1.0; 0.9510565162951535 0.5877852522924731 6.123233995736766e-17 -0.587785252292473 -0.9510565162951535; 0.8090169943749475 -0.30901699437494734 -1.0 -0.30901699437494756 0.8090169943749473; 0.5877852522924731 -0.9510565162951535 -1.8369701987210297e-16 0.9510565162951536 -0.5877852522924729; 0.30901699437494745 -0.8090169943749475 1.0 -0.8090169943749472 0.309016994374947]
