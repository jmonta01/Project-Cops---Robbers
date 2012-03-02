package com.montydigital.CopsAndRobbers.engine.physics.box2d.vo
{
	
	public class Box2DItemEnvPropsVO{
		public var mass:Number;
		public var density:Number;
		public var friction:Number;
		public var restitution:Number;
		
		public var isBullet:Boolean;
		
		/**
		 * 
		 * @param mass 
		 * @param density
		 * @param friction
		 * @param restitution
		 * @param isBullet
		 * 
		 */		
		public function Box2DItemEnvPropsVO(mass:Number=1, density:Number=1, friction:Number=.5, restitution:Number=.3, isBullet:Boolean=false){
			this.mass = mass;
			this.density = density;
			this.friction = friction;
			this.restitution = restitution;
			this.isBullet = isBullet;
		}
	}
}