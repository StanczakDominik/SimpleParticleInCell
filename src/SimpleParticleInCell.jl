module SimpleParticleInCell
    using StaticArrays

    struct World
        mesh_origin :: SVector{3}
        cell_spacing :: SVector{3}
        number_cells ::SVector{3, Int}
    end

end
