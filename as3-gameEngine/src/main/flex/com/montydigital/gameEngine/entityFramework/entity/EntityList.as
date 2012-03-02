package com.montydigital.gameEngine.entityFramework.entity{

	public class EntityList{
		 
		public var head:Entity;
		public var tail:Entity;
		
		public function EntityList(){}
		
		public function add(entity:Entity):void{
			if(!head){
				head = tail = entity;
			}else{
				tail.next = entity;
				entity.previous = tail;
				tail = entity;
			}
		}
		
		public function remove(entity:Entity):void{
			if(head == entity){
				head = head.next;
			}
			if(tail == entity){
				tail = tail.previous;
			}
			if(entity.previous){
				entity.previous.next = entity.next;
			}
			if(entity.next){
				entity.next.previous = entity.next;
			}
		}
		
		public function removeAll():void{
			while(head){
				var entity:Entity = head;
				head = head.next;
				entity.previous = null;
				entity.next = null;
			}
			tail = null;
		}

	}
}