package com.szrapnel.games.quicksave 
{
	import starling.display.Sprite;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class GameStage extends Sprite
	{
		private var cow:Cow;
		private var background:Background;
		private var fire:Fire;
		private var platform:Platform;
		
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
			
			cow = new Cow();
			cow.x = 0;
			cow.y = 0;
			addChild(cow);
			
			platform = new Platform();
			platform.x = 0;
			platform.y = 500;
			addChild(platform);
		}
		
	}

}