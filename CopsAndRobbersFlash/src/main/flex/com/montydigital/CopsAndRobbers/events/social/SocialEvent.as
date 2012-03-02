package com.montydigital.CopsAndRobbers.events.social{
	import starling.events.StEvent;
	
	public class SocialEvent extends StEvent{
		public static const TWITTER:String = "gotoTwitter";
		public static const FACEBOOK:String = "gotoFacebook";
		
		public function SocialEvent(type:String){
			super(type);
		}
	}
}