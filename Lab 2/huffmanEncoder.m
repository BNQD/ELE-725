function [codeword, code, symbol] = huffmanEncoder(sequence)
    unique_values = unique(sequence);
    occurances = zeros(length(unique_values), 2);
    
    
    for i = 1:length(unique_values)
        occurances(i, 1) = unique_values(i);
        if class (sequence) == "char"
            occurances(i, 2) = count(sequence, unique_values(i));
        elseif class(sequence) == "uint8"
            occurances(i, 2) = sum(sequence(:) == unique_values(i));
        end
    end
    
    probability = zeros(length(occurances), 1);
    
    for i = 1:length(occurances)
        probability(i) = occurances(i, 2)/numel(sequence);
    end

    temp = zeros(length(unique_values), 2);
    huffman_tree = -1*ones(numel(sequence), 4);
    for i = 1: numel(unique_values)
        huffman_tree(i, 1) = probability(i); 

        temp(i, 1) = i;            
        temp(i, 2) = probability(i);   
    end
    
    i = numel(sequence) + 1;
    rows = size(temp, 1);

    while rows > 1
        temp = sortrows(temp, 2);

        temp(length(temp) + 1, 2) = temp(1, 2) + temp(2, 2);
        temp(length(temp), 1) = i;

        huffman_tree(i, 1) = temp(1, 2) + temp(2, 2);
        %Children
        huffman_tree(i, 3) = temp(1, 1); 
        huffman_tree(i, 4) = temp(2, 1);
        %Set parents
        huffman_tree(temp(1, 1), 2) = i;
        huffman_tree(temp(2, 1), 2) = i;
        temp = temp(3: end, :);
        
        rows = size(temp, 1);
        i = i + 1;
    end  

    code_tree = "";
    children = length(huffman_tree);
    i = 1;

    while ~isempty(children)
        current = children(1);
        huff_code = code_tree(1);
        children = children(2: end);
        code_tree = code_tree(2: end);

        code_tree_len = length(code_tree);

        if huffman_tree(current, 4) ~= -1 
          children = [children huffman_tree(current, 3)];          % add the left child
          code_tree(code_tree_len + 1) = strcat(huff_code, "0");

          children = [children huffman_tree(current, 4)];          % add the right child
          code_tree(code_tree_len + 2) = strcat(huff_code, "1");

        else 
          code(i, 1) = huff_code;
          symbol(i, 1) = unique_values(current);

          i = i + 1;
        end
    end

    codeword = "";

    for i = 1: length(sequence)
        codeword = strcat(codeword, code(symbol == sequence(i)));
    end
end