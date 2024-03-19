using Plots

function group(initial_coordinates)
# It initializes four empty arrays group_A, group_B, group_C, group_D and store the coordinates based on the minimum distance.
# returns four arrays containing coordinates belonging to each group.
    group_A = []
    group_B = []
    group_C = []
    group_D = []
    for coord in coordinates 
        dist = []
        for init_coord in initial_coordinates
            push!(dist, sqrt((coord[1] - init_coord[1])^2 + (coord[2] - init_coord[2])^2))
        end
        if argmin(dist) == 1
            push!(group_A, coord)
        elseif argmin(dist) == 2
            push!(group_B, coord)
        elseif argmin(dist) == 3
            push!(group_C, coord)
        else argmin(dist) == 4
            push!(group_D, coord)
        end
    end
    return group_A, group_B, group_C ,group_D
end

function center_coord(coordinates)
# This function calculates the center of a group of coordinates(points).
# Returns the average coordinate.
    x_avg = sum(t -> t[1], coordinates) / length(coordinates)
    y_avg = sum(t -> t[2], coordinates) / length(coordinates)
    avg_coordinate = (x_avg, y_avg)
    return avg_coordinate
end

function dist(group)
# This function calculates the average distance of each points in a group from its centroid.
# It first calculates the center of the group using the center_coord function.
# Then, for each point in the group, it calculates the distance to the center.
# Finally, it returns the average distance of all points from the center.
    center = center_coord(group)
    dist = []
    for g in group
        push!(dist,sqrt((g[1] - center[1])^2 + (g[2] - center[2])^2))
    end
    dist = sum(dist) / length(group)
end 

function avg_dist(groups)
# This function calculates the average distance of each group from its center.
    d = []
    for g in groups
        push!(d, dist(g))
    end
    avg_dist = sum(d) / 4
    return avg_dist
end

function Kmeans(initial_coordinates)
# This function calculates the initial centers of the groups using the centre_coord function.
# It iteratively updates the centers and calculates the average distance of each group from its center.
# Repeats this process for 10 times.
# Finally, it returns the array D_bar containing the average distances at each iteration.
    D_bar = []              
    center = []
    for g in group(initial_coordinates)
        push!(center,center_coord(g))
    end     
    for _ in 1:10
        push!(D_bar,avg_dist(group(center)))
        for g in group(center)
            push!(center,center_coord(g))
        end
        center = center[5:8]
    end
    return D_bar
end

coordinates = [(2, 5), (3, 2), (3, 3), (3, 4), (4, 3),
               (4, 4), (6, 3), (6, 4), (6, 6), (7, 2),
               (7, 5), (7, 6), (7, 7), (8, 6), (8, 7)]

initial_coordinates = [(2, 2), (4, 6), (6, 5), (8, 8)]
D = Kmeans(initial_coordinates)
# Print the last element of D
print(D)