package com.szrapnel.games.quicksave.events 
{
	import starling.events.Event;
	
	/**
	 * Events from Simulation
	 * @author SzRaPnEL
	 */
	public class SimulationEvent extends Event 
	{
		public static const COW_GRABBED:String = "cowGrabbed";
		
		public function SimulationEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}
}