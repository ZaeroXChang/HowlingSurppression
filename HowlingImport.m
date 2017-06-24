fileName = '..\HowlingAudioSamples\HowlingSample.m4a';
nPlayTimes = 1;
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

DrawWaveForm( signalFrameMtx, fileInfo.SampleRate )