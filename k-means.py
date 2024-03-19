import math

def group(initial_coordinates, coordinates):
    # Initializes four empty lists group_A, group_B, group_C, group_D and store the coordinates based on the minimum distance.
    # Returns four lists containing coordinates belonging to each group.
    group_A = []
    group_B = []
    group_C = []
    group_D = []
    for coord in coordinates:
        dist = []
        for init_coord in initial_coordinates:
            dist.append(math.sqrt((coord[0] - init_coord[0])**2 + (coord[1] - init_coord[1])**2))
        min_index = dist.index(min(dist))
        if min_index == 1:
            group_A.append(coord)
        elif min_index == 2:
            group_B.append(coord)
        elif min_index == 3:
            group_C.append(coord)
        else:
            group_D.append(coord)
    return group_A, group_B, group_C, group_D

def center_coord(coordinates):
    # Calculates the center of a group of coordinates(points).
    # Returns the average coordinate.
    x_avg = sum(coord[0] for coord in coordinates) / len(coordinates)
    y_avg = sum(coord[1] for coord in coordinates) / len(coordinates)
    avg_coordinate = (x_avg, y_avg)
    return avg_coordinate

def dist(group):
    # Calculates the average distance of each points in a group from its centroid.
    # It first calculates the center of the group using the center_coord function.
    # Then, for each point in the group, it calculates the distance to the center.
    # Finally, it returns the average distance of all points from the center.
    center = center_coord(group)
    distances = [math.sqrt((coord[0] - center[0])**2 + (coord[1] - center[1])**2) for coord in group]
    avg_distance = sum(distances) / len(group)
    return avg_distance

def avg_dist(groups):
    # Calculates the average distance of each group from its center.
    distances = [dist(g) for g in groups]
    avg_distance = sum(distances) / 4
    return avg_distance

def Kmeans(initial_coordinates, coordinates):
    # Calculates the initial centers of the groups using the center_coord function.
    # It iteratively updates the centers and calculates the average distance of each group from its center.
    # Repeats this process for 10 times.
    # Finally, it returns the array D_bar containing the average distances at each iteration.
    D_bar = []
    center = [center_coord(g) for g in group(initial_coordinates, coordinates)]
    for _ in range(10):
        D_bar.append(avg_dist(group(center, coordinates)))
        for g in group(center, coordinates):
            center.append(center_coord(g))
        center = center[4:]
    return D_bar

coordinates = [(2, 5), (3, 2), (3, 3), (3, 4), (4, 3),
               (4, 4), (6, 3), (6, 4), (6, 6), (7, 2),
               (7, 5), (7, 6), (7, 7), (8, 6), (8, 7)]

initial_coordinates = [(2, 2), (4, 6), (6, 5), (8, 8)]
D = Kmeans(initial_coordinates, coordinates)
# Print the last element of D
print(D)
