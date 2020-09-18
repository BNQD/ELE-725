function entropy = myEntropy (x)

    unique_letters = unique(x);
    occurances = zeros(length(unique_letters), 2);
    
    for i = 1:length(unique_letters)
        occurances(i, 1) = unique_letters(i);
        if class (x) == "char"
            occurances(i, 2) = count(x, unique_letters(i));
        elseif class(x) == "uint8"
            occurances(i, 2) = sum(x(:) == unique_letters(i));
        end
    end
    
    probability = zeros(length(occurances), 1);
    
    for i = 1:length(occurances)
        
        probability(i) = occurances(i, 2)/numel(x);
    end
    
    entropy = -sum(probability.*log2(probability));
end