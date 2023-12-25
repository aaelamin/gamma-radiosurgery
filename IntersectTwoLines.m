function [intersection, rem] = IntersectTwoLines(P1, v1, P2, v2)
%
% INPUTS:
%        P1 - Fixed point of the first line as a 3-element vector [x, y, z].
%        v1 - Direction vector of the first line as a 3-element vector [x, y, z].
%        P2 - Fixed point of the second line as a 3-element vector [x, y, z].
%        v2 - Direction vector of the second line as a 3-element vector [x, y, z].
% OUTPUTS:
%        intersection - Symbolic intersection point represented as a 3-element
%                      vector [x, y, z]
%
%        error - Error metric representing the distance between the intersection
%                 point and the closest point on the second line, in millimeters.


    % Firstly, we validate the inputs of the function. Each input should be of
    % length 3 since they represent points and their direction in 3D
    if length(P1) ~= 3 || length(v1) ~= 3 || length(P2) ~= 3 || length(v2) ~= 3
        error('Input data should be 3D points and vectors.');
    end

    % Here we are calculating a third directional vector Parallel to the
    % first and third vector
    v3 = cross(v1, v2)/norm(cross(v1, v2));

    % Breaking first point to it's basic components
    P1x = P1(1);
    P1y = P1(2);
    P1z = P1(3);
    
    % Breaking first vector to it's basic components
    v1x = v1(1);
    v1y = v1(2);
    v1z = v1(3);

    % Breaking second point to it's basic components
    P2x = P2(1);
    P2y = P2(2);
    P2z = P2(3);

    % Breaking second vector to it's basic components
    v2x = v2(1);
    v2y = v2(2);
    v2z = v2(3);

    % Breaking third vector to it's basic components
    v3x = v3(1);
    v3y = v3(2);
    v3z = v3(3);

 
    
    P_matrix = [P1x-P2x;
                P1y-P2y;
                P1z-P2z];
    
    v_matrix = [-v1x, v2x, v3x;
                -v1y, v2y, v3y;
                -v1z, v2z, v3z];
    
    % Solve system of equations using inverse matrix
    t_matrix = v_matrix^(-1)*P_matrix;

    % Here we are extracting t1 and t2 from the t matrix which we will use
    % in futrure codes
    t1 = t_matrix(1);
    t2 = t_matrix(2);

    L1 = P1 +t1*v1;
    L2 = P2 +t2*v2;

    M = (L1+L2) / 2;

    if isnan(M)     % Lines are pararel
        disp("The lines are parrarel");
        intersection = [];
    else
        intersection = M;
    end

        distance1 = norm(M - L1);
        distance2 = norm(M - L2);
        
        rem = min(distance1, distance2);

    
  
end



% https://www.mathworks.com/matlabcentral/answers/16848-how-to-find-distance-between-two-points