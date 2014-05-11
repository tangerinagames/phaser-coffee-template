SpaceShip = require '../entities/spaceship'


class GameState extends Phaser.State

  preload: ->
    @game.load.image 'background', 'assets/images/background1.png'
    @game.load.spritesheet 'ship', 'assets/images/spaceship.png', 56, 56
    @game.load.spritesheet 'flame', 'assets/images/flame.png', 8, 16
    @game.load.physics 'bodies', 'assets/physics/bodies.json'

  create: ->
    @game.world.setBounds 0, 0, 1920, 1280
    @game.physics.startSystem Phaser.Physics.P2JS

    @background = @game.add.sprite 0, 0, 'background'
    @background.scale.setTo 2, 2

    @ship = new SpaceShip @game
    @game.camera.follow @ship

    @game.input.keyboard.addKeyCapture [
      Phaser.Keyboard.LEFT,
      Phaser.Keyboard.RIGHT,
      Phaser.Keyboard.UP,
      Phaser.Keyboard.DOWN
    ]


module.exports = GameState
