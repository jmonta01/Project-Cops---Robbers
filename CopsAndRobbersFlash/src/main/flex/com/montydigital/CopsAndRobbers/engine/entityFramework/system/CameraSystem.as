package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CameraComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.gameEngine.entityFramework.input.UserIntentCapture;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.CameraNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.engine.gamePlay.Game;
	
	import flash.geom.Matrix;
	
	import starling.display.StDisplayObject;
	import starling.display.StSprite;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class CameraSystem extends System{
		
		private var userIntentCapture:UserIntentCapture;
		
		public function CameraSystem(userIntentCapture:UserIntentCapture){
			this.userIntentCapture = userIntentCapture;
			super();
		}
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( CameraNode );	
		}
		
		override public function update(time:Number):void{
			var cameraComponent:CameraComponent;
			var camera:StSprite;
			
			for(var node:INode = nodes.head; node; node = node.next){
				cameraComponent = CameraNode(node).cameraComponent;
				camera = cameraComponent.view;
				if(userIntentCapture.touching && userIntentCapture.zoomFactor != 1){
					zoomCamera(cameraComponent);
				}else if(userIntentCapture.touching && userIntentCapture.zoomFactor == 1){
					var newX:Number = camera.x + userIntentCapture.cameraPositionDelta.x; 
					var newY:Number = camera.y + userIntentCapture.cameraPositionDelta.y;
					panCamera(camera, newX, newY);
				}

			}
		}
		
		private function zoomCamera(cameraComponent:CameraComponent):void{
			if(userIntentCapture.zoomFactor){
				var matrix:Matrix = cameraComponent.view.transformationMatrix;
				var scale:Number = cameraComponent.view.scaleX * userIntentCapture.zoomFactor;
				if(scale >= cameraComponent.MIN_ZOOM && scale < cameraComponent.MAX_ZOOM){
					matrix.translate(-userIntentCapture.zoomOrigin.x, -userIntentCapture.zoomOrigin.y);
					matrix.scale(userIntentCapture.zoomFactor, userIntentCapture.zoomFactor);
					matrix.translate(userIntentCapture.zoomOrigin.x, userIntentCapture.zoomOrigin.y);
				}
				cameraComponent.view.scaleX = matrix.a; 
				cameraComponent.view.scaleY = matrix.d;  
				panCamera(cameraComponent.view, matrix.tx, matrix.ty);
			}

		}
		
		private function panCamera(camera:StSprite, newX:Number, newY:Number):void{
			if(newX >= Game.stageWidth - camera.width &&  newX <= 0)
				camera.x = newX;
			
			if(newY >= Game.stageHeight - camera.height && newY <= 0)
				camera.y = newY;

		}

	}
}