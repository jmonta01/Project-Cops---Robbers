package com.montydigital.gameEngine.display{
	import starling.display.StDisplayObject;
	import starling.display.StSprite;

	public class LayerManager{
		
		
		public static const BACKGROUND_LAYER:int = 0;
		public static const GAME_LAYER:int = 1;
		public static const FOREGROUND_LAYER:int = 2;
		public static const TARGETING_LAYER:int = 3;

		public var layers:Vector.<StSprite>;
		public static var CamerLayer:StSprite;
		
		
		public function LayerManager(parent:StSprite){
			layers = new Vector.<StSprite>();
			CamerLayer = new StSprite();
			parent.addChild(CamerLayer);
			
			var backgroundLayer:BackgroundLayer = new BackgroundLayer();
			CamerLayer.addChild(backgroundLayer);
			layers[BACKGROUND_LAYER] = backgroundLayer;
			
			var gameLayer:GameLayer = new GameLayer();
			CamerLayer.addChild(gameLayer);
			layers[GAME_LAYER] = gameLayer;
			
			var foregroundLayer:ForegroundLayer = new ForegroundLayer();
			CamerLayer.addChild(foregroundLayer);
			layers[FOREGROUND_LAYER] = foregroundLayer;
			
			var targetingLayer:TargetingLayer = new TargetingLayer();
			parent.addChild(targetingLayer);
			layers[TARGETING_LAYER] = targetingLayer;
		}
		
		public function addChildToLayer(child:StDisplayObject, layer:int=GAME_LAYER):void{
			layers[layer].addChild(child);
		}
		
		public function remvoeChildFromLayer(child:StDisplayObject, layer:int=GAME_LAYER):void{
			layers[layer].removeChild(child);
		}		
	}
}