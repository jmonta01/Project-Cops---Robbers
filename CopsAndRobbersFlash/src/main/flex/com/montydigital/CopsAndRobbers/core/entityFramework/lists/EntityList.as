package com.montydigital.CopsAndRobbers.core.entityFramework.lists{
	import com.montydigital.CopsAndRobbers.core.entityFramework.entity.Entity;

	public class EntityList{
		 
		//temporarily use an array -> this will have to become a linkedList
		private var list:Array;
		
		public function EntityList(){
			list = new Array();
		}
		
		public function add(entity:Entity):void{
			list.push(entity);
		}
		
		public function remove(entity:Entity):void{
			list.splice(list.indexOf(entity), 1);
		}
	}
}