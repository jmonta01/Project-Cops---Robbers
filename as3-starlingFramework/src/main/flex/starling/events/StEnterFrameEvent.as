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
    /** An EnterFrameEvent is triggered once per frame and is dispatched to all objects in the
     *  display tree.
     *
     *  It contains information about the time that has passed since the last frame. That way, you 
     *  can easily make animations that are independet of the frame rate, taking the passed time
     *  into account.
     */ 
    public class StEnterFrameEvent extends StEvent
    {
        /** Event type for a display object that is entering a new frame. */
        public static const ENTER_FRAME:String = "enterFrame";
        
        private var mPassedTime:Number;
        
        /** Creates an enter frame event with the passed time. */
        public function StEnterFrameEvent(type:String, passedTime:Number, bubbles:Boolean=false)
        {
            super(type, bubbles);
            mPassedTime = passedTime;
        }
        
        /** The time that has passed since the last frame (in seconds). */
        public function get passedTime():Number { return mPassedTime; }
    }
}