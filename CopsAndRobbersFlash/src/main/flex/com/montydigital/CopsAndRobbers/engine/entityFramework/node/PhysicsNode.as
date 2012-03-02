package com.montydigital.CopsAndRobbers.engine.entityFramework.node{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;
	import com.montydigital.gameEngine.entityFramework.node.Node;

	public class PhysicsNode extends Node{
		
		public var physicsComponent:PhysicsComponent;
		public var positionComponent:PositionComponent;
		
		public function PhysicsNode(){
			super();
		}
	}
}