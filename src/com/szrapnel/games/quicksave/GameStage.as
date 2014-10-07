package com.szrapnel.games.quicksave 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class GameStage extends Sprite
	{
		private var _cow:Sprite;
		private var background:Background;
		private var fire:Fire;
		private var _platform:Sprite;
		private var _banner:Banner;
		private var _playBtn:PlayBtn;
		private var dock:Dock;
		
		public function GameStage() 
		{
			background = new Background();
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
		
		public function get playBtn():PlayBtn 
		{
			return _playBtn;
		}
		
		public function get banner():Banner 
		{
			return _banner;
		}
		
	}

}