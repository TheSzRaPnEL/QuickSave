package com.szrapnel.games.quicksave.states 
{
	/**
	 * Common state interface
	 * @author SzRaPnEL
	 */
	public interface IState 
	{
		function get name():String;
		function enter():void;
		function update():void;
		function exit():void;
	}
}