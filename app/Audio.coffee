module.exports = () ->
  audio = document.getElementById("audio")
  context = new (window.audioContext||window.webkitAudioContext)()

  source = context.createMediaElementSource(audio)
  @analyser = context.createAnalyser()
  @array = new Uint8Array(@analyser.frequencyBinCount)
  @analyser.fftSize = 2048;

  source.connect(@analyser)
  @analyser.connect(context.destination)

  @analyse = () ->
    @analyser.getByteFrequencyData(@array)

  return

