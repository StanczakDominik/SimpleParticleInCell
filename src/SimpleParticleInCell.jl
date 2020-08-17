module SimpleParticleInCell
    using StaticArrays

    struct World
        mesh_origin :: SVector{3, Float64}
        cell_spacing :: SVector{3, Float64}
        number_cells ::SVector{3, Int}
        testint :: Int
        function World(
                       r1 :: Vector,
                       r2 :: Vector,
                       number_cells :: Vector{Int},
                      )
            cell_spacing = (r2 .- r1) ./ number_cells
            new(
                r1,
                cell_spacing,
                number_cells
               )
        end

    end

end
