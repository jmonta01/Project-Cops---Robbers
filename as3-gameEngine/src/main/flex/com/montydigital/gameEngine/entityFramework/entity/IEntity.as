package com.montydigital.gameEngine.entityFramework.entity
{
	public interface IEntity
	{
		function addComponent(component:Object):void;
		function removeComponent(componentClass:Class):void;
		function getComponent(componentClass:Class):Object;
	}
}