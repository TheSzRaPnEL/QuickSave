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
	}
}