function [qu] =Q_Rotation(rotation_angle,qubit_alpha,qubit_beta)
qu=[qubit_alpha;qubit_beta];
rotation_matrix=[cos(rotation_angle) -sin(rotation_angle);sin(rotation_angle) cos(rotation_angle)];
qu=rotation_matrix*qu;
