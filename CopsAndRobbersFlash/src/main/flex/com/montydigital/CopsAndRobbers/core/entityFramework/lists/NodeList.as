package com.montydigital.CopsAndRobbers.core.entityFramework.lists{
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.INode;

	public class NodeList{
		
		//temporarily use an array -> this will have to become a linkedList
		public var list:Array;
		
		public function NodeList(){
			list = new Array();
		}
		
		public function add(node:INode):void{
			list.push(node);
		}
		
		public function remove(node:INode):void{
			list.splice(list.indexOf(node), 1);
		}
	}
}