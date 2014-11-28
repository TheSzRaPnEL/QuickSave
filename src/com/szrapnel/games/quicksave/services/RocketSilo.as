package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.LaserField;
	import com.szrapnel.games.quicksave.items.Obstacle;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class RocketSilo extends FirePit
	{
		public function RocketSilo()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg3");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var laserField:Sprite = new LaserField();
			laserField.x = 0;
			laserField.y = getObject("Background").height - laserField.height;
			addChildAt(laserField, animIndex);
			LaserField(laserField).play();
			laserField.name = "Animation";
			addObject(laserField);
		}
		
	}
}