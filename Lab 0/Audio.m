[y, Fs] = audioread('ELE725_audio.wav');
%sound(y, Fs); %Music Played
%sound(y, Fs/2); %Music Played lower pitch

audiowrite('ELE725_audio_modified.wav', y, Fs, 'BitsPerSample', 8);
[y, Fs] = audioread('ELE725_audio_modified.wav');
sound(y, Fs);

