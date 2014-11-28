package com.szrapnel.games.quicksave.levels
{
	import com.szrapnel.games.quicksave.services.IGameLogic;
	import com.szrapnel.games.quicksave.services.IGameStage;
	import com.szrapnel.games.quicksave.services.ISimulation;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public interface ILevel
	{
		function generate():void
		
		function dispose():void
		
		function get gameStage():IGameStage
		
		function get symulation():ISimulation
		
		function get gameLogic():IGameLogic
		
		function get musicName():String
		
		function set musicName(value:String):void
		
		function set visible(value:Boolean):void
		
		function set touchable(value:Boolean):void
	}
}