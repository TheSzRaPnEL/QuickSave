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
		
		function addObject(object:Sprite):void
		
		function removeObject(object:Sprite):void
		
		function getObject(name:String):Sprite
	}
}