module.exports = () ->
  audio = document.getElementById("audio")
  context = new (window.audioContext||window.webkitAudioContext)()

  source = context.createMediaElementSource(audio)
  @analyser = context.createAnalyser()
  @analyser.fftSize = 2048;
  @freqArray = new Uint8Array(@analyser.frequencyBinCount)
  @avg=0

  @analyser.smoothingTimeConstant = 0.5;

  source.connect(@analyser)
  @analyser.connect(context.destination)

  @analyse = () ->
    @analyser.getByteFrequencyData(@freqArray)
    @avg = 0
    for val in @freqArray
      @avg += val
    @avg /= @analyser.frequencyBinCount

  log2 = Math.log(2)

  @getFrequency = (f1,f2) ->
    # Gets the log-scaled frequency data from the frequency array.
    # f1 and f2 should be between 0 and 1.
    leftIndex = Math.max(0, Math.floor(@analyser.frequencyBinCount * Math.log(f1+1)/log2))
    rightIndex = Math.min(@analyser.frequencyBinCount-1, Math.floor(@analyser.frequencyBinCount * Math.log(f2+1)/log2))
    sum = 0
    for i in [leftIndex..rightIndex]
      sum = Math.max(sum, @freqArray[i])
    return sum

  return
