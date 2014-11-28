package com.szrapnel.games.quicksave.services
{
	
	/**
	 * Game logic interface
	 * @author SzRaPnEL
	 */
	public interface IGameLogic
	{
		function init():void
		
		function endGame():void
		
		function stop():void
		
		function start():void
		
		function addEventListener(type:String, listener:Function):void;
		
		function removeEventListener(type:String, listener:Function):void
	}
}