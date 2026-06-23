extends Node

enum BattleStates { START, PLAYER_TURN, ENEMY_TURN, ACTION_EXECUTION, ACTION_END, WIN, LOSE }
var current_state: BattleStates = BattleStates.START
