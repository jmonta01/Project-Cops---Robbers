package com.montydigital.CopsAndRobbers.engine.entityFramework.node
{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.node.Node;

	public class TargetingNode extends Node{
		
		public var targetingComponent:TargetingComponent;
		
		public function TargetingNode()
		{
			super();
		}
	}
}