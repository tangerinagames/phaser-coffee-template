SpaceShip = require '../entities/spaceship'


class GameState extends Phaser.State

  preload: ->
    @game.load.spritesheet 'ship', 'assets/images/spaceship.png', 84, 84
    @game.load.spritesheet 'flame', 'assets/images/flame.png', 11, 24
    @game.load.physics 'bodies', 'assets/physics/bodies.json'


  create: ->
    @game.stage.backgroundColor = 0x333333
    @game.physics.startSystem Phaser.Physics.P2JS

    @ship = new SpaceShip @game

    @game.input.keyboard.addKeyCapture [
      Phaser.Keyboard.LEFT,
      Phaser.Keyboard.RIGHT,
      Phaser.Keyboard.UP,
      Phaser.Keyboard.DOWN
    ]


module.exports = GameState
