package com.montydigital.CopsAndRobbers.engine.entityFramework.node
{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	
	import starling.display.StDisplayObject;
	import com.montydigital.gameEngine.entityFramework.node.Node;

	public class DisplayNode extends Node
	{
		
		public var displayComponent:DisplayComponent;
		public var positionComponent:PositionComponent;
		
		public function DisplayNode()
		{
			super();
		}
	}
}