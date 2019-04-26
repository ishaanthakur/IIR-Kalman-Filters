% remove whistle

clc
clear all
close all

%% 1) Perform frequency analysis of the whistle...
[whistle, fs] = wavread('whistle.wav');
toofast_toofourier(whistle, fs);

% Here we can see it has a main harmonic at about 1832 Hz and a third
% harmonic at about 5497 Hz. Design a notch filter for the main harmonic. Try
% filtering the third harmonic as well if you want.

%% 2) Perform frequency analysis of the song recording...
load recording.mat % y: two-channel audio, fs: sampling frequency

% p = audioplayer(y, fs);
% play(p, fs);

% The spectrum before filtering...
% Notice the prominent spectral feature due to the main harmonic of the
% whistle. We definitely want to filter that one out with a notch filter.

%toofast_toofourier(y, fs);

% The closer to r = 1, the sharper the notch. Any r less than about 0.7
% doesn't really have a desirable frequency response. For r = 0.99, we have
% a pretty good band reject with minimal amplification at other
% frequencies. For 0.99 < r < 0.9999... you might miss the frequency that
% you are trying to cancel... 
% I found any r between 0.8 and 0.99 works pretty well. Anything less
% than that starts attenuating too much other frequency content, especially
% DC.


%% 3) Choose a filter and filter the audio...
r = 0.90;
w = 2*pi*1834/fs;

% Filtering with the first notch filter here...
[a, b, filtered(:,1)] = my_notch(r, w, y(:,1));
[a, b, filtered(:,2)] = my_notch(r, w, y(:,2));

% The spectrum after filtering...
% The annoying spectral feature is gone with "minimal" change in the rest
% of the spectrum.

%toofast_toofourier(filtered, fs);

% pz map and frequency response of the notch filter used
figure()
W = linspace(-pi, pi, 512);
H = freqz(b, a, W);

subplot(1, 2, 1),
hold on
zplane(b, a)
grid
title('Pole-zero Map')
axis([-1.1 1.1 -1.1 1.1])
axis square

subplot(1, 2, 2),
plot(W, abs(H))
title('Frequency Response of Notch Filter')
xlabel('\omega [rad/sample]')
ylabel('|H(\omega)|')
grid
axis square

% Filtering with the second notch filter here...
% This theoretically may improve the whistle cancellation. But
% subjectively, results may vary.

[a, b, filtered(:,1)] = my_notch(r, 3*w, filtered(:,1));
[a, b, filtered(:,2)] = my_notch(r, 3*w, filtered(:,2));

%% 4) Play back the sound...
p = audioplayer(filtered, fs);
play(p, fs);