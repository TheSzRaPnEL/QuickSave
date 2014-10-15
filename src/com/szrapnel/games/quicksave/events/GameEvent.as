package com.szrapnel.games.quicksave.events 
{
	import starling.events.Event;
	
	/**
	 * Game action events
	 * @author SzRaPnEL
	 */
	public class GameEvent extends Event 
	{
		public static const START_GAME:String = "startGame";
		
		public function GameEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}