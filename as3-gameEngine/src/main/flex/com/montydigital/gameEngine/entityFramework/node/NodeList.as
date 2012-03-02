package com.montydigital.gameEngine.entityFramework.node{
	
	import org.osflash.signals.Signal;

	public class NodeList{
		
		public var head:INode;
		public var tail:INode;
		
		public var nodeAdded:Signal;
		public var nodeRemoved:Signal;
		
		public function NodeList(){
			nodeAdded = new Signal(Node);
			nodeRemoved = new Signal(Node);
		}
		
		public function add(node:INode):void{
			if(!head){
				head = tail = node;
			}else{
				tail.next = node;
				node.previous = tail;
				tail = node;
			}
			nodeAdded.dispatch(node);		
		}
		
		public function remove(node:INode):void{
			if(head == node){
				head = head.next;
			}
			if(tail == node){
				tail = tail.previous;
			}
			if(node.previous){
				node.previous.next = node.next;
			}
			if(node.next){
				node.next.previous = node.previous;
			}
			nodeRemoved.dispatch(node);
		}
		
		public function removeAll():void{
			while(head){
				var node:INode = head;
				head = node.next;
				node.previous = null;
				node.next = null;
				nodeRemoved.dispatch(node);
			}
			tail = null;
		}
		
		public function get empty():Boolean{
			return (head == null);
		}
		
		public function swap(node:Node, node2:Node):void{
			//TODO - trunked out, as not sure this will be usefull...
			
			/*
			
			if( node1.previous == node2 )
			{
			node1.previous = node2.previous;
			node2.previous = node1;
			node2.next = node1.next;
			node1.next  = node2;
			}
			else if( node2.previous == node1 )
			{
			node2.previous = node1.previous;
			node1.previous = node2;
			node1.next = node2.next;
			node2.next  = node1;
			}
			else
			{
			var temp : Node = node1.previous;
			node1.previous = node2.previous;
			node2.previous = temp;
			temp = node1.next;
			node1.next = node2.next;
			node2.next = temp;
			}
			if( head == node1 )
			{
			head = node2;
			}
			else if( head == node2 )
			{
			head = node1;
			}
			if( tail == node1 )
			{
			tail = node2;
			}
			else if( tail == node2 )
			{
			tail = node1;
			}
			if( node1.previous )
			{							
			node1.previous.next = node1;
			}
			if( node2.previous )
			{
			node2.previous.next = node2;
			}
			if( node1.next )
			{
			node1.next.previous = node1;
			}
			if( node2.next )
			{
			node2.next.previous = node2;
			}			
			
			
			*/
		}
	}
}