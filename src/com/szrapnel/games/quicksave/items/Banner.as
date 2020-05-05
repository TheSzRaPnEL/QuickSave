package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Banner extends Sprite
	{
		private var container:Sprite;
		private var headline:TextField;
		private var _savedTxtf:TextField;
		
		public function Banner()
		{
			super();
			
			container = new Sprite();
			addChild(container);
			
			var image:Image = new Image(Assets.getTexture("CowFall_banner"));
			container.addChild(image);
			
			var bannerTextFormat:TextFormat = new TextFormat();
			bannerTextFormat.color = Color.WHITE;
			bannerTextFormat.font = "font";
			bannerTextFormat.size = 32;
			
			//headline = new TextField(100, 35, "SAVE", "font", 32, Color.WHITE);
			headline = new TextField(100, 35, "SAVE", bannerTextFormat);
			headline.autoScale = true;
			headline.x = 50;
			headline.y = 10;
			headline.touchable = false;
			container.addChild(headline);
			
			_savedTxtf = new TextField(100, 35, "", bannerTextFormat);
			savedTxtf.autoScale = true;
			savedTxtf.x = 185;
			savedTxtf.y = 10;
			savedTxtf.touchable = false;
			container.addChild(savedTxtf);
		}
		
		public function get savedTxtf():TextField
		{
			return _savedTxtf;
		}
		
	}
}