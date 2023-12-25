function [intersections, numIntersections] = IntersectLineEllipsoid(P, v, a, b, c)
%
% INPUTS:
%   P - Fixed point of the line as a 3-element vector [x; y; z].
%   v - Direction vector of the line as a 3-element vector [x; y; z].
%   a - Half-axis length along the x-axis of the ellipsoid.
%   b - Half-axis length along the y-axis of the ellipsoid.
%   c - Half-axis length along the z-axis of the ellipsoid.
% OUTPUTS:
%   numIntersections - Number of intersection points (0, 1, or 2).
%   intersectionPoints - Matrix of intersection points represented as a
%                       3xN matrix where each column is [x, y, z].

    % P and v represent a point an d its vector in 3D and therefore they
    % should be represented as vector made of 3 elements. The code below
    % checks if the point P and the direction v follow these restrictions.

    %a, b and c represent the radii along the x, y and z axies of te
    %ellipsoid and therefore they should be postive numbers
    if length(P) == 3 && length(v) == 3 && a > 0 && b > 0 && c > 0 

        % This piece of code is seperating the point and the direction of
        % the line into its x, y and z components
        Px = P(1);
        Py = P(2);
        Pz = P(3);
        vx = v(1);
        vy = v(2);
        vz = v(3);
        
        % In the context of the derived polynomial equation:
        % A represents the coefficient of the t^2 term,
        % B represents the coefficient of the t term,
        % and C represents the constant term (without t).
        % See attached image that showcases the steps to arrive to the
        % solution below
        A = (vx^2+vy^2+vz^2);
        B = 2*(Px*vx+Py*vy+Pz*vz);
        C = (Px^2+Py^2+Pz^2-a^2*b^2*c^2);
    
    
        discriminant = B^2-4*A*C;
        % If the discriminant is negative that means that there is no real
        % solutions, or roots, for the quandratic formula. In the context
        % of the given proble, this means that the line and the ellipsoid
        % do not intersect in 3D space
        if discriminant < 0
            intersections = [];
            numIntersections = 0;

        % If the discriminant is zero that means that ther;
        % e is single
        % solution, or root, for the quandratic formula. In the context of
        % the problem, the line might hav etouched the ellipsoid but not
        % actually went through it.

        % we solve for t which tells us the magnitude the a vector has to
        % move from poin "P" in directon 'v' to "touch" the ellipsoid. We
        % then sub it back into the equation of the line to find the point
        % or points of intersection

        elseif discriminant == 0
            numIntersections = 1;
            t = -B/(2*A);
            intersections = [Px + t * vx, Py + t * vy, Pz + t * vz];
        
        else
        % If the discriminant is positive that means that there is two
        % solutions, or roots, for the quandratic formula. In the context of
        % the problem, the line would have intersected and entered the ellipsoid at point A and passed through
        % the ellipsoid, extiting at point B on the other side

            numIntersections = 2; 
            t1 = -B + sqrt(discriminant)/(2*A);
            t2 = -B - sqrt(discriminant)/(2*A);
            intersections = [Px + t1 * vx, Py + t1 * vy, Pz + t1 * vz;
                             Px + t2 * vx, Py + t2 * vy, Pz + t2 * vz];
        end
        
    else
        error("Invalid input. a, b, and c should be positive and P and v should be e elements vectors")
    end
end
        
