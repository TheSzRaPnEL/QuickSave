package com.szrapnel.games.quicksave 
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class PlayBtn extends Sprite 
	{
		private var container:Sprite;
		
		public function PlayBtn() 
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_button_PLAY"));
			container.addChild(image);
		}
		
	}
}