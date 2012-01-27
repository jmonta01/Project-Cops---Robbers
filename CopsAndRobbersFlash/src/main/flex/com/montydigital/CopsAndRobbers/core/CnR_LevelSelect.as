package com.montydigital.CopsAndRobbers.core{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.CopsAndRobbers.ui.common.BackBtn;
	import com.montydigital.CopsAndRobbers.ui.common.BaseHotSpot;
	import com.montydigital.CopsAndRobbers.ui.levelSelect.LevelHotSpot;
	import com.montydigital.gameEngine.core.system.ISystem;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class CnR_LevelSelect extends StSprite implements ISystem{
		
		public static const LEVEL_SELECT_MAP:String = "levelSelectMap";
		
		private var gameRoot:CnR_GameRoot;
		
		private var map:StImage;
		private var hotSpots:Array;
		private var backBtn:BackBtn;
		
		public function CnR_LevelSelect(root:CnR_GameRoot){
			gameRoot = root;
			
			map = StImage.fromBitmap(new UIAssets.MapChicago());
			map.x = gameRoot.stage.stageWidth/2 - map.width/2;
			map.y = gameRoot.stage.stageHeight/2 - map.height/2;
			
			backBtn = new BackBtn();
			backBtn.x = 20;
			backBtn.y = this.gameRoot.stage.stageHeight - backBtn.height - 20;
			backBtn.touchable = true;
			backBtn.addEventListener(StTouchEvent.TOUCH, handleBackBtn);

		}
		
			
		
		public function enter():void{
			gameRoot.addChild(this);
			this.addChild(map);
			addHotSpots();
			this.addChild(backBtn);
		}
		
		private function addHotSpots():void{
			hotSpots = [];
			for each(var level:MenuLevelVO in gameRoot.selectedCity.levels){
				var hs:LevelHotSpot = new LevelHotSpot(level);
				hs.touchable = true;
				hs.addEventListener(StTouchEvent.TOUCH, handleHotSpotClick);
				hs.x =  map.x + level.coords.x;
				hs.y = map.y + level.coords.y;
				hotSpots.push(hs);
				this.addChild(hs);
			}
		}
		
		public function update():void{}
		
		public function exit():void{
			gameRoot.addChild(this);
			this.removeChild(map);
			for each(var hs:LevelHotSpot in hotSpots){
				hs.removeEventListener(StTouchEvent.TOUCH, handleHotSpotClick);
				this.removeChild(hs);
				hs = null;
			}
			this.removeChild(backBtn);

		}
		
		private function handleHotSpotClick(e:StTouchEvent):void{
			var touch:Touch;
			for each(var hs:LevelHotSpot in hotSpots){
				touch = e.getTouch(hs);
				if(touch && touch.phase == TouchPhase.ENDED){
					gameRoot.selectedLevel = hs.vo;
					gameRoot.gameFSM.setState(CnR_GamePlay.LEVEL_PLAY_BASE);
					return;	
				}	
			}
		}
		
		private function handleBackBtn(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(backBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED){
				gameRoot.gameFSM.setState(CnR_CitySelect.LEVEL_SELECT_CITY);
			}
		}
	}
}