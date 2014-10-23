package com.szrapnel.games 
{
	import com.szrapnel.games.quicksave.services.StateMachine;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public interface IGame
	{
		function get assetsList():Vector.<String>;
		function get stateMachine():StateMachine;
	}
	
}