%% Part 1.1.2: Entropy of Test Sequence
x = 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM';

entropy = myEntropy(x);
disp ("Entropy of Test Sequence: " + entropy);
%% Part 1.2.1: Entropy of Grayscale

grayscale = rgb2gray(imread('lena.jpg'));
entropy_grayscale = myEntropy(grayscale);

disp ("Entropy of Grayscale: " + entropy_grayscale);
comp_ratio_grayscale = 8/entropy_grayscale;
%% Part 1.2.2: Entropy of Colour
ycbcr = rgb2ycbcr(imread ('dog.jpg'));

y_channel = ycbcr(:, :, 1);
cb_channel = ycbcr(:, :, 2);
cr_channel = ycbcr(:, :, 3);

entropy_y = myEntropy(y_channel);
entropy_cb = myEntropy(cb_channel);
entropy_cr = myEntropy(cr_channel);

total_bits = entropy_y + entropy_cb + entropy_cr;
comp_ratio_rgb = 24/total_bits;
%% Part 2: Huffman Encoder 




%% Part 2: Encoding and Decoding a Phase

[codeword, code, symbol] = huffmanEncoder(x);
sequence = huffmanDecoder(codeword, code, symbol);

%% Part 2: Encoding an Image
grayscale = rgb2gray(imread('small_dog.jpg'));
[codeword, code, symbol] = huffmanEncoder(grayscale(:));
decoded = huffmanDecoderImage(codeword, code, symbol);
decoded = uint8(reshape(decoded, 100, 100));
