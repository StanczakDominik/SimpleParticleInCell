using SimpleParticleInCell
using Test

@testset "SimpleParticleInCell.jl::World" begin
    world = SimpleParticleInCell.World([0.0,0.0,0.0],
                                       [1.0,1.0,1.0], 
                                       (4,4,4),
                                       0.1,
                                       10
                                       )
    @test world.mesh_origin == [0,0,0]
    @test world.cell_spacing == [0.25, 0.25, 0.25]
    @test all(world.electric_potential .== 0)
    @test all(world.electric_field .== 0)
    @test all(world.charge_density .== 0)

    @test all(size(world.charge_density) .== world.number_cells)
    @test all(size(world.electric_potential) .== world.number_cells)
    @test all(size(world.electric_field) .== (world.number_cells..., 3))
    @test world.timestep == 0.1
    @test world.number_timesteps == 10

    electrons = SimpleParticleInCell.Species("e-", 1.0, -1.0, world)
    @test size(electrons.density) == world.number_cells
    @test all(electrons.density .== 0)
    @test length(electrons.particles) == 0

    electron = SimpleParticleInCell.Particle([0., 0., 0.], [1., -1., 2.], 1.)
    push!(electrons.particles, electron)
    @test length(electrons.particles) == 1
    
end
