package com.montydigital.gameEngine.entityFramework.entity{
	
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public class Entity implements IEntity{
		
		public var name:String;
		
		public var componentAdded:Signal;
		public var componentRemoved:Signal;
		
		public var previous:Entity;
		public var next:Entity;
		public var components:Dictionary;
		
		public function Entity(){
			componentAdded = new Signal(Entity, Class);
			componentRemoved = new Signal(Entity, Class);
			components = new Dictionary();
		}
		
		public function addComponent(component:Object):void{
			var componentClass:Class = component.constructor as Class; 
			components[ componentClass ] = component;
			componentAdded.dispatch(this, componentClass);
		}
		
		public function removeComponent(componentClass:Class):void{
			delete components[componentClass];
			componentRemoved.dispatch(this, componentClass);
		}
		
		public function getComponent(componentClass:Class):Object{
			return components[componentClass];
		}
		
		public function has(componentClass:Class):Boolean{
			return (components[componentClass] != null);
		}
		
		public function clone():Entity{
			//TODO - create the cloning functionality
/*			
			var copy : Entity = new Entity();
			for each( var component : Object in components )
			{
			var names : XMLList = describeType( component ).variable.@name;
			var componentClass : Class = component["constructor"];
			var newComponent : * = new componentClass();
			for each( var key : String in names )
			{
			newComponent[key] = component[key];
			}
			copy.add( newComponent );
			}
			return copy;
*/
			return null;
		}
	}
}