function out = UniformQuant(inFile, outFile, N)

[y, Fs] = audioread(inFile);

q_1 = (max(y(:,1)) - min(y(:,1))) / 2^N;
q_2 = (max(y(:,2)) - min(y(:,2))) / 2^N;

%Use appropriate level function
quantized_1 = floor(y(:,1)./q_1) + 0.5;
quantized_2 = floor(y(:,2)/q_2) + 0.5;


%Multiply with Q to reconstruct signal
reconstructed_1 = quantized_1 * q_1;
reconstructed_2 = quantized_2 * q_2;

out = horzcat(reconstructed_1, reconstructed_2);

audiowrite(outFile + ".wav", out, round(Fs/N));
end