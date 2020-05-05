package com.szrapnel.games.quicksave.screens
{
	import com.szrapnel.games.quicksave.components.SimpleButton;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.services.Assets;
	import com.szrapnel.games.services.SoundController;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Align;
	import starling.utils.Color;
	
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
			banner.y = 15 * background.height / 21;
			addChild(banner)
			var bannerBackground:Image = new Image(Assets.getTexture("CowFall_SScreen_level7_baner"));
			banner.addChild(bannerBackground);
			_bannerText = new Image(Assets.getTexture("CowFall_SScreen_level7_baner_TXT1"));
			bannerText.x = 32;
			bannerText.y = 15;
			banner.addChild(bannerText);
			var bannerNumberTextFormat:TextFormat = new TextFormat();
			bannerNumberTextFormat.color = 0xff7300;
			bannerNumberTextFormat.font = "font";
			bannerNumberTextFormat.size = 30;
			bannerNumberTextFormat.bold = false;
			bannerNumberTextFormat.horizontalAlign = Align.CENTER;
			bannerNumberTextFormat.verticalAlign = Align.CENTER;
			_bannerNumber = new TextField(100, 40, "1111", bannerNumberTextFormat);
			bannerNumber.autoScale = true;
			bannerNumber.x = 81;
			bannerNumber.y = 27;
			banner.addChild(bannerNumber);
			
			miniature = new SimpleButton(Assets.getTexture("CowFall_SScreen_level7_lock"));
			miniature.x = 2 * background.width / 3;
			miniature.y = 5 * background.height / 7 - 50;
			miniature.addEventListener(Event.TRIGGERED, onMiniatureTriggered_handler);
			levelMiniatures.push(miniature);
			addChild(miniature);
			lock = new Image(Assets.getTexture("CowFall_lock"));
			lock.touchable = false;
			lock.x = miniature.x + 110;
			lock.y = miniature.y + 220;
			locks.push(lock);
			addChild(lock);
			
			var backBtn:SimpleButton = new SimpleButton(Assets.getTexture("CowFall_button_back"));
			backBtn.removeEventListener(Event.TRIGGERED, onBackBtnTriggered);
			backBtn.addEventListener(Event.TRIGGERED, onBackBtnTriggered);
			backBtn.x = 10;
			backBtn.y = 870;
			addChild(backBtn);
		}
		
		private function onBackBtnTriggered(e:Event):void 
		{
			SoundController.playSound(Assets.assetManager.getSound("click"));
			
			dispatchEvent(new LevelEvent(LevelEvent.BACK_BTN_PRESSED));
		}
		
		private function onMiniatureTriggered_handler(e:Event):void
		{
			SoundController.playSound(Assets.assetManager.getSound("click"));
			
			dispatchEventWith(Event.TRIGGERED, false, levelMiniatures.indexOf(SimpleButton(e.target)));
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