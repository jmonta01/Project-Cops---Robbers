package com.montydigital.CopsAndRobbers.ui.gamePlay{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.ui.common.AudioBtn;
	import com.montydigital.CopsAndRobbers.ui.common.MenuBtn;
	import com.montydigital.CopsAndRobbers.ui.common.RestartBtn;
	import com.montydigital.CopsAndRobbers.ui.startMenu.PlayBtn;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class PauseScreen extends StSprite{
		
		public static const PLAY_EVENT:String = "playEvent";
		public static const RESTART_EVENT:String = "restartEvent";
		public static const MENU_EVENT:String = "menuEvent";
		public static const AUDIO_EVENT:String = "audioEvent";
		
		
		private var bkg:StImage;
		private var playBtn:PlayBtn;
		
		private var btnContainer:StSprite;
		private var restartBtn:RestartBtn;
		private var menuBtn:MenuBtn;
		private var audioBtn:AudioBtn;
		
		public function PauseScreen(){
			super();
			bkg = StImage.fromBitmap(new UIAssets.LevelEndbackground());
			bkg.scaleX = bkg.scaleY = .75;
			this.addChild(bkg);
			
			playBtn = new PlayBtn();
			playBtn.x = this.width/2 - playBtn.width/2;
			playBtn.y = this.height/2 - playBtn.height/2;
			playBtn.touchable = true;
			playBtn.addEventListener(StTouchEvent.TOUCH, handlePlayClick);
			this.addChild(playBtn);
			
			btnContainer = new StSprite();			
			this.addChild(btnContainer);

			restartBtn = new RestartBtn();
			restartBtn.addEventListener(StTouchEvent.TOUCH, handleRestartClick);
			btnContainer.addChild(restartBtn);
			
			menuBtn = new MenuBtn();
			menuBtn.x = restartBtn.x + restartBtn.width + 40;
			menuBtn.addEventListener(StTouchEvent.TOUCH, handleMenuClick);
			btnContainer.addChild(menuBtn);
			
			audioBtn = new AudioBtn(); 
			audioBtn.x = menuBtn.x + menuBtn.width + 40;
			audioBtn.addEventListener(StTouchEvent.TOUCH, handleAudioClick);
			btnContainer.addChild(audioBtn);
			
			btnContainer.x = bkg.x+bkg.width/2 - btnContainer.width/2;
			btnContainer.y = bkg.y + bkg.height - btnContainer.height -  20;

		}
		
		private function handlePlayClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(playBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(PLAY_EVENT));
			}
		}		
		private function handleRestartClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(restartBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(RESTART_EVENT));
			}
		}
		
		private function handleMenuClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(menuBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(MENU_EVENT));
			}
		}
		
		private function handleAudioClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(audioBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(AUDIO_EVENT));
			}
		}

	}
}