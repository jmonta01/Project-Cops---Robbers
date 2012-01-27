package com.montydigital.CopsAndRobbers.core
{
	import com.montydigital.CopsAndRobbers.core.gamePlay.Game;
	import com.montydigital.CopsAndRobbers.ui.common.PauseBtn;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.PauseScreen;
	import com.montydigital.gameEngine.core.system.ISystem;
	
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class CnR_GamePlay extends StSprite implements ISystem
	{
		
		public static const LEVEL_PLAY_BASE:String = "levelPlayBase";
//		public static const LEVEL_PLAY_PAUSE:String = "levelPlayPause";
//		public static const LEVEL_PLAY_SUCCESS:String = "levelPlaySuccess";
//		public static const LEVEL_PLAY_FAIL:String = "levelPlayFail";
		
		private var gameRoot:CnR_GameRoot;
		private var game:Game;
		private var pauseBtn:PauseBtn;
		private var pauseScreen:PauseScreen
		
		
		public function CnR_GamePlay(root:CnR_GameRoot){
			gameRoot = root;
			
			game = new Game();
			
			pauseBtn = new PauseBtn();
			pauseBtn.x = 20;
			pauseBtn.y = this.gameRoot.stage.stageHeight - pauseBtn.height - 20;
			pauseBtn.touchable = true;
			pauseBtn.addEventListener(StTouchEvent.TOUCH, handlePauseBtn);
			
			pauseScreen = new PauseScreen();
			pauseScreen.x = this.gameRoot.stage.stageWidth/2 - pauseScreen.width/2;
			pauseScreen.y = this.gameRoot.stage.stageHeight/2 - pauseScreen.height/2;
			pauseScreen.addEventListener(PauseScreen.PLAY_EVENT, handlePlayBtn);
		}
		
		public function enter():void{
			gameRoot.addChild(this);
			game.loadLevel(gameRoot.selectedCity, gameRoot.selectedLevel);
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
	}
}