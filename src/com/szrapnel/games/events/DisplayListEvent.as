package com.szrapnel.games.events
{
	import starling.events.Event;
	
	/**
	 * Events working as requests to base class.
	 * @author SzRaPnEL
	 */
	public class DisplayListEvent extends Event 
	{
		public static const HIDE_PRELOADER_OVERLAY:String = "hidePreloaderOverlay";
		public static const SHOW_ADMOB:String = "showAdmob";
		public static const HIDE_ADMOB:String = "hideAdmob";
		static public const SHOW_INTERSTITIAL:String = "showInterstitial";
		static public const HIDE_INTERSTITIAL:String = "hideInterstitial";
		
		public function DisplayListEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}