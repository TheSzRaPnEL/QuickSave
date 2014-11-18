package com.szrapnel.games.quicksave.services
{
	import nape.phys.Body;
	import nape.space.Space;
	import starling.events.EventDispatcher;
	
	/**
	 * Physics simulation interface
	 * @author SzRaPnEL
	 */
	public interface ISimulation
	{
		function generate():void
		
		function reset():void
		
		function dropNewCow():void
		
		function update(time:Number):void
		
		function getBody(name:String):Body
		
		function get space():Space
		
		function set space(value:Space):void
		
		function get eventDispatcher():EventDispatcher 
	}
}