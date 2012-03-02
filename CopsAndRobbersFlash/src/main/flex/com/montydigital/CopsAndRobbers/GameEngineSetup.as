package com.montydigital.CopsAndRobbers{
	
	import com.montydigital.CopsAndRobbers.engine.CnR_GameRoot;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.data.LevelData;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1200", height="600")]	
	public class GameEngineSetup extends Sprite{
		
		private var _starling:Starling;
		private var data:LevelData;
		
		public function GameEngineSetup(){			
			super();
			data = LevelData.getInstance();
			data.addEventListener(LevelData.COMPLETE, preloadComplete);
			data.loadMenuData();
			
			Box2dEngine.debugSprite = this;
		}
		
		private function preloadComplete(e:Event):void{
			initStarling();
		}
		
		
		private function initStarling():void{
			_starling = new Starling(CnR_GameRoot, stage);
			_starling.antiAliasing = 16;
			_starling.start();
		}
		
	}
}