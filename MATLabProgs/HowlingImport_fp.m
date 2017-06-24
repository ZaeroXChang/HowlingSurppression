% -- fixed point version -- %
clear all

clc

fileName = '..\HowlingAudioSamples\HowlingSample.m4a';
% nPlayTimes = 1;

% fileReader.member => Filename, PlayCount(1), SampleRate, SamplesPerFrame(1024), OutputDataType(double:int16|uint8)
% fileReader = dsp.AudioFileReader(fileName, 'PlayCount', nPlayTimes);
% fileReader = dsp.AudioFileReader(fileName); % default import func
fileReader = dsp.AudioFileReader(fileName, 'OutputDataType', 'int16'); 

%fileInfo.member => Filename, CompressionMethod, SampleRate, TotalSamples, Duration, Title, Comment, Artist, BitRate
fileInfo = audioinfo(fileName);

deviceWriter = audioDeviceWriter( 'SampleRate', fileInfo.SampleRate);
setup(deviceWriter, zeros(fileReader.SamplesPerFrame, fileInfo.NumChannels));

% frameSize = 1024;
frameSize = fileReader.SamplesPerFrame;
nFrames = ceil(fileInfo.TotalSamples/frameSize);
signalFrameMtx = zeros(frameSize, nFrames);

% Original voice signal from mp3 file
count  = 1;
while ~isDone(fileReader)
    audioData = fileReader();
    signalFrameMtx(:, count) = audioData;
%     deviceWriter( audioData );
    count = count + 1;
end

save HSpl_fp.mat 

% DrawWaveForm( signalFrameMtx, fileInfo.SampleRate )