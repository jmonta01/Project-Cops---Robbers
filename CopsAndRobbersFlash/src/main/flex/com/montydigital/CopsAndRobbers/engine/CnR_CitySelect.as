package com.montydigital.CopsAndRobbers.engine
{
	import com.montydigital.CopsAndRobbers.data.GameStateData;
	import com.montydigital.CopsAndRobbers.data.LevelData;
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.ui.citySelect.MapHotSpot;
	import com.montydigital.CopsAndRobbers.ui.common.BackBtn;
	import com.montydigital.gameEngine.fsm.system.ISystem;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class CnR_CitySelect extends StSprite implements ISystem
	{
		public static const LEVEL_SELECT_CITY:String = "levelSelectCity";
		
		private var gameRoot:CnR_GameRoot;
		
		private var map:StImage;
		private var hotSpots:Array;
		private var backBtn:BackBtn;
		
		
		public function CnR_CitySelect(root:CnR_GameRoot){
			gameRoot = root;
			
			map = StImage.fromBitmap(new UIAssets.MapBig());
			map.x = this.gameRoot.stage.stageWidth/2 - map.width/2;
			map.y = this.gameRoot.stage.stageHeight/2 - map.height/2;
			
			backBtn = new BackBtn();
			backBtn.x = 20;
			backBtn.y = this.gameRoot.stage.stageHeight - backBtn.height - 20;
			backBtn.touchable = true;
			backBtn.addEventListener(StTouchEvent.TOUCH, handleBackBtn);
			
			addHotSpots();
		}
		
		private function addHotSpots():void{
			hotSpots = [];
			var hs:MapHotSpot;
			for each(var city:MenuCityVO in LevelData.MenuData){
				if(city.enabled){
					hs = new MapHotSpot(city);
					hs.touchable = true;
					hs.addEventListener(StTouchEvent.TOUCH, handleHotSpotClick);
					hs.x = map.x + city.coords.x;
					hs.y = map.y + city.coords.y;
					hotSpots.push(hs);
				}
			}
		}
		
		public function enter():void{
			gameRoot.addChild(this);
			this.addChild(map);
			for each(var hs:MapHotSpot in hotSpots){
				this.addChild(hs);
			}
			this.addChild(backBtn);
		}
		
		public function update():void{}
		
		public function exit():void{
			gameRoot.addChild(this);
			this.removeChild(map);
			for each(var hs:MapHotSpot in hotSpots){
				this.removeChild(hs);
			}
			this.removeChild(backBtn);
		}
		
		private function handleHotSpotClick(e:StTouchEvent):void{
			var touch:Touch;
			for each(var hs:MapHotSpot in hotSpots){
				touch = e.getTouch(hs);
				if(touch && touch.phase == TouchPhase.ENDED){
					GameStateData.selectedCity = hs.vo;
					gameRoot.gameFSM.setState(CnR_LevelSelect.LEVEL_SELECT_MAP);
					return;	
				}	
			}
		}
		
		private function handleBackBtn(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(backBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED)
				gameRoot.gameFSM.setState(CnR_StartMenu.START_MENU_BASE);
		}
	}
}