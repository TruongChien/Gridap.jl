module CellQuadraturesTests

using Test
using FillArrays
using Gridap.Helpers
using Gridap.Fields
using Gridap.ReferenceFEs
using Gridap.Geometry
using Gridap.Arrays
using Gridap.Integration

using Gridap.Geometry: GridMock

degree = 3
quad = Quadrature(HEX,degree)
test_quadrature(quad)
@test sum(get_weights(quad)) ≈ 1

degree = (1,2,3)
quad = Quadrature(HEX,degree)
test_quadrature(quad)
@test sum(get_weights(quad)) ≈ 1

degree = 3
quad = Quadrature(TET,degree)
test_quadrature(quad)
@test sum(get_weights(quad)) ≈ 0.5*1/3

trian = GridMock()

degree = 3
quad = CellQuadrature(trian,degree)
q = get_coordinates(quad)
@test isa(q,CompressedArray)
w = get_weights(quad)
@test isa(w,CompressedArray)

q2x = get_cell_map(trian)
x = evaluate(q2x,q)

#using Gridap.Visualization
#writevtk(trian,"trian")
#writevtk(x,"x",nodaldata=["w"=>w])

domain = (0,1,0,1,0,1)
partition = (2,3)
trian = CartesianGrid(domain,partition)
quad = CellQuadrature(trian,degree)
q = get_coordinates(quad)
@test isa(q,Fill)
w = get_weights(quad)
@test isa(w,Fill)

end # module
