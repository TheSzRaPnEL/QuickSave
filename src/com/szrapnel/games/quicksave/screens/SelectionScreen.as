package com.szrapnel.games.quicksave.screens
{
	import com.szrapnel.games.quicksave.components.SimpleButton;
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SelectionScreen extends Sprite
	{
		private var background:Image;
		private var levelMiniatures:Vector.<SimpleButton>;
		private var locks:Vector.<Image>;
		private var _bannerNumber:TextField;
		private var _bannerText:Image;
		
		public function SelectionScreen()
		{
			levelMiniatures = new Vector.<SimpleButton>;
			locks = new Vector.<Image>;
			
			background = new Image(Assets.getTexture("CowFall_bckg_U"));
			addChild(background);
			
			for (var i:int = 0; i < 2; i++)
			{
				for (var j:int = 0; j < 3; j++)
				{
					var miniature:SimpleButton;
					miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level" + (i * 3 + j + 1) + "_lock"));
					miniature.x = j * background.width / 3;
					miniature.y = (2 * i + 1) * background.height / 7 - 50;
					miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
					levelMiniatures.push(miniature);
					addChild(miniature);
					var lock:Image;
					lock = new Image(Assets.getTexture("CowFall_lock"));
					lock.touchable = false;
					lock.x = miniature.x + 110;
					lock.y = miniature.y + 220;
					locks.push(lock);
					addChild(lock);
				}
			}
			
			var banner:Sprite = new Sprite();
			banner.x = background.width / 20;
			banner.y = 11 * background.height / 14;
			addChild(banner)
			var bannerBackground:Image = new Image(Assets.getTexture("CowFall_SScreen_level7_baner"));
			banner.addChild(bannerBackground);
			_bannerText = new Image(Assets.getTexture("CowFall_SScreen_level7_baner_TXT1"));
			bannerText.x = 32;
			bannerText.y = 15;
			banner.addChild(bannerText);
			_bannerNumber = new TextField(100, 40, "1111", "font", 30, 0xff7300);
			bannerNumber.autoScale = true;
			bannerNumber.hAlign = HAlign.CENTER;
			bannerNumber.vAlign = VAlign.CENTER;
			bannerNumber.x = 81;
			bannerNumber.y = 27;
			banner.addChild(bannerNumber);
			
			miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level7_lock"));
			miniature.x = 2 * background.width / 3;
			miniature.y = 7 * background.height / 10;
			miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures.push(miniature);
			addChild(miniature);
			lock = new Image(Assets.getTexture("CowFall_lock"));
			lock.touchable = false;
			lock.x = miniature.x + 110;
			lock.y = miniature.y + 220;
			locks.push(lock);
			addChild(lock);
		}
		
		private function onMiniatureTriggered_handler(e:Event):void
		{
			dispatchEventWith(Event.TRIGGERED, false, levelMiniatures.indexOf(e.target));
		}
		
		public function deactivateLevel(value:int):void
		{
			levelMiniatures[value].removeEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].touchable = false;
			levelMiniatures[value].upState = Assets.getTexture("CowFall_SScreen_level" + (value + 1) + "_lock");
			levelMiniatures[value].downState = levelMiniatures[value].upState;
			locks[value].visible = true;
		}
		
		public function activateLevel(value:int):void
		{
			levelMiniatures[value].removeEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures[value].touchable = true;
			levelMiniatures[value].upState = Assets.getTexture("CowFall_SScreen_level" + (value + 1));
			levelMiniatures[value].downState = levelMiniatures[value].upState;
			locks[value].visible = false;
		}
		
		public function get bannerNumber():TextField 
		{
			return _bannerNumber;
		}
		
		public function get bannerText():Image 
		{
			return _bannerText;
		}
		
	}
}