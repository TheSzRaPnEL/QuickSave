package com.szrapnel.games.quicksave.events 
{
	import starling.events.Event;
	
	/**
	 * State change events
	 * @author SzRaPnEL
	 */
	public class StateEvent extends Event 
	{
		public static const GOTO_SELECTION_SCREEN:String = "gotoSelectionScreen";
		public static const GOTO_MAIN_MENU:String = "gotoMainMenu";
		
		public function StateEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}