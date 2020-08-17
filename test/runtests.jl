using SimpleParticleInCell
using Test

@testset "SimpleParticleInCell.jl" begin
    world = SimpleParticleInCell.World([0.0,0.0,0.0],
                                       [1.0,1.0,1.0], 
                                       [4,4,4],
                                       )
    @test world.mesh_origin == [0,0,0]
    @test world.cell_spacing == [0.25, 0.25, 0.25]
end
