package com.montydigital.CopsAndRobbers.core.entityFramework.lists{
	import com.adobe.utils.ArrayUtil;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.ISystem;

	public class SystemList{
		
		//temporarily use an array -> this will have to become a linkedList
		private var list:Array;
		
		public function SystemList(){
			list = new Array();
		}
		
		public function getList():Array{
			return list;
		}
		
		public function add(system:ISystem, priority:int):void{
			list.splice(priority, 0, system);
		}
		
		public function removeSystem(system:ISystem):void{
			list.splice(list.indexOf(system), 1);
		}
	}
}