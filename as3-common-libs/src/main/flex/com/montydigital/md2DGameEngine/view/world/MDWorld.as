package com.montydigital.md2DGameEngine.view.world
{
	import Box2D.Dynamics.b2Fixture;
	
	import com.montydigital.md2DGameEngine.events.world.MDWorldLockedEvent;
	import com.montydigital.md2DGameEngine.events.world.MDWorldReadyEvent;
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.IAbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IDestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IProp;
	import com.montydigital.md2DGameEngine.view.prop.Prop;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import net.hires.debug.Stats;
	
	import spark.components.IconPlacement;
	
	import starling.core.Starling;

	public class MDWorld extends Sprite
	{
		
		private var debugMode:Boolean;
		private var items:Array;
		private var itemsByFixture:Dictionary;
		private var b2World:MDB2World;
		
		public function MDWorld(debugMode:Boolean=false){
			this.debugMode = debugMode;
			this.addEventListener(Event.ADDED_TO_STAGE, initApp);
		}
		
		private function initApp(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, initApp);
			b2World = MDB2World.initInstance(this.stage);
			items = new Array();
			itemsByFixture = new Dictionary(true);
			if(debugMode){
			//	b2World.setupDebugMode();
			//	b2World.debugMode = true;
			//	addStats();
			}
			new MDWorldReadyEvent(MDWorldReadyEvent.MD_WORLD_READY).dispatch();
		}
		
		public function get isLocked():Boolean{
			return this.b2World.isLocked;
		}
		
		public function addItem(item:IProp):void{
			items.push(item);
			var fixture:b2Fixture = (item as AbstractProp).getB2DFixture();
			itemsByFixture[fixture] = item;
		}
		
		public function removeDestroyedItem(item:IAbstractProp):void{
			var index:int = items.indexOf(item);
			items.splice(index, 1);
			delete itemsByFixture[item.getB2DFixture()];
		}
		
		public function getItems():Array{
			return items;
		}
		
		public function getItemByFixture(fixture:b2Fixture):IProp{
			return itemsByFixture[fixture];
		}
		
		public function runLoop(e:Event):void{
			b2World.loop();
			for each(var body:IAbstractProp in items){
				body.updatePosition();				
			}
		}
		
		private function addStats():void{
			var stats:Stats = new Stats();
			stats.alpha = .4;
			stats.x = stats.y = 10;
			this.addChild(stats);
		}
	}
}