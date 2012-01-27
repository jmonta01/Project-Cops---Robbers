package com.montydigital.CopsAndRobbers.core.entityFramework.lists{
	import com.montydigital.CopsAndRobbers.core.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.Node;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class Family{
		
		private var nodeClass:Class;
		private var nodes:NodeList;
		private var entities:Dictionary;
		private var components:Dictionary;
		
		public function Family(nodeClass:Class){
			this.nodeClass = nodeClass;
			init();
		}
		
		private function init():void{
			nodes = new NodeList();
			entities = new Dictionary();
			
			components = new Dictionary();
			var node:* = new nodeClass();
			
/*
**			custom linked list
*/
//			var variables : XMLList = describeType( nodeClass ).factory.variable;
//			for each(var atom:XML in variables){
//				if(atom.@name != "entity" && atom.@name != "previous" && atom.@name != "next"){
//					var componentClass : Class = getDefinitionByName( atom.@type ) as Class;
//					components[componentClass] = atom.@name.toString();
//				}
//			}
		}
		
		
		public function addIfMatch(entity:Entity):void{
			if(!entities[entity]){
				var componentClass:*;
				for(componentClass in components)
					if(!entity.has(componentClass))
						return;
				
				var node:Node = new nodeClass();
				node.entity = entity;
				
				for(componentClass in components){
					node[components[componentClass]] = entity.getComponent(componentClass);
				}
				nodes.add(node);
				entities[entity] = node;
			
			}
		}
		
		public function remove(entity:Entity):void{
			if(entities[entity]){
				nodes.remove(entities[entity]);
				delete entities[entity];
			}
		}
		
		public function cleanUp():void{
			for each(var node:Node in nodes.list){
				delete entities[node.entity];
			}
		}
	}
}