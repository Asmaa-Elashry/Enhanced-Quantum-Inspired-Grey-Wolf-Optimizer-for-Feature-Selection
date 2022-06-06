function [ output ] = sigmoid( input )

    %output = tanh(input);
    output = 1 / (1 + exp(-input));
end