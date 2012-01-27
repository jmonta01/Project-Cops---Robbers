package com.montydigital.CopsAndRobbers.ui.gamePlay{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.ui.startMenu.PlayBtn;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class PauseScreen extends StSprite{
		
		public static const PLAY_EVENT:String = "playEvent";
		
		
		private var playBtn:PlayBtn;
		
		public function PauseScreen(){
			super();
			playBtn = new PlayBtn();
			playBtn.touchable = true;
			playBtn.addEventListener(StTouchEvent.TOUCH, handleSaveClick);
			this.addChild(playBtn);
		}
		
		private function handleSaveClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(playBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(PLAY_EVENT));
			}
		}
	}
}