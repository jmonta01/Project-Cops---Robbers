package com.montydigital.gameEngine.entityFramework.system{
	

	public class SystemList{
		
		public var head:System;
		public var tail:System;
		
		public function SystemList(){}

		
		public function add(system:System):void{
			if(!head){
				head = tail = system;
			}else{
				for (var node:System = tail; node; node=node.previous){
					if(node.priority <= system.priority){
						break;
					}
				}
				if(node == tail){
					tail.next = system;
					tail.previous = tail;
					tail = system;
				}else if(!node){
					system.next = head;
					head.previous = system;
					head = system;
				}else{
					system.next = node.next;
					system.previous = node;
					node.next.previous = system;
					node.next = system;
				}
				
			}
		}
		
		public function removeSystem(system:System):void{
			if(head == system){
				head = head.next;
			}
			if(tail == system){
				tail = system.previous;
			}
			if(system.previous){
				system.previous.next = system.next;
			}
			if(system.next){
				system.next.previous = system.previous;
			}
		}
		
		public function removeAllSystems():void{
			while(head){
				var system:System = head;
				head = head.next;
				system.previous = null;
				system.next = null;
			}
			tail = null;
		}

	}
}