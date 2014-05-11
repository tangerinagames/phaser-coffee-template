Flame = require './flame'

class SpaceShip extends Phaser.Sprite

  ROTATION_SPEED: 100
  ACCELERATION: 1000
  MAX_SPEED: 500

  constructor: (game) ->
    super game, game.world.centerX, game.world.centerY, 'ship'
    @game.add.existing @

    # animation
    @boost = @animations.add 'boost', Phaser.Math.numberArray(0, 7), 20, false

    # physics
    @game.physics.p2.enable @
    @body.clearShapes()
    @body.loadPolygon 'bodies', 'ship'

    # flames
    @createFlames()

    # input
    @cursors = @game.input.keyboard.createCursorKeys()


  update: ->
    # check the input
    if @cursors.left.isDown
      @body.rotateLeft SpaceShip::ROTATION_SPEED

    else if @cursors.right.isDown
      @body.rotateRight SpaceShip::ROTATION_SPEED

    else
      @body.setZeroRotation()

    if @cursors.up.isDown
      @body.thrust SpaceShip::ACCELERATION
      @animations.play 'boost' unless @boost.isPlaying or @boost.isFinished
      @flames.visible = true

    else
      @body.thrust 0
      @frame = 0
      @boost.restart()
      @flames.visible = false

    # limit movement speed
    @limitSpeed()


  createFlames: ->
    @flames = @game.add.group()
    collisionGroup = @game.physics.p2.createCollisionGroup()

    @flame1 = new Flame(@game, @flames, collisionGroup)
    @game.physics.p2.createLockConstraint @, @flame1, [7.5, -20]

    @flame2 = new Flame(@game, @flames, collisionGroup)
    @game.physics.p2.createLockConstraint @, @flame2, [-7.5, -20]


  limitSpeed: ->
    maxSpeed = @game.physics.p2.pxm SpaceShip::MAX_SPEED
    x = @body.velocity.x
    y = @body.velocity.y
    if Math.pow(x, 2) + Math.pow(y, 2) > Math.pow(maxSpeed, 2)
      a = Math.atan2(y, x)
      x = @game.physics.p2.mpxi Math.cos(a) * maxSpeed
      y = @game.physics.p2.mpxi Math.sin(a) * maxSpeed
      @body.velocity.x = x
      @body.velocity.y = y


module.exports = SpaceShip
