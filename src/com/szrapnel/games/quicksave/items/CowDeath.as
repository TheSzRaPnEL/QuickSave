package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class CowDeath extends Sprite
	{
		private var container:Sprite;
		private var animation:MovieClip;
		
		public function CowDeath()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			animation = new MovieClip(Assets.getTextures("CowFall_CowDEATH_00"), 10);
			container.addChild(animation);
			
			animation.x = -animation.width / 2;
			animation.y = -animation.height / 2;
			animation.loop = false;
		}
		
		public function play():void
		{
			animation.currentFrame = 0;
			animation.play();
			Starling.juggler.add(animation);
			animation.addEventListener(Event.COMPLETE, onAnimComple_handler);
		}
		
		private function onAnimComple_handler(e:Event):void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}