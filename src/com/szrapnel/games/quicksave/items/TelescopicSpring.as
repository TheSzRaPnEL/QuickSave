package com.szrapnel.games.quicksave.items
{
	import com.szrapnel.games.services.Assets;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class TelescopicSpring extends Sprite
	{
		private static const stickWidth:int = 24;
		private var topSticks:Vector.<Image>
		private var botSticks:Vector.<Image>
		
		public function TelescopicSpring()
		{
			topSticks = new Vector.<Image>;
			botSticks = new Vector.<Image>;
		}
		
		public function generate():void
		{	
			for (var i:int = 0; i < 20; i++)
			{
				var stick:Image = new Image(Assets.getTexture("CowFall_spring"));
				stick.blendMode = BlendMode.NONE;
				stick.scaleX = 24/52;
				stick.pivotX = 3;
				stick.pivotY = 3;
				stick.touchable = false;
				topSticks.push(stick);
				addChild(stick);
			}
			
			topSticks[0].rotation = -175 * Math.PI / 180;
			
			for (i = 0; i < 20; i++)
			{
				stick = new Image(Assets.getTexture("CowFall_spring"));
				stick.blendMode = BlendMode.NONE;
				stick.scaleX = 24/52;
				stick.pivotX = 3;
				stick.pivotY = 3;
				stick.touchable = false;
				botSticks.push(stick);
				addChild(stick);
			}
			
			botSticks[0].rotation = -topSticks[0].rotation;
		}
		
		public function setWidth(value:Number):void
		{
			var angleToFitWidth:Number = Math.acos((value / topSticks.length) / stickWidth) - Math.PI;
			topSticks[0].rotation = angleToFitWidth;
			botSticks[0].rotation = -topSticks[0].rotation;
			update();
		}
		
		private function update():void
		{
			var mainRotation:Number;
			for each (var stick:Image in topSticks)
			{
				if (topSticks.indexOf(stick) != 0)
				{
					var prevStickID:int = topSticks.indexOf(stick) - 1;
					var prevStick:Image = topSticks[prevStickID];
					stick.x = prevStick.x - stickWidth * Math.cos(prevStick.rotation + Math.PI);
					stick.y = prevStick.y - stickWidth * Math.sin(prevStick.rotation + Math.PI);
					stick.rotation = (2 * (prevStickID % 2) - 1) * mainRotation;
				}
				else
				{
					mainRotation = stick.rotation;
				}
			}
			for each (stick in botSticks)
			{
				if (botSticks.indexOf(stick) != 0)
				{
					prevStickID = botSticks.indexOf(stick) - 1;
					prevStick = botSticks[prevStickID];
					stick.x = prevStick.x - stickWidth * Math.cos(prevStick.rotation + Math.PI);
					stick.y = prevStick.y - stickWidth * Math.sin(prevStick.rotation + Math.PI);
					stick.rotation = (2 * (prevStickID % 2) - 1) * mainRotation;
				}
				else
				{
					mainRotation = stick.rotation;
				}
			}
		}
		
	}
}