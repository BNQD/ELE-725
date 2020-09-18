function decoded = huffmanDecoderImage(codeword, code, symbol)
    codeword = char(codeword);
    decoded_msg = [];
    curr_pixel = 1;
    while strlength(codeword) > 0
        curr_code = 1;
        while (1)
            temp = char(code(curr_code));
            find_flag = strfind(codeword(1:length(char(code(curr_code)))), temp);
            if (find_flag == 1)
                break
            end
            curr_code = curr_code + 1;
        end
        decoded_msg(curr_pixel) = (symbol(curr_code));
        curr_pixel = curr_pixel + 1;
        codeword = extractAfter(codeword, strlength(code(curr_code)));
    end
    
    decoded = decoded_msg;
end
