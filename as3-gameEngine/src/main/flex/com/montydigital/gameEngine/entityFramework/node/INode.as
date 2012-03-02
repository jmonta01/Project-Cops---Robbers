package com.montydigital.gameEngine.entityFramework.node
{
	import com.montydigital.gameEngine.entityFramework.entity.Entity;

	public interface INode
	{
		function get entity():Entity;
		function set entity(val:Entity):void;

		
		function get next():INode;
		function set next(val:INode):void;
		
		function get previous():INode;
		function set previous(val:INode):void;

	}
}