package com.szrapnel.games.quicksave 
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Cow extends Sprite 
	{
		private var container:Sprite;
		
		public function Cow() 
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_Cow"));
			container.addChild(image);
		}
		
	}
}