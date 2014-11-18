package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.quicksave.items.CowDeath;
	import com.szrapnel.games.quicksave.items.Dock;
	import com.szrapnel.games.quicksave.items.Fire;
	import com.szrapnel.games.quicksave.items.Platform;
	import com.szrapnel.games.quicksave.items.PlayBtn;
	import com.szrapnel.games.quicksave.items.TelescopicSpring;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class FirePit extends Sprite implements IGameStage
	{
		private var elements:Vector.<Sprite>;
		
		public function FirePit()
		{
			elements = new Vector.<Sprite>;
			super();
		}
		
		public function generate():void
		{
			var background:Sprite = new Background();
			background.x = 0;
			background.y = 0;
			addChild(background);
			background.name = "Background";
			addObject(background);
			
			var fire:Sprite = new Fire();
			fire.x = 0;
			fire.y = background.height - fire.height;
			addChild(fire);
			Fire(fire).play();
			fire.name = "Animation";
			addObject(fire);
			
			var cow:Sprite = new Cow();
			cow.x = 0;
			cow.y = -100;
			addChild(cow);
			cow.name = "Cow";
			addObject(cow);
			
			var cowDeath:Sprite = new CowDeath();
			cowDeath.x = 0;
			cowDeath.y = 0;
			addChild(cowDeath);
			cowDeath.name = "Death";
			cowDeath.visible = false;
			addObject(cowDeath);
			
			var hand:Sprite = new TelescopicSpring();
			TelescopicSpring(hand).generate();
			hand.x = 630;
			hand.y = 468;
			addChild(hand);
			hand.name = "Hand";
			addObject(hand);
			TelescopicSpring(hand).setWidth(10);
			
			var platform:Sprite = new Platform();
			platform.x = 100;
			platform.y = 480;
			addChild(platform);
			platform.name = "Platform";
			addObject(platform);
			
			var banner:Sprite = new Banner();
			banner.x = background.width - 287;
			banner.y = 0;
			addChild(banner);
			banner.name = "Banner";
			addObject(banner);
			
			var playBtn:Sprite = new PlayBtn();
			playBtn.x = (background.width - playBtn.width) / 2;
			playBtn.y = (background.height - playBtn.height) / 2;
			addChild(playBtn);
			playBtn.name = "PlayBtn";
			addObject(playBtn);
			
			var indicator:Sprite = new Sprite();
			var quad:Quad = new Quad(20, 20, 0xFF0000);
			indicator.addChild(quad);
			indicator.pivotX = 10;
			indicator.visible = false;
			indicator.y = 0;
			addChild(indicator);
			indicator.name = "Indicator";
			addObject(indicator);
		}
		
		public function addObject(object:Sprite):void
		{
			elements.push(object);
		}
		
		public function getObject(name:String):Sprite
		{
			for each (var object:Sprite in elements)
			{
				if (object.name == name)
				{
					return object;
				}
			}
			return null;
		}
		
	}
}