module SimpleParticleInCell
    using StaticArrays


    struct World
        mesh_origin :: SVector{3, Float64}
        cell_spacing :: SVector{3, Float64}
        number_cells ::Tuple{Int, Int, Int}

        charge_density :: Array{Float64, 3}
        electric_potential :: Array{Float64, 3}
        electric_field :: Array{Float64, 4}

        node_volumes :: Array{Float64, 3}

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
            node_volumes = zeros(Float64, number_cells)
            compute_node_volumes(node_volumes, number_cells, cell_spacing)
            new(
                r1,
                cell_spacing,
                number_cells,
                zeros(Float64, number_cells),
                zeros(Float64, number_cells),
                zeros(Float64, (number_cells..., 3)),
                node_volumes,
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

    function compute_node_volumes(node_volumes, number_cells, cell_spacing)
        ni, nj, nk = number_cells
        for i in range(1, length=ni)
            for j in range(1, length=nj)
                for k in range(1, length=nk)
                    V = reduce(*, cell_spacing)
                    if (i == 1 || i == ni)
                        V *= 0.5
                    end
                    if (j == 1 || j == nj)
                        V *= 0.5
                    end
                    if (k == 1 || k == nk)
                        V *= 0.5
                    end

                    node_volumes[i,j,k] = V
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
        species.density ./= world.node_volumes
    end

end
