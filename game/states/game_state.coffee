class GameState extends Phaser.State

  preload: ->
    @game.load.image 'logo', 'assets/images/phaser-logo-small.png'

  create: ->
    @game.scale.pageAlignHorizontally = true
    @game.scale.pageAlignVertically = true
    @game.scale.refresh()

    @logo = @game.add.sprite @game.world.centerX, @game.world.centerY, 'logo'
    @logo.anchor.setTo .5, .5

  update: ->
    @logo.angle += 1

module.exports = GameState
