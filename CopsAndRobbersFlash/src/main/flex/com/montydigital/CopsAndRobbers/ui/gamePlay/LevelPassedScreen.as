package com.montydigital.CopsAndRobbers.ui.gamePlay{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.ui.common.MenuBtn;
	import com.montydigital.CopsAndRobbers.ui.common.NextLevelBtn;
	import com.montydigital.CopsAndRobbers.ui.common.RestartBtn;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class LevelPassedScreen extends StSprite{
		
		public static const RESTART_EVENT:String = "restartEvent";
		public static const MENU_EVENT:String = "menuEvent";
		public static const NEXT_EVENT:String = "nextEvent";
		
		
		private var bkg:StImage;
		
		private var btnContainer:StSprite;
		private var restartBtn:RestartBtn;
		private var menuBtn:MenuBtn;
		private var nextBtn:NextLevelBtn;

		
		public function LevelPassedScreen(){
			super();
			bkg = StImage.fromBitmap(new UIAssets.LevelEndbackground());
			bkg.scaleX = bkg.scaleY = .75;
			this.addChild(bkg);
			
			btnContainer = new StSprite();			
			this.addChild(btnContainer);
			
			restartBtn = new RestartBtn();
			restartBtn.addEventListener(StTouchEvent.TOUCH, handleRestartClick);
			btnContainer.addChild(restartBtn);
			
			menuBtn = new MenuBtn();
			menuBtn.x = restartBtn.x + restartBtn.width + 40;
			menuBtn.addEventListener(StTouchEvent.TOUCH, handleMenuClick);
			btnContainer.addChild(menuBtn);
			
			nextBtn = new NextLevelBtn();
			nextBtn.x = menuBtn.x + menuBtn.width + 40;
			nextBtn.addEventListener(StTouchEvent.TOUCH, handleNextClick);
			btnContainer.addChild(nextBtn);
			
			btnContainer.x = bkg.x+bkg.width/2 - btnContainer.width/2;
			btnContainer.y = bkg.y + bkg.height - btnContainer.height -  20;

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
		
		private function handleNextClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(nextBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(NEXT_EVENT));
			}
		}

	}
}