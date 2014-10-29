package com.szrapnel.games.quicksave.levels 
{
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import flash.events.IEventDispatcher;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public interface ILevel
	{
		function generate():void
		
		function dispose():void
		
		function get gameStage():GameStage 
		
		function get symulation():Symulation 
		
		function get gameLogic():GameLogic 
	}
}