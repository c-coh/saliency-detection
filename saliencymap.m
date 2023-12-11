% read and format image
im = 'images/horsies.jfif';
Image = im2double(im2gray(imresize(imread(im), [256, NaN])));
spectra(im);

% fourier transform
Fourier = fftshift(fft2(Image));
Phase = angle(Fourier);
LogFourier = log(abs(Fourier));

%approximate average
Convolved = conv2(LogFourier, 1/9*ones(3));
[w, h] = size(Convolved);
Residual = LogFourier - Convolved(2:w-1, 2:h-1);

%calculate spectral residual
SaliencyMap = abs(ifft2(exp((Residual + 1i*Phase)))).^2;
[w, h] = size(SaliencyMap);
SaliencyMap = mat2gray(SaliencyMap);

% postprocessing
SaliencyMap = imadjust(imgaussfilt(SaliencyMap(10:end - 10, 10: end-10), 6));
Avg = mean(SaliencyMap, "all")*2;

%SaliencyMap = SaliencyMap > Avg;
Final = floor(SaliencyMap + Avg);
Final = ceil(Final);
figure
imshow(SaliencyMap)
figure
imshow(Final)
