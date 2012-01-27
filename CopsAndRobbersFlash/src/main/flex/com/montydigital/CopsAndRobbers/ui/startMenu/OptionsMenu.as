package com.montydigital.CopsAndRobbers.ui.startMenu{
	
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.ui.common.PillBtn;
	
	import flash.events.Event;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class OptionsMenu extends StSprite{
		
		public static const CLOSE_EVENT:String = "closeEvent";
		
		private var saveBtn:PillBtn;
		private var cancelBtn:PillBtn;
		
		public function OptionsMenu(){
			super();
			var bkg:StImage = StImage.fromBitmap(new UIAssets.OptionsMenuBackground());
			this.addChild(bkg);
			
			saveBtn = new PillBtn(new UIAssets.SaveBtn());
			saveBtn.x = 20;
			saveBtn.y = bkg.height - saveBtn.height - 20;
			saveBtn.touchable = true;
			saveBtn.addEventListener(StTouchEvent.TOUCH, handleSaveClick);
			this.addChild(saveBtn);
			
			cancelBtn = new PillBtn(new UIAssets.CancelBtn());
			cancelBtn.x = bkg.width - cancelBtn.width - 20;
			cancelBtn.y = bkg.height - cancelBtn.height - 20;
			cancelBtn.touchable = true;
			cancelBtn.addEventListener(StTouchEvent.TOUCH, handleCancelClick);
			this.addChild(cancelBtn);
		}
		
		
		private function handleSaveClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(saveBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				saveOptions();
				this.dispatchEvent(new StEvent(CLOSE_EVENT));
			}
		}
		
		private function handleCancelClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(cancelBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				this.dispatchEvent(new StEvent(CLOSE_EVENT));
			}
		}
		
		private function saveOptions():void{
			trace("save options");
		}
	}
}