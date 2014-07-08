messages =
  en: 'hello'
  jp: 'こんにちは'
  de: 'hallo'

messageKeys = Object.keys messages

exports = module.exports = ->
  rand = Math.floor (Math.random() * messageKeys.length) + 1
  key = messageKeys[rand - 1]

  lang: key
  message: messages[key]
