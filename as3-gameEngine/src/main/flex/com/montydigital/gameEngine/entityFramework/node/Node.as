package com.montydigital.gameEngine.entityFramework.node{
	import com.montydigital.gameEngine.entityFramework.entity.Entity;

	public class Node implements INode{
		
		private var _entity:Entity;
		public function get entity():Entity{ return _entity; }
		public function set entity(val:Entity):void{ _entity = val; }
		
		private var _prev:INode;
		public function get previous():INode{ return _prev; }
		public function set previous(val:INode):void{ _prev = val; }
		
		private var _next:INode;
		public function get next():INode{ return _next; }
		public function set next(val:INode):void{ _next = val; }
		
		public function Node(){
		}
	}
}