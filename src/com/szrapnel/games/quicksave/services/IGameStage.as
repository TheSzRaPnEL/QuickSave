package com.szrapnel.games.quicksave.services 
{
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * Game level graphics elements
	 * @author SzRaPnEL
	 */
	public interface IGameStage 
	{
		function generate():void
		
		function addObject(object:*):void
		
		function removeObject(object:*):void
		
		function getObject(name:String):*
		
		function addEventListener(type:String, listener:Function):void
		
		function removeEventListener(type:String, listener:Function):void
	}
}