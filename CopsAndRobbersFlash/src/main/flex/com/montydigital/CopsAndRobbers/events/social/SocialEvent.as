package com.montydigital.CopsAndRobbers.events.social{
	import com.montydigital.common.events.MDEvent;
	
	public class SocialEvent extends MDEvent{
		public static const TWITTER:String = "gotoTwitter";
		public static const FACEBOOK:String = "gotoFacebook";
		
		public function SocialEvent(type:String){
			super(type, bubbles, cancelable);
		}
	}
}