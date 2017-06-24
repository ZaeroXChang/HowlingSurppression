function DrawWaveForm ( Data, Fs )
    outData = reshape(Data, size(Data,1)*size(Data,2), 1);
    t_arr = [1:1:size(Data,1)*size(Data,2)] ./ Fs .* 1000;
    
    figure, plot( t_arr, outData)
    xlabel( ' t / ms' )
    ylabel(' Amplitude / a.u. ')
    
    f_arr = linspace(0,  Fs / 2, length(t_arr)/2) ./ 1e3;
    SpectrumData = fft ( outData );
    
    figure, plot( f_arr, abs(SpectrumData(1:length(f_arr))))
    xlabel( ' freq / kHz' )
    ylabel( ' Freq Amp / a.u. ' )
end