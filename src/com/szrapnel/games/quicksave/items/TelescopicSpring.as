package com.szrapnel.games.quicksave.items
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class TelescopicSpring extends Sprite
	{
		private var topSticks:Vector.<Quad>
		private var botSticks:Vector.<Quad>
		private var stickWidth:int = 34;
		
		public function TelescopicSpring()
		{
			topSticks = new Vector.<Quad>;
			botSticks = new Vector.<Quad>;
		}
		
		public function generate():void
		{	
			for (var i:int = 0; i < 20; i++)
			{
				var stick:Quad = new Quad(40, 5, 0x1a1a1a);
				stick.pivotX = 3;
				stick.pivotY = 3;
				topSticks.push(stick);
				addChild(stick);
			}
			
			topSticks[0].rotation = -175 * Math.PI / 180;
			
			for (i = 0; i < 20; i++)
			{
				stick = new Quad(40, 5, 0);
				stick.pivotX = 3;
				stick.pivotY = 3;
				botSticks.push(stick);
				addChild(stick);
			}
			
			botSticks[0].rotation = -topSticks[0].rotation;
		}
		
		public function setWidth(value:Number):void
		{
			var angleToFitWidth:Number = Math.acos((value / topSticks.length) / stickWidth) - Math.PI;
			trace(angleToFitWidth);
			topSticks[0].rotation = angleToFitWidth;
			botSticks[0].rotation = -topSticks[0].rotation;
			update();
		}
		
		private function update():void
		{
			var mainRotation:Number;
			for each (var stick:Quad in topSticks)
			{
				if (topSticks.indexOf(stick) != 0)
				{
					var prevStickID:int = topSticks.indexOf(stick) - 1;
					var prevStick:Quad = topSticks[prevStickID];
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