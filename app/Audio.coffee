module.exports = () ->
  audio = document.getElementById("audio")
  context = new (window.audioContext||window.webkitAudioContext)()

  source = context.createMediaElementSource(audio)
  @analyser = context.createAnalyser()
  @freqArray = new Uint8Array(@analyser.frequencyBinCount)
  @timeArray = new Uint8Array(@analyser.frequencyBinCount)
  @avg=0
  @lastAvg=0

  @analyser.fftSize = 2048;
  @analyser.smoothingTimeConstant = 0.9;

  source.connect(@analyser)
  @analyser.connect(context.destination)

  @analyse = () ->
    @analyser.getByteFrequencyData(@freqArray)
    @analyser.getByteTimeDomainData(@timeArray)
    @lastAvg = @avg
    @avg = 0
    for val in @timeArray
      @avg += Math.abs(128-val)
    @avg /= @analyser.frequencyBinCount
  return

