package com.szrapnel.games.quicksave.screens
{
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SelectionScreen extends Sprite
	{
		private var levelMiniatures:Vector.<Sprite>;
		
		public function SelectionScreen()
		{
			levelMiniatures = new Vector.<Sprite>;
		}
		
		public function addMiniature(miniature:Sprite):void
		{
			levelMiniatures.push(miniature);
			miniature.addEventListener(TouchEvent.TOUCH, onMiniatureTouch_handler);
		}
		
		private function onMiniatureTouch_handler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(e.target);
			if (touch.phase == TouchPhase.BEGAN)
			{
				trace("miniature " + levelMiniatures.indexOf(e.target) + " touched");
			}
		}
		
	}
}