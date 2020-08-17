using SimpleParticleInCell
using Test

@testset "SimpleParticleInCell.jl" begin
    world = SimpleParticleInCell.World([0,0,0], [1,1,1], [4,4,4])
    @test world.mesh_origin == [0,0,0]
    @test world.cell_spacing == [1., 1., 1.]
end
