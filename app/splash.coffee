possibilites =
  myself: [
    "developer"
    "designer"
    "student"
    "innovator"
    "artist"
    "musician"
    "dreamer"
    "learner"
    "inventor"
    "thinker"
  ]
  myprojects: [
    "codes"
    "designs"
    "writes"
    "dreams up"
    "dreams about"
    "composes"
    "realizes"
    "imagines"
    "reimagines"
    "rewrites"
    "redesigns"
    "discovers"
    "rediscovers"
    "develops"
    "sketches"

  ]
  myprojectadjective: [
    "interactive"
    "novel"
    "digital"
    "sensational"
    "inspirational"
    "immersive"
    "surreal"
    "creative"
    "concept"
    "conceptual"
    "experimental"
    "abstract"
  ]
  myprojectnoun: [
    "experiences"
    "games"
    "music"
    "websites"
    "worlds"
    "interfaces"
    "prototypes"
  ]

selectRandom = (array)->
  return array[Math.floor(array.length*Math.random())]

lastUpdated = ""
updateElementTimeout = 0

allClasses = ["myself", "myprojects", "myproject"]
randomUpdateElement = ()->
  randomclass = selectRandom(allClasses)
  if randomclass is lastUpdated
    randomUpdateElement()
  else
    lastUpdated = randomclass
    updateElement(randomclass)

updateElement = (elementclass)->
  clearTimeout(updateElementTimeout)
  candidates = switch elementclass
    when "myself" then possibilites.myself
    when "myprojects" then possibilites.myprojects
    when "myproject" then possibilites.myprojectnoun
  newText = selectRandom(candidates)
  # Add some flair
  if elementclass is "myproject"
    newText = selectRandom(possibilites.myprojectadjective) + " " + newText
  # No repeats, please
  element = $("#splash .#{elementclass}")
  if element.text() is newText
    updateElement(elementclass)
    return
  # Be smart about vowels
  needsFixing = if elementclass is "myself" then (if newText[0] in "aeoui" then "is&nbsp;an" else "is&nbsp;a") else true
  replaceText(element, newText, needsFixing)
  updateElementTimeout = setTimeout ()->
    randomUpdateElement()
  , Math.random()*5000+3000

# Replaces text in an animated, recursive fashion.
# Deletes the existing word while deletingNeeded isn't false.
# If deletingNeeded is the string "is a" or "is an",
# it sets the text accordingly, before making it false.
replaceText = (element, text, deletingNeeded)->
  clearTimeout(element[0].timeout)
  currentText = element.text()
  if deletingNeeded isnt false
    if currentText.length > 0
      element.text(currentText[..-2])
      element[0].timeout = setTimeout ()->
        replaceText(element, text, deletingNeeded)
      , 60 + Math.random()*20
    else
      element[0].timeout = setTimeout ()->
        # Fix is a(n)
        if deletingNeeded isnt true
          $("#splash .is").html(deletingNeeded)
        element[0].timeout = setTimeout ()->
          replaceText(element, text, false)
        , 100 + Math.random()*50
      , 300 + Math.random()*300
      # Done deleting
  else if text.length > 0
    element.text(currentText+text[0])
    element[0].timeout = setTimeout ()->
      replaceText(element, text[1..], false)
    , 100 + Math.random()*50

setTimeout ()->
  randomUpdateElement()
, 3000

$(".myself, .myprojects, .myproject").on "click", ()->
  for elementclass in allClasses
    if $(this).hasClass(elementclass)
      lastUpdated = elementclass
      updateElement(elementclass)
      break
