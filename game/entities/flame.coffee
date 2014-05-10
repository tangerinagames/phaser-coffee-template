class Flame extends Phaser.Sprite

  constructor: (game, group, collisionGroup) ->
    super game, game.world.centerX, game.world.centerY, 'flame'
    @anchor.setTo .5, 0
    group.add @

    # animations
    @animations.add 'boost', [0, 1, 2, 3, 2, 1, 0], 40, true
    @animations.play 'boost'

    # physics
    @game.physics.p2.enable @
    @body.setCollisionGroup collisionGroup


module.exports = Flame
