module SimpleParticleInCell
    using StaticArrays

    struct World
        mesh_origin :: SVector{3, Float64}
        cell_spacing :: SVector{3, Float64}
        number_cells ::SVector{3, Int}

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

end
