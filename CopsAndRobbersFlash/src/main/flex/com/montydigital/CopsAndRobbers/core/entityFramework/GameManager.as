package com.montydigital.CopsAndRobbers.core.entityFramework{
	import com.montydigital.CopsAndRobbers.core.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.core.entityFramework.lists.EntityList;
	import com.montydigital.CopsAndRobbers.core.entityFramework.lists.Family;
	import com.montydigital.CopsAndRobbers.core.entityFramework.lists.NodeList;
	import com.montydigital.CopsAndRobbers.core.entityFramework.lists.SystemList;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.ISystem;
	
	import flash.utils.Dictionary;
	
	public class GameManager{
		
		private var entities:EntityList;
		private var systems:SystemList;
		private var families:Dictionary;
		
		public function GameManager(){
			entities = new EntityList();
			systems = new SystemList();
			families = new Dictionary();
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
			entities.remove(entity);
		}
		
		/* systems */
		public function addSystem(system:ISystem, priotity:int):void{
			systems.add(system, priotity);
			system.start();
		}
		
		public function removeSystem(system:ISystem):void{
			system.stop();
			systems.removeSystem(system);
		}
		
		
		/* game loop */
		public function update(time:Number=1):void{
			for each(var system:ISystem in systems.getList())
				system.update(time);
		}
		
		public function purge():void{
			// TODO Auto Generated method stub
			
		}
	}
}