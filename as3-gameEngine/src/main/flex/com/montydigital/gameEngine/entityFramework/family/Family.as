package com.montydigital.gameEngine.entityFramework.family{
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.node.Node;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class Family{
		
		private var nodeClass:Class;
		public var nodes:NodeList;
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
			
			var variables : XMLList = describeType( nodeClass ).factory.variable;
			for each(var atom:XML in variables){
				if(atom.@name != "entity" && atom.@name != "previous" && atom.@name != "next"){
					var componentClass : Class = getDefinitionByName( atom.@type ) as Class;
					components[componentClass] = atom.@name.toString();
				}
			}
		}
		
		
		public function addIfMatch(entity:Entity):void{
			if(!entities[entity]){
				var componentClass:*;
				for(componentClass in components)
					if(!entity.has(componentClass))
						return;
				
				var node:INode = new nodeClass();
				node.entity = entity;
				
				for(componentClass in components){
					node[components[componentClass]] = entity.getComponent(componentClass);
				}
				nodes.add(node);
				entities[entity] = node;
				entity.componentRemoved.add(componentRemoved);
			
			}
		}
		
		public function remove(entity:Entity):void{
			if(entities[entity]){
				entity.componentRemoved.remove(componentRemoved);
				nodes.remove(entities[entity]);
				delete entities[entity];
			}
		}
		
		public function cleanUp():void{
			for(var node:INode = nodes.head; node; node = node.next){
				node.entity.componentRemoved.remove(componentRemoved);
				delete entities[node.entity];
			}
			nodes.removeAll();
		}
		
		private function componentRemoved(entity:Entity, componentClass:Class):void{
			if(components[componentClass]){
				remove(entity);
			}
		}
	}
}