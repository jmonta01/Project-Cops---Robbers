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
    import flash.utils.getQualifiedClassName;
    
    import starling.utils.formatString;

    /** Event objects are passed as parameters to event listeners when an event occurs.  
     *  This is Starling's version of the Flash Event class. 
     *
     *  <p>EventDispatchers create instances of this class and send them to registered listeners. 
     *  An event object contains information that characterizes an event, most importantly the 
     *  event type and if the event bubbles. The target of an event is the object that 
     *  dispatched it.</p>
     * 
     *  <p>For some event types, this information is sufficient; other events may need additional 
     *  information to be carried to the listener. In that case, you can subclass "Event" and add 
     *  properties with all the information you require. The "EnterFrameEvent" is an example for 
     *  this practice; it adds a property about the time that has passed since the last frame.</p>
     * 
     *  <p>Furthermore, the event class contains methods that can stop the event from being 
     *  processed by other listeners - either completely or at the next bubble stage.</p>
     * 
     *  @see EventDispatcher
     */
    public class StEvent
    {
        /** Event type for a display object that is added to a parent. */
        public static const ADDED:String = "added";
        /** Event type for a display object that is added to the stage */
        public static const ADDED_TO_STAGE:String = "addedToStage";
        /** Event type for a display object that is entering a new frame. */
        public static const ENTER_FRAME:String = "enterFrame";
        /** Event type for a display object that is removed from its parent. */
        public static const REMOVED:String = "removed";
        /** Event type for a display object that is removed from the stage. */
        public static const REMOVED_FROM_STAGE:String = "removedFromStage";
        /** Event type for a triggered button. */
        public static const TRIGGERED:String = "triggered";
        /** Event type for a movie that has reached the last frame. */
        public static const MOVIE_COMPLETED:String = "movieCompleted";
        /** Event type for a display object that is being flattened. */
        public static const FLATTEN:String = "flatten";
        /** Event type for a resized Flash Player. */
        public static const RESIZE:String = "resize";
        
        private var mTarget:StEventDispatcher;
        private var mCurrentTarget:StEventDispatcher;
        private var mType:String;
        private var mBubbles:Boolean;
        private var mStopsPropagation:Boolean;
        private var mStopsImmediatePropagation:Boolean;
        
        /** Creates an event object that can be passed to listeners. */
        public function StEvent(type:String, bubbles:Boolean=false)
        {
            mType = type;
            mBubbles = bubbles;
        }
        
        /** Prevents listeners at the next bubble stage from receiving the event. */
        public function stopPropagation():void
        {
            mStopsPropagation = true;            
        }
        
        /** Prevents any other listeners from receiving the event. */
        public function stopImmediatePropagation():void
        {
            mStopsPropagation = mStopsImmediatePropagation = true;
        }
        
        /** Returns a description of the event, containing type and bubble information. */
        public function toString():String
        {
            return formatString("[{0} type=\"{1}\" bubbles={2}]", 
                getQualifiedClassName(this).split("::").pop(), mType, mBubbles);
        }
        
        /** @private */
        internal function setTarget(target:StEventDispatcher):void 
        { 
            mTarget = target; 
        }
        
        /** @private */
        internal function setCurrentTarget(currentTarget:StEventDispatcher):void 
        { 
            mCurrentTarget = currentTarget; 
        }
        
        /** @private */
        internal function get stopsPropagation():Boolean { return mStopsPropagation; }
        
        /** @private */
        internal function get stopsImmediatePropagation():Boolean { return mStopsImmediatePropagation; }
        
        /** Indicates if event will bubble. */
        public function get bubbles():Boolean { return mBubbles; }
        
        /** The object that dispatched the event. */
        public function get target():StEventDispatcher { return mTarget; }
        
        /** The object the event is currently bubbling at. */
        public function get currentTarget():StEventDispatcher { return mCurrentTarget; }
        
        /** A string that identifies the event. */
        public function get type():String { return mType; }
    }
}