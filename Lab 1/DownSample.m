function out = DownSample(inFile, outFile, N, pf)
    [y, Fs] = audioread(inFile);
    if pf == 1 %Use Prefilter
       out(:, 1) = decimate(y(:, 1), N);
       out(:, 2) = decimate(y(:, 2), N);
    else
       out(:, 1) = y(N:N:end, 1);
       out(:, 2) = y(N:N:end, 2);
    end
    
    audiowrite(outFile + ".wav", out, round(Fs/N));
end