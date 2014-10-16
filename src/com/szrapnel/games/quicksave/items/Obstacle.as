package com.szrapnel.games.quicksave.items {
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Obstacle extends Sprite 
	{
		private var container:Sprite;
		
		public function Obstacle() 
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_hurdle"));
			image.x = - image.width / 2;
			image.y = - image.height / 2;
			container.addChild(image);
		}
		
	}
}