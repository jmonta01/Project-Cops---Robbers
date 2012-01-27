package com.montydigital.CopsAndRobbers.core.entityFramework.entity{
	
	
	import flash.utils.Dictionary;
	
	public class Entity implements IEntity{
		
		private var components:Dictionary;
		
		public function Entity(){
			components = new Dictionary();
		}
		
		public function addComponent(component:Object):void{
			components[ (component.constructor as Class) ] = component;
		}
		
		public function removeComponent(componentClass:Class):void{
			delete components[componentClass];
		}
		
		public function getComponent(componentClass:Class):Object{
			return components[componentClass];
		}
		
		public function has(componentClass:Class):Boolean{
			return (components[componentClass] != null);
		}
	}
}