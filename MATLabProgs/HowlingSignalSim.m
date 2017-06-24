
fileName = 'speech_dft.mp3';
nPlayTimes = 5;
fileReader = dsp.AudioFileReader(fileName, 'PlayCount', nPlayTimes);
fileInfo = audioinfo(fileName);

deviceWriter = audioDeviceWriter( 'SampleRate', fileInfo.SampleRate);
setup(deviceWriter, zeros(fileReader.SamplesPerFrame, fileInfo.NumChannels));

frameSize = 1024;
nFrames = 111*nPlayTimes;
signalFrameMtx = zeros(frameSize, nFrames);

% Original voice signal from mp3 file
count  = 1;
while ~isDone(fileReader)
    audioData = fileReader();
    signalFrameMtx(:, count) = audioData;
%     deviceWriter( audioData );
    count = count + 1;
end

% DrawWaveForm( signalFrameMtx, fileInfo.SampleRate );
outMtx = zeros( frameSize, nFrames+1 );
NoiseMtx = (rand(frameSize, nFrames)-0.5).*2e-3;    % whitenoise ~ (-1e-3,1e-3)
% simulation for amplifier
AmpFactor = 10; % 30~68.02dB; 10~20dB
OutCeiling = 50; % maxium output amplitude
currData = zeros( frameSize, 1);
DumpingFactor = 0.097;
for i = 1 : nFrames
    outData = AmpFactor .* (signalFrameMtx(:, i)+NoiseMtx(:, i)+currData.*DumpingFactor);
    idx = find(abs(outData) >OutCeiling);
    outData(idx) = sign(outData(idx)).*OutCeiling;
    currData = outData;
    outMtx(:, i+1) = outData;
    %     deviceWriter( outData );
end

DrawWaveForm( outMtx, fileInfo.SampleRate );

% % Play the result
% for i = 1 : nFrames
%     deviceWriter( outMtx(:, i) )
% end

release(fileReader);
release(deviceWriter);