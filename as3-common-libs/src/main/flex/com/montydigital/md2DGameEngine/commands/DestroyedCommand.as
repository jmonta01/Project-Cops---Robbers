package com.montydigital.md2DGameEngine.commands{
	import com.montydigital.common.events.IMDEvent;
	import com.montydigital.common.events.MDEventDispatcher;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.events.world.MDWorldLockedEvent;
	import com.montydigital.md2DGameEngine.utilities.collision.DestroyedEvent;
	import com.montydigital.md2DGameEngine.view.abstract.IAbstractProp;
	import com.montydigital.md2DGameEngine.view.prop.Block;
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IDestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.ParticleProp;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.textures.Texture;
	
	public class DestroyedCommand implements IGameCommand{
		
		private var e:DestroyedEvent;
		
		private var _application:IApplication;
		public function get application():IApplication{ return _application; }
		public function set application(val:IApplication):void{ _application=val; } 
		
		private var prop:IAbstractProp;
		private var lockedTimer:Timer;

		public function DestroyedCommand(){}
		
		public function execute(event:IMDEvent):void{
			e = event as DestroyedEvent;
			prop = e.item;
			if(e.item is DestructibleProp){	
				if(!application.mdWorld.isLocked){
					buildParts();
				}else{
					lockedTimer = new Timer(10, 1);
					lockedTimer.addEventListener(TimerEvent.TIMER, handleTick);
					lockedTimer.start();
				}
			}else{
				destroyProp();				
			}
		}
		
		private function handleTick(e:TimerEvent):void{
			if(!application.mdWorld.isLocked){
				buildParts();
				lockedTimer.removeEventListener(TimerEvent.TIMER, handleTick);
				lockedTimer.stop();
				lockedTimer = null;
			}else{
				lockedTimer.start();
			}
		}
		
		private function buildParts():void{
			var dProp:DestructibleProp = prop as DestructibleProp;
			var numParts:int = Math.min(Math.max(int(Math.ceil(dProp.lastForceMultiplierApplied)) * 4, 4), 16);

			var texture:Texture = dProp.getInitialTexture();
			var originalPosition:Point = dProp.getPosition();
			
			var pWidth:int = int(texture.width/numParts);
			var pHeight:int = int(texture.height/numParts);

			var newPosition:Point = new Point();

			var particle:ParticleProp, newTexture:Texture;			
			var counter:int, xCounter:int, yCounter:int=0;			
			var region:Rectangle = new Rectangle(xCounter, yCounter, pWidth, pHeight);
			
			while(counter<numParts){
				trace(xCounter, yCounter, pWidth, pHeight);
				region.x = xCounter;
				region.y = yCounter;
				newTexture = Texture.fromTexture(texture, region);
				newPosition.x = originalPosition.x + xCounter;
				newPosition.y = originalPosition.y + yCounter;
				particle = new ParticleProp(newTexture, pWidth, pHeight, newPosition, dProp.lastForceMultiplierApplied);
				application.rootStarlingSprite.addChild(particle.getStarlingItem());
				application.mdWorld.addItem(particle);
				if(counter%2==1)
					xCounter += pWidth;
				else
					yCounter += pHeight;
				counter += 1;
			}
			destroyProp();
		}
		
		private function destroyProp():void{
			if(prop is DestructibleProp)
				application.mdWorld.removeDestroyedItem(prop as DestructibleProp);
			prop.destroy();
			prop = null;
		}
	}
}