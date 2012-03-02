package com.montydigital.CopsAndRobbers.engine
{
	import com.montydigital.CopsAndRobbers.engine.gamePlay.Game;
	import com.montydigital.CopsAndRobbers.data.GameStateData;
	import com.montydigital.CopsAndRobbers.events.levelEnded.LevelEndedEvent;
	import com.montydigital.CopsAndRobbers.ui.common.PauseBtn;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.LevelFailScreen;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.LevelPassedScreen;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.PauseScreen;
	import com.montydigital.gameEngine.fsm.system.ISystem;
	
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class CnR_GamePlay extends StSprite implements ISystem
	{
		
		public static const LEVEL_PLAY_BASE:String = "levelPlayBase";
		
		private var gameRoot:CnR_GameRoot;
		private var game:Game;
		private var pauseBtn:PauseBtn;
		private var pauseScreen:PauseScreen
		private var levelFailScreen:LevelFailScreen;
		private var levelPassScreen:LevelPassedScreen;
		
		public function CnR_GamePlay(root:CnR_GameRoot){
			gameRoot = root;
			
			game = new Game();
			game.addEventListener(LevelEndedEvent.FAILED, handleLevelEnded);
			game.addEventListener(LevelEndedEvent.PASSED, handleLevelEnded);
			
			pauseBtn = new PauseBtn();
			pauseBtn.x = 20;
			pauseBtn.y = this.gameRoot.stage.stageHeight - pauseBtn.height - 20;
			pauseBtn.touchable = true;
			pauseBtn.addEventListener(StTouchEvent.TOUCH, handlePauseBtn);
			
			pauseScreen = new PauseScreen();
			pauseScreen.x = this.gameRoot.stage.stageWidth/2 - pauseScreen.width/2;
			pauseScreen.y = this.gameRoot.stage.stageHeight/2 - pauseScreen.height/2;
			pauseScreen.addEventListener(PauseScreen.PLAY_EVENT, handlePlayBtn);
			pauseScreen.addEventListener(PauseScreen.RESTART_EVENT, handleRestart);
			pauseScreen.addEventListener(PauseScreen.MENU_EVENT, handleMenu);
			pauseScreen.addEventListener(PauseScreen.AUDIO_EVENT, handleAudio);
			
			levelFailScreen = new LevelFailScreen();
			levelFailScreen.x = this.gameRoot.stage.stageWidth/2 - levelFailScreen.width/2;
			levelFailScreen.y = this.gameRoot.stage.stageHeight/2 - levelFailScreen.height/2;
			levelFailScreen.addEventListener(LevelFailScreen.RESTART_EVENT, handleRestart);
			levelFailScreen.addEventListener(LevelFailScreen.MENU_EVENT, handleMenu);
			levelFailScreen.addEventListener(LevelFailScreen.AUDIO_EVENT, handleAudio);
			
			levelPassScreen = new LevelPassedScreen();
			levelPassScreen.x = this.gameRoot.stage.stageWidth/2 - levelPassScreen.width/2;
			levelPassScreen.y = this.gameRoot.stage.stageHeight/2 - levelPassScreen.height/2;
			levelPassScreen.addEventListener(LevelPassedScreen.RESTART_EVENT, handleRestart);
			levelPassScreen.addEventListener(LevelPassedScreen.MENU_EVENT, handleMenu);
			levelPassScreen.addEventListener(LevelPassedScreen.NEXT_EVENT, handleNextLevel);
		}
		
		public function enter():void{
			gameRoot.addChild(this);
			game.loadLevel(GameStateData.selectedCity, GameStateData.selectedLevel);
			this.addChild(game);
			this.addChild(pauseBtn);
		}
		
		public function update():void{
			game.update();
		}
		
		public function exit():void{
			gameRoot.removeChild(this);
			this.removeChild(game);
			game.clearLevel();
			this.removeChild(pauseBtn);
			this.removeChild(levelFailScreen);
			this.removeChild(levelPassScreen);
		}
		
		private function handleLevelEnded(e:LevelEndedEvent):void{
			this.removeChild(pauseBtn);
			if(e.type == LevelEndedEvent.FAILED){
				this.addChild(levelFailScreen);
			}else{
				this.addChild(levelPassScreen);
			}
		}		
		
		private function togglePause():void{
			game.togglePause();
			if(game.isPaused()){
				this.removeChild(pauseBtn);
				this.addChild(pauseScreen);
			}else{
				this.addChild(pauseBtn);
				this.removeChild(pauseScreen);
			}
		}
		
		
		private function handlePlayBtn(e:StEvent):void{
			togglePause();
		}
		
		
		private function handlePauseBtn(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(pauseBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				togglePause();
			}
		}
		
		private function handleRestart(e:StEvent):void{
			if(game.isPaused()){
				togglePause();
			}
			this.addChild(pauseBtn);
			this.removeChild(levelFailScreen);
			this.removeChild(levelPassScreen);
			game.restartLevel(GameStateData.selectedCity, GameStateData.selectedLevel);
		}
		
		private function handleNextLevel(e:StEvent):void{
			if(game.isPaused()){
				togglePause();
			}
			this.addChild(pauseBtn);
			this.removeChild(levelFailScreen);
			this.removeChild(levelPassScreen);
			GameStateData.advanceToNextLevel();
			game.restartLevel(GameStateData.selectedCity, GameStateData.selectedLevel);
		}
		
		private function handleMenu(e:StEvent):void{
			if(game.isPaused()){
				togglePause();
			}
			gameRoot.gameFSM.setState(CnR_LevelSelect.LEVEL_SELECT_MAP);
		}
		
		private function handleAudio(e:StEvent):void{
			GameStateData.mute = !GameStateData.mute
		}
	}
}