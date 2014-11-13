package com.szrapnel.games.quicksave.screens
{
	import com.szrapnel.games.quicksave.components.SimpleButton;
	import com.szrapnel.games.services.Assets;
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
			
			for (var i:int = 0; i < 2; i++)
			{
				for (var j:int = 0; j < 3; j++)
				{
					var miniature:SimpleButton;
					miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level" + (i * 3 + j + 1) + "_lock"));
					miniature.x = j * background.width / 3;
					miniature.y = (2*i+1) * background.height / 7;
					miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
					levelMiniatures.push(miniature);
					addChild(miniature);
				}
			}
			
			miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level7_lock"));
			miniature.x = background.width / 3;
			miniature.y = 7 * background.height / 10;
			miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures.push(miniature);
			addChild(miniature);
		}
		
		private function onMiniatureTriggered_handler(e:Event):void 
		{
			dispatchEventWith(Event.TRIGGERED, false, levelMiniatures.indexOf(e.target));
		}
		
		public function deactivateLevel(value:int):void
		{
			levelMiniatures[value].removeEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].touchable = false;
			levelMiniatures[value].upState = Assets.getTexture("CowFall_SScreen_level" + (value+1) + "_lock");
			levelMiniatures[value].downState = levelMiniatures[value].upState;
		}
		
		public function activateLevel(value:int):void
		{
			levelMiniatures[value].removeEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].touchable = true;
			levelMiniatures[value].upState = Assets.getTexture("CowFall_SScreen_level" + (value+1));
			levelMiniatures[value].downState = levelMiniatures[value].upState;
		}
		
	}
}