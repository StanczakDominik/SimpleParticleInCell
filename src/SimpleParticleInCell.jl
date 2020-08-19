module SimpleParticleInCell
    using StaticArrays


    struct World
        mesh_origin :: SVector{3, Float64}
        cell_spacing :: SVector{3, Float64}
        number_cells ::Tuple{Int, Int, Int}

        charge_density :: Array{Float64, 3}
        electric_potential :: Array{Float64, 3}
        electric_field :: Array{Float64, 4}

        timestep :: Real
        number_timesteps :: Int

        function World(
                       r1 :: Vector,
                       r2 :: Vector,
                       number_cells :: Tuple{Int, Int, Int},
                       timestep :: Number,
                       number_timesteps :: Int,
                      )
            cell_spacing = (r2 .- r1) ./ number_cells
            new(
                r1,
                cell_spacing,
                number_cells,
                zeros(Float64, number_cells),
                zeros(Float64, number_cells),
                zeros(Float64, (number_cells..., 3)),
                timestep,
                number_timesteps,
               )
        end
    end

    struct Particle
        position :: SVector{3, Float64}
        velocity :: SVector{3, Float64}
        mpw :: Float64
    end


    struct Species
        symbol :: String
        mass :: Float64
        charge :: Float64
        density :: Array{Float64, 3}
        particles :: Array{Particle, 1}

        function Species(
                         symbol :: String,
                         mass :: Float64,
                         charge :: Float64,
                         world :: World,
                        )
            new(
                symbol,
                mass,
                charge,
                zeros(Float64, world.number_cells),
                Particle[],
               )
        end
    end

    function solve_potential(world::World)
        # @show world
        error("TODO unimplemented")
    end

    function compute_electric_field(world :: World)
        # @show world
        error("TODO unimplemented")
    end

    function load_particles_box(species::Species, world::World)
        error("TODO unimplemented")
    end
    
    function compute_box_volumes(world::World)
        error("TODO unimplemented")
    end

    function X_to_L(particle :: Particle, world::World)
        return (particle.position .- world.mesh_origin) ./ world.cell_spacing
    end

    function scatter(field::Array,
                     location,
                     value::Float64,
                     world::World,
                    )
        if any((location .< 1) .| (world.number_cells .< location))
            return
        end

        indices = floor.(Int, location)
        fractional_distances = location - indices

        i, j, k = indices .- 1
        di, dj, dk = fractional_distances

        for (ii, DI) in enumerate([1-di, di])
            iindex = i + ii
            for (jj, DJ) in enumerate([1-dj, dj])
                jindex = j + jj
                for (kk, DK) in enumerate([1-dk, dk])
                    kindex = k + kk
                    # @show iindex jindex kindex
                    field[iindex, jindex, kindex] += value * DI * DJ * DK
                end
            end
        end
    end

    function compute_number_density(species::Species,
                                    world::World)
        species.density .= 0
        for particle in species.particles
            location = X_to_L(particle, world)
            # @show particle_index location
            scatter(species.density, location, particle.mpw, world)
            # @show species.density
        end
    end

        # species.density ./= world.node_volume  # TODO
end
