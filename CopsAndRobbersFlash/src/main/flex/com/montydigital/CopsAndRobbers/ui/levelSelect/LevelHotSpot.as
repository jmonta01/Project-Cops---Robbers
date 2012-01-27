package com.montydigital.CopsAndRobbers.ui.levelSelect
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.CopsAndRobbers.ui.common.BaseHotSpot;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class LevelHotSpot extends StSprite
	{
		
		public var vo:MenuLevelVO;
		private var hotSpot:BaseHotSpot;
		
		public function LevelHotSpot(vo:MenuLevelVO){
			this.vo = vo;
			super();
			hotSpot = new BaseHotSpot();
			hotSpot.x = -hotSpot.width/2;
			hotSpot.y = -hotSpot.height/2;
			this.addChild(hotSpot);
			
		}
		
	}
}