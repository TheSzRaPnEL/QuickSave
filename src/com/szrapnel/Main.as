package com.szrapnel
{
	import com.szrapnel.games.events.DisplayListEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * Project document class
	 * @author SzRaPnEL
	 */
	public class Main extends Sprite
	{
		private var star:Starling;
		private var preloaderOverlay:Sprite;
		private var sharedObject:SharedObject;
		
		public function Main():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			preloaderOverlay = new Sprite();
			preloaderOverlay.graphics.beginFill(0x1a1a1a);
			preloaderOverlay.graphics.drawRect(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			preloaderOverlay.graphics.endFill();
			addChild(preloaderOverlay);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoaded);
			loader.load(new URLRequest("logo_SzRaPnEL.jpg"));
			
			star = new Starling(StarlingMain, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			star.antiAliasing = 0;
			star.stage.stageHeight = 960;
			star.stage.stageWidth = stage.fullScreenWidth * 960 / stage.fullScreenHeight;
			
			star.start();
			star.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
		}
		
		private function onLoaded(e:flash.events.Event):void
		{
			var logo:Bitmap = e.target.content;
			logo.smoothing = true;
			logo.width = 268 / 540 * stage.fullScreenWidth;
			logo.scaleY = logo.scaleX;
			logo.x = 136 / 540 * stage.fullScreenWidth;
			logo.y = (stage.fullScreenHeight - logo.height) / 2;
			preloaderOverlay.addChild(logo);
		}
		
		private function onStarlingRootCreated(e:starling.events.Event):void
		{
			star.root.removeEventListener(DisplayListEvent.HIDE_PRELOADER_OVERLAY, onHidePreloaderOverlay_handler);
			star.root.addEventListener(DisplayListEvent.HIDE_PRELOADER_OVERLAY, onHidePreloaderOverlay_handler);
		}
		
		private function onHidePreloaderOverlay_handler(e:DisplayListEvent):void
		{
			hidePreloaderOverlay();
		}
		
		private function hidePreloaderOverlay():void
		{
			preloaderOverlay.visible = false;
		}
		
		private function showPreloaderOverlay():void
		{
			preloaderOverlay.visible = true;
		}
		
	}
}