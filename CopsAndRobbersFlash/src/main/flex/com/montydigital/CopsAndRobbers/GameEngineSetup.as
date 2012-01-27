package com.montydigital.CopsAndRobbers{
	
	import com.montydigital.CopsAndRobbers.core.CnR_GameRoot;
	import com.montydigital.CopsAndRobbers.core.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.data.GameData;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1200", height="600")]	
	public class GameEngineSetup extends Sprite{
		
		private var _starling:Starling;
		private var data:GameData;
		
		public function GameEngineSetup(){			
			super();
			data = new GameData();
			data.addEventListener(GameData.COMPLETE, preloadComplete);
			data.loadMenuData();
			
			Box2dEngine.debugSprite = this;
		}
		
		private function preloadComplete(e:Event):void{
			initStarling();
		}
		
		
		private function initStarling():void{
			_starling = new Starling(CnR_GameRoot, stage);
			_starling.start();
		}
		
	}
}