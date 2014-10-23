package com.szrapnel.games.quicksave.screens
{
	import com.szrapnel.games.quicksave.components.SimpleButton;
	import com.szrapnel.games.quicksave.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SelectionScreen extends Sprite
	{
		private var background:Image;
		private var levelMiniatures:Vector.<SimpleButton>;
		
		public function SelectionScreen()
		{
			levelMiniatures = new Vector.<SimpleButton>;
			
			background = new Image(Assets.getTexture("CowFall_bckg_U"));
			addChild(background);
			
			var miniature:SimpleButton = new SimpleButton(Assets.getTexture("CowFall_SScreen_level1"));
			miniature.x = 50;
			miniature.y = 200;
			miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures.push(miniature);
			addChild(miniature);
			
			miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level3_lock"));
			miniature.x = 300;
			miniature.y = 200;
			miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures.push(miniature);
			addChild(miniature);
		}
		
		private function onMiniatureTriggered_handler(e:Event):void 
		{
			dispatchEventWith(Event.TRIGGERED, false, levelMiniatures.indexOf(e.target));
		}
		
	}
}