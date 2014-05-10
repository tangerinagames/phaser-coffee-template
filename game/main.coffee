config = require './config'
GameState = require './states/game_state'

game = new Phaser.Game config.screen.width, config.screen.height, Phaser.AUTO, 'game'
game.state.add('game', new GameState, true)
