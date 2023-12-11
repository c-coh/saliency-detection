function spectra(im)
    Image= im2double(im2gray(imresize(imread(im), [512, 512])));
    [w, h] = size(Image);
    Nyq = w/2;
    
    %compute the 2d transform
    spectrum=fftshift(fft2(Image));
    spectrum=abs(spectrum).^2;
    
    %compute the frequencies
    freqs=0:Nyq/2;
    
    %compute the rotational average
    Fourier=rotavg(spectrum, Nyq/2, w/2, h/2);
    disp(length(freqs))
    disp(length(Fourier))
    
    semilogy(freqs,Fourier)
    title('log plot')
    xlabel('frequency') 
    ylabel('intensity') 
end
