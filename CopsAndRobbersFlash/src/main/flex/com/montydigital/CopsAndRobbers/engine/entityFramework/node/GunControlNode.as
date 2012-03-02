package com.montydigital.CopsAndRobbers.engine.entityFramework.node{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunControlComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.node.Node;
	
	public class GunControlNode extends Node{
		
		public var gunControlComponent:GunControlComponent;
		public var gunComponent:GunComponent;
		public var positionComponent:PositionComponent;
		public var userControlComponent:TargetingComponent;
		
		public function GunControlNode(){
			super();
		}
	}
}