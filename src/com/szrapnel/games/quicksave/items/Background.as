package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.quicksave.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Background extends Sprite
	{
		private var container:Sprite;
		
		public function Background()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_bckg"));
			container.addChild(image);
		}
		
	}
}