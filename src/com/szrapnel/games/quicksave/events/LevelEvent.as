package com.szrapnel.games.quicksave.events 
{
	import starling.events.Event;
	
	/**
	 * Level events
	 * @author SzRaPnEL
	 */
	public class LevelEvent extends Event 
	{
		public static const READY:String = "levelReady";
		public static const WON:String = "levelWon";
		public static const LOST:String = "levelLost";
		public static const COW_SAVED:String = "cowSaved";
		
		public function LevelEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}