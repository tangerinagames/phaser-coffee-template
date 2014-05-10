screen =
  width: if navigator.isCocoonJS then window.innerWidth else 960
  height: if navigator.isCocoonJS then window.innerHeight else 640

game =
  width: 960
  height: 640

scale =
  x: screen.width / game.width
  y: screen.height / game.height

module.exports = {screen, game, scale}
