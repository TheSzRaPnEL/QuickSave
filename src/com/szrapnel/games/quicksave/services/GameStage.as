package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.quicksave.items.Dock;
	import com.szrapnel.games.quicksave.items.Fire;
	import com.szrapnel.games.quicksave.items.Platform;
	import com.szrapnel.games.quicksave.items.PlayBtn;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class GameStage extends Sprite
	{
		private var _cow:Sprite;
		private var _background:Background;
		private var fire:Fire;
		private var _platform:Sprite;
		private var _platform2:Sprite;
		private var _banner:Banner;
		private var _playBtn:PlayBtn;
		private var dock:Dock;
		
		public function GameStage() 
		{
			_background = new Background();
			background.x = 0;
			background.y = 0;
			addChild(background);
			
			fire = new Fire();
			fire.x = 0;
			fire.y = background.height-fire.height;
			addChild(fire);
			fire.play();
			
			_cow = new Cow();
			cow.x = 0;
			cow.y = -100;
			addChild(cow);
			
			_platform = new Platform();
			platform.x = 100;
			platform.y = 480;
			addChild(platform);
			
			_platform2 = new Platform();
			platform2.x = 100;
			platform2.y = 680;
			addChild(platform2);
			
			dock = new Dock();
			dock.x = 540;
			dock.y = 365;
			addChild(dock);
			
			_banner = new Banner();
			banner.x = background.width - 287;
			banner.y = 0;
			addChild(banner);
			
			_playBtn = new PlayBtn();
			playBtn.x = (background.width - playBtn.width)/2;
			playBtn.y = (background.height - playBtn.height)/2;
			addChild(playBtn);
		}
		
		public function get cow():Sprite 
		{
			return _cow;
		}
		
		public function get platform():Sprite 
		{
			return _platform;
		}
		
		public function get platform2():Sprite 
		{
			return _platform2;
		}
		
		public function get playBtn():PlayBtn 
		{
			return _playBtn;
		}
		
		public function get banner():Banner 
		{
			return _banner;
		}
		
		public function get background():Background 
		{
			return _background;
		}
		
	}

}