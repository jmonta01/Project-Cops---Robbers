package com.montydigital.CopsAndRobbers.ui.gamePlay{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.engine.gamePlay.Game;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.hud.HighScoreDisplay;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.hud.LevelScoreDisplay;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.hud.RoundsDisplay;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.hud.TimerDisplay;
	
	import starling.display.StSprite;
	import starling.text.StTextField;
	
	public class Hud extends StSprite{
		
		private var gameState:GameState;
		
		private var levelScoreDisplay:LevelScoreDisplay;
		private var highScoreDisplay:HighScoreDisplay;
		private var roundsDisplay:RoundsDisplay;
		private var timerDisplay:TimerDisplay;

		
		public function Hud(gameState:GameState){
			super();
			this.gameState = gameState;
			this.gameState.signal.add(handleGameStateChange);
			
			levelScoreDisplay = new LevelScoreDisplay();
			levelScoreDisplay.x = 20;
			levelScoreDisplay.y = 20;
			this.addChild(levelScoreDisplay);
			
			highScoreDisplay = new HighScoreDisplay();
			highScoreDisplay.x = Game.stageWidth - highScoreDisplay.width - 20;
			highScoreDisplay.y = 20;
			this.addChild(highScoreDisplay);
			
			roundsDisplay = new RoundsDisplay();
			roundsDisplay.x = 20;
			roundsDisplay.y = Game.stageHeight - roundsDisplay.height - 20;
			this.addChild(roundsDisplay);
			
			timerDisplay = new TimerDisplay();
			timerDisplay.x = Game.stageWidth - timerDisplay.width - 20;
			timerDisplay.y = Game.stageHeight - timerDisplay.height - 20;
			this.addChild(timerDisplay);
		}
		
		private function handleGameStateChange():void{
			levelScoreDisplay.update(gameState.score);
			timerDisplay.update(gameState.maxTime, gameState.time);
			roundsDisplay.update(gameState.roundsInClip);
		}

	}
}