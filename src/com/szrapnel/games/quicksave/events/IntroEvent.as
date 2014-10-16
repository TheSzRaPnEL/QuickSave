package com.szrapnel.games.quicksave.events 
{
	import starling.events.Event;
	
	/**
	 * Intro movie events
	 * @author SzRaPnEL
	 */
	public class IntroEvent extends Event 
	{
		public static const INTRO_FINISHED:String = "introFinished";
		static public const START_BTN_CLICKED:String = "startBtnClicked";
		
		public function IntroEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}