package com.montydigital.CopsAndRobbers.ui.citySelect
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.ui.common.BaseHotSpot;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class MapHotSpot extends StSprite
	{
		
		public static const UP_LEFT:String = "up_left";
		public static const UP_RIGHT:String = "up_right";
		public static const DOWN_LEFT:String = "down_left";
		public static const DOWN_RIGHT:String = "down_right";
		
		public var vo:MenuCityVO;
		private var labelFlag:StImage;
		private var hotSpot:BaseHotSpot;
		
		public function MapHotSpot(vo:MenuCityVO){
			this.vo = vo;
			super();
			hotSpot = new BaseHotSpot();
			hotSpot.x = -hotSpot.width/2;
			hotSpot.y = -hotSpot.height/2;
			this.addChild(hotSpot);
			
			labelFlag = StImage.fromBitmap(new UIAssets.MapLabel());			
			this.addChild(labelFlag);
			layoutFlag(vo.flagDirection);
		}
		
		private function layoutFlag(dir:String):void{
			switch(dir){
				case UP_RIGHT:
					labelFlag.y = -labelFlag.height; 
					break;
				case DOWN_RIGHT:
					labelFlag.y = labelFlag.height; 
					labelFlag.scaleY = -1;
					break;
			}
		}
		
	}
}