package com.montydigital.gameEngine.entityFramework{
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.gameEngine.entityFramework.family.Family;
	import com.montydigital.gameEngine.entityFramework.entity.EntityList;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.gameEngine.entityFramework.system.SystemList;
	import com.montydigital.gameEngine.entityFramework.system.ISystem;
	import com.montydigital.gameEngine.entityFramework.system.System;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public class GameManager{
		
		private var entities:EntityList;
		private var systems:SystemList;
		private var families:Dictionary;
		
		public var updating:Boolean = false;
		public var updateComplete:Signal;
		
		public function GameManager(){
			entities = new EntityList();
			systems = new SystemList();
			families = new Dictionary();
			updateComplete = new Signal();
		}
		
		/* entities */
		public function addEntity(entity:Entity):void{
			entities.add(entity);
			for each(var family:Family in families){
				family.addIfMatch(entity);
			}
		}
		
		public function removeEntity(entity:Entity):void{
			for each(var family:Family in families){
				family.remove(entity);
			}
			entity.componentAdded.remove(componentAdded);
			entities.remove(entity);
		}
		
		private function componentAdded(entity:Entity, componentClass:Class):void{
			for each(var family:Family in families){
				family.addIfMatch(entity);
			}
		}
		
		
		
		public function getNodeList(nodeClass:Class):NodeList{
			if(families[nodeClass]){
				return Family( families[nodeClass] ).nodes;
			}
			var family:Family = new Family(nodeClass);
			families[nodeClass] = family;
			
			for(var entity:Entity = entities.head; entity; entity = entity.next){
				family.addIfMatch(entity);
			}
			return family.nodes;
		}
		
		public function releaseNodeList(nodeClass:Class):void{
			if(families[nodeClass]){
				families[nodeClass].cleanUp();
			}
			delete families[nodeClass];
		}

		
		/* systems */
		public function addSystem(system:System, priotity:int):void{
			system.priority = priotity;
			systems.add(system);
			system.addToGame(this);
		}
		
		public function removeSystem(system:System):void{
			system.removeFromGame(this);
			systems.removeSystem(system);
		}
		
		
		public function purge():void{
			for(var system:System = systems.head; system; system = system.next){
				releaseNodeList(system.nodeClass);
				removeSystem(system);
			}
			for each(var family:Family in families){
				family.cleanUp();
			}
			entities.removeAll();
		}
		
		/* game loop */
		public function update(time:Number=1):void{
			updating = true;
			for(var system:System = systems.head; system; system = system.next){
				system.update(time);
			}
			updating = false
			updateComplete.dispatch();
		}

	}
}