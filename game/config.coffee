screen =
  width: if navigator.isCocoonJS then window.innerWidth else 480
  height: if navigator.isCocoonJS then window.innerHeight else 320

game =
  width: 480
  height: 320

scale =
  x: screen.width / game.width
  y: screen.height / game.height

module.exports = {screen, game, scale}
