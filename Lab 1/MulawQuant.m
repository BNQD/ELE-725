function out = MulawQuant(inFile, outFile, N, Mu)
[y, Fs] = audioread(inFile);

%u-law compression
y_1 = max(y(:,1)) .* ((log10 (1 + (Mu .* (abs(y(:,1)/max(y(:,1)))))) ./ log10 (1 + Mu)) .* sign(y(:, 1)));
y_2 = max(y(:,2)) .* ((log10 (1 + (Mu .* (abs(y(:,2)/max(y(:,2)))))) ./ log10 (1 + Mu)) .* sign(y(:, 2)));
y_mu = horzcat(y_1,y_2);

audiowrite("mulaw_temp.wav", y_mu, round(Fs));

compressed = UniformQuant("mulaw_temp.wav", "mulaw_quant N = " + N + " Mu = " + Mu, N);

audiowrite("mulaw_temp_2.wav", compressed, round(Fs/N));

[y, Fs] = audioread("mulaw_temp_2.wav");

%Inverse u-law - Expand
x_1 = max(y(:, 1)/Mu) .* 10 .^ ( log10 (1 + Mu) ./ max(y(:, 1)) .* abs (compressed(:, 1)) - 1) .* sign(compressed(:, 1));
x_2 = max(y(:, 2)/Mu) .* 10 .^ ( log10 (1 + Mu) ./ max(y(:, 2)) .* abs (compressed(:, 2)) - 1) .* sign(compressed(:, 2));
out = horzcat(x_1, x_2);

audiowrite(outFile + ".wav", out, round(Fs/N));

end