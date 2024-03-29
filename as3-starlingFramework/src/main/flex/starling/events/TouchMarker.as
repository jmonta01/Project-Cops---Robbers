// =================================================================================================
//
//	Starling Framework
//	Copyright 2011 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.events
{
    import flash.geom.Point;
    
    import starling.display.StImage;
    import starling.display.StSprite;
    import starling.textures.Texture;
    
    /** The TouchMarker is used internally to mark touches created through "simulateMultitouch". */
    internal class TouchMarker extends StSprite
    {
        [Embed(source="../../assets/touch_marker.png")]
        private static var TouchMarkerBmp:Class;
        
        private var mCenter:Point;
        private var mTexture:Texture;
        
        public function TouchMarker()
        {
            mCenter = new Point();
            mTexture = Texture.fromBitmap(new TouchMarkerBmp());
            
            for (var i:int=0; i<2; ++i)
            {
                var marker:StImage = new StImage(mTexture);
                marker.pivotX = mTexture.width / 2;
                marker.pivotY = mTexture.height / 2;
                marker.touchable = false;
                addChild(marker);
            }
        }
        
        public override function dispose():void
        {
            mTexture.dispose();
            super.dispose();
        }
        
        public function moveMarker(x:Number, y:Number, withCenter:Boolean=false):void
        {
            if (withCenter)
            {
                mCenter.x += x - realMarker.x;
                mCenter.y += y - realMarker.y;
            }
            
            realMarker.x = x;
            realMarker.y = y;
            mockMarker.x = 2*mCenter.x - x;
            mockMarker.y = 2*mCenter.y - y;
        }
        
        public function moveCenter(x:Number, y:Number):void
        {
            mCenter.x = x;
            mCenter.y = y;
            moveMarker(realX, realY); // reset mock position
        }
        
        private function get realMarker():StImage { return getChildAt(0) as StImage; }
        private function get mockMarker():StImage { return getChildAt(1) as StImage; }
        
        public function get realX():Number { return realMarker.x; }
        public function get realY():Number { return realMarker.y; }
        
        public function get mockX():Number { return mockMarker.x; }
        public function get mockY():Number { return mockMarker.y; }
    }        
}