function out=func_putCircle(target, cx, cy, radius, value)

    out = repmat(target, 1);
    [Nx, Ny] = size(target);
    assert( (cx>=0) && (cy>=0) && (cx <= Nx) && (cy <= Ny) )

    for iy = 1:Ny
        for ix = 1:Nx
            if ((iy - cy)^2 + (ix - cx)^2 <= radius^2 )
                out(iy, ix) = target(iy, ix) + value;
            end
        end
    end
    
end