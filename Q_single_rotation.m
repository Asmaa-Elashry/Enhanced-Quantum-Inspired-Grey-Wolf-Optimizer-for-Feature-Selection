function [rotated_value]=Q_single_rotation (rotation_angle)
rotated_value=[cos(rotation_angle) -sin(rotation_angle);sin(rotation_angle) cos(rotation_angle)];