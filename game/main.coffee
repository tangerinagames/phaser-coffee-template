config = require './config'
GameState = require './states/game_state'

# initialize the game
game = new Phaser.Game config.screen.width, config.screen.height, Phaser.AUTO, 'game'

# states
game.state.add('game', new GameState, true)
