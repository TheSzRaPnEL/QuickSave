package com.szrapnel.games.quicksave.components
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SimpleButton extends DisplayObjectContainer
	{
		private var upState:Texture;
		private var downState:Texture;
		private var image:Image;
		private var onBtn:Boolean;
		
		public function SimpleButton(upState:Texture, downState:Texture = null)
		{
			this.upState = upState;
			image = new Image(upState);
			if (downState != null)
			{
				this.downState = downState;
			}
			else
			{
				this.downState = upState;
			}
			addChild(image);
			image.addEventListener(TouchEvent.TOUCH, onImageTouch);
			
			onBtn = false;
		}
		
		private function onImageTouch(e:TouchEvent):void
		{
			if (e.getTouch(this))
			{
				var touch:Touch = e.getTouch(this)
				if (touch.phase == TouchPhase.BEGAN)
				{
					image.texture = downState;
					image.x = image.width / 20;
					image.y = image.height / 20;
					image.scaleX = 0.9;
					image.scaleY = image.scaleX;
					onBtn = true;
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					image.texture = upState;
					image.x = 0;
					image.y = 0;
					image.scaleX = 1;
					image.scaleY = image.scaleX;
					if (onBtn)
					{
						dispatchEvent(new Event(Event.TRIGGERED));
						onBtn = false;
					}
				}
				else if (touch.phase == TouchPhase.MOVED && (touch.getLocation(this).x < image.x || touch.getLocation(this).x > image.x + image.width || touch.getLocation(this).y < image.y || touch.getLocation(this).y > image.y + image.height))
				{
					image.texture = upState;
					image.x = 0;
					image.y = 0;
					image.scaleX = 1;
					image.scaleY = image.scaleX;
					onBtn = false;
				}
			}
		}
	
	}
}