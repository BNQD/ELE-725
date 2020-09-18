pause_flag = 1; %When enabled, execution will pause after each playback of audio file
per_filter_flag = 1; %When Pre_Filter = 1, will run pf=1 downsampling
no_filter_flag = 1; %When no_filter = 1, will run pf=0 downsampling
uniform_quant_flag = 1; %When uniform_quant_flag = 1, will run uniform quantization
mulaw_flag = 1; %When mulaw_flag = 1, will run mulaw quantization
close all;
[y, Fs] = audioread("ELE725_lab1.wav");

audio_info = audioinfo("ELE725_lab1.wav");

size = (audio_info.BitsPerSample * audio_info.TotalSamples * audio_info.NumChannels / 8)/1024; %Size in kB

figure(1);
orig_y_fft = fft(y);
subplot(1, 1, 1);
plot(real(orig_y_fft));
title('Original Audio File');
ylabel('Amplitude');
xlabel('Sample Number');
sound(y, Fs);


if (pause_flag == 1);pause(3);end


%------------------------------ PF = 1 -- Pre Filter Used
if (per_filter_flag == 1)
    figure(2)
    set(gcf, 'Position', [200, 0, 1200, 800]);
    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=2 PF=1', 2, 1);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 1);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 2 - pf = 1');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/2);

    if (pause_flag == 1);pause(3);end
    
    y_interp_2(:, 1) = interp(y_downsampled(:, 1), 2);
    y_interp_2(:, 2) = interp(y_downsampled(:, 2), 2);
    subplot(2, 4, 2);
    plot(real(fft(y_interp_2)));
    title("Interpolated Signal N = 2 - PF = 1");
    


    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=4 PF=1', 4, 1);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 3);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 4- pf = 1');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/4);
    
    if (pause_flag == 1);pause(3);end

    y_interp_4(:, 1) = interp(y_downsampled(:, 1), 4);
    y_interp_4(:, 2) = interp(y_downsampled(:, 2), 4);
    subplot(2, 4, 4);
    plot(real(fft(y_interp_4)));
    title("Interpolated Signal N = 4 - PF = 1");
    
    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=6 PF=1', 6, 1);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 5);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 6 - pf = 1');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/6);

    y_interp_6(:, 1) = interp(y_downsampled(:, 1), 6);
    y_interp_6(:, 2) = interp(y_downsampled(:, 2), 6);
    subplot(2, 4, 6);
    plot(real(fft(y_interp_6)));
    title("Interpolated Signal N = 4 - PF = 1");
    
    if (pause_flag == 1);pause(3);end

    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=8 PF=1', 8, 1);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 7);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 8 - pf = 1');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/8);

    y_interp_8(:, 1) = interp(y_downsampled(:, 1), 8);
    y_interp_8(:, 2) = interp(y_downsampled(:, 2), 8);
    subplot(2, 4, 8);
    plot(real(fft(y_interp_8)));
    title("Interpolated Signal N = 8 - PF = 1");
    
    if (pause_flag == 1);pause(3);end
end
if (no_filter_flag == 1)
    figure(3)
    set(gcf, 'Position', [200, 0, 1200, 800]);
    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=2 PF=0', 2, 0);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 1);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 2 pf = 0');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/2);

    y_interp_2(:, 1) = interp(y_downsampled(:, 1), 2);
    y_interp_2(:, 2) = interp(y_downsampled(:, 2), 2);
    subplot(2, 4, 2);
    plot(real(fft(y_interp_2)));
    title("Interpolated Signal N = 2 - PF = 0");
    
    if (pause_flag == 1);pause(3);end

    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=4 PF=0', 4, 0);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 3);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 4- pf = 0');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/4);

    y_interp_4(:, 1) = interp(y_downsampled(:, 1), 4);
    y_interp_4(:, 2) = interp(y_downsampled(:, 2), 4);
    subplot(2, 4, 4);
    plot(real(fft(y_interp_4)));
    title("Interpolated Signal N = 4 - PF = 0");
    
    if (pause_flag == 1);pause(3);end


    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=6 PF=0', 6, 0);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 5);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 6 - pf = 0');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/6);

    y_interp_6(:, 1) = interp(y_downsampled(:, 1), 6);
    y_interp_6(:, 2) = interp(y_downsampled(:, 2), 6);
    subplot(2, 4, 6);
    plot(real(fft(y_interp_6)));
    title("Interpolated Signal N = 6 - PF = 0");
    
    if (pause_flag == 1);pause(3);end

    y_downsampled = DownSample('ELE725_lab1.wav', 'Downsample N=8 PF=0', 8, 0);
    y_downsampled_fft = fft(y_downsampled);
    subplot(2, 4, 7);
    plot(real(y_downsampled_fft));
    title('Downsampled N = 8 - pf = 0');
    ylabel('Amplitude');
    xlabel('Sample Number'); %Downsampled sounds more muted than the original
    sound(y_downsampled, Fs/8);
    
    y_interp_8(:, 1) = interp(y_downsampled(:, 1), 8);
    y_interp_8(:, 2) = interp(y_downsampled(:, 2), 8);
    subplot(2, 4, 8);
    plot(real(fft(y_interp_8)));
    title("Interpolated Signal N = 8 - PF = 0");
    
    if (pause_flag == 1);pause(3);end
    
end

if (uniform_quant_flag == 1)
    figure(4);
    y_uniform_quant_2 = UniformQuant('ELE725_lab1.wav', "Uniform Quant N = 2", 2);
    subplot(3, 1, 1);
    plot(y_uniform_quant_2);
    title('Uniform Quant - N = 2');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_uniform_quant_2, Fs);
    
    uniform_MSE_2 = sum((y_uniform_quant_2 - y).^2 )/length(y_uniform_quant_2);
    disp('Uniform MSE (N = 2) = ');
    disp(uniform_MSE_2);
    if (pause_flag == 1);pause(3);end
    
    y_uniform_quant_4 = UniformQuant('ELE725_lab1.wav', "Uniform Quant N = 4", 4);
    subplot(3, 1, 2);
    plot(y_uniform_quant_4);
    title('Uniform Quant - N = 4');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_uniform_quant_4, Fs);
    
    uniform_MSE_4 = sum((y_uniform_quant_4 - y).^2 )/length(y_uniform_quant_4);
    disp('Uniform MSE (N = 4) = ');
    disp(uniform_MSE_4);
    
    if (pause_flag == 1);pause(3);end
    
    y_uniform_quant_8 = UniformQuant('ELE725_lab1.wav', "Uniform Quant N = 8", 8);
    subplot(3, 1, 3);
    plot(y_uniform_quant_8);
    title('Uniform Quant - N = 8');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_uniform_quant_8, Fs);
    
    uniform_MSE_8 = sum((y_uniform_quant_8 - y).^2 )/length(y_uniform_quant_8);
    disp('Uniform MSE (N = 8) = ');
    disp(uniform_MSE_8);
    
    if (pause_flag == 1);pause(3);end
end

if (mulaw_flag == 1)
    figure(5);
    y_mulaw_2 = MulawQuant('ELE725_lab1.wav', "Mulaw Quant N = 2 Mu = 100", 2, 100);
    subplot(3, 1, 1);
    plot(y_mulaw_2);
    title('Mulaw Quant N = 2 || Mu = 100');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_mulaw_2, Fs);
    
    mulaw_MSE_2 = sum((y_mulaw_2 - y).^2 )/length(y_mulaw_2);
    disp('Mulaw MSE (N = 2) = ');
    disp(mulaw_MSE_2);
    
    if (pause_flag == 1);pause(3);end
    
    y_mulaw_4 = MulawQuant('ELE725_lab1.wav', "Mulaw Quant N = 4 Mu = 100", 4, 100);
    subplot(3, 1, 2);
    plot(y_mulaw_4);
    title('Mulaw Quant N = 4 || Mu = 100');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_mulaw_4, Fs);
    
    mulaw_MSE_4 = sum((y_mulaw_4 - y).^2 )/length(y_mulaw_4);
    disp('Mulaw MSE (N = 4) = ');
    disp(mulaw_MSE_4);
    
    if (pause_flag == 1);pause(3);end
    
    y_mulaw_8 = MulawQuant('ELE725_lab1.wav', "Mulaw Quant N = 8 Mu = 100", 8, 100);
    subplot(3, 1, 3);
    plot(y_mulaw_8);
    title('Mulaw Quant N = 8 || Mu = 100');
    ylabel('Amplitude');
    xlabel('Sample Number');
    sound (y_mulaw_8, Fs);
    
    mulaw_MSE_8 = sum((y_mulaw_8 - y).^2 )/length(y_mulaw_8);
    disp('Mulaw MSE (N = 8) = ');
    disp(mulaw_MSE_8);
    
end

figure(6);
hold on;
plot (y(1:200), 'LineWidth', 1);
plot (y_mulaw_8(1:200), 'LineWidth', 1);
plot (y_uniform_quant_8(1:200), 'LineWidth', 1);

title("Comparison between Quantization with N = 8");
legend('Original Signal', 'Mulaw', 'Uniform Quant');





