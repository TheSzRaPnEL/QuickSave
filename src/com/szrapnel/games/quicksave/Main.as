package com.szrapnel.games.quicksave
{
	import com.szrapnel.games.quicksave.events.DisplayListEvent;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobPosition;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * QuickSave document class
	 * @author SzRaPnEL
	 */
	public class Main extends Sprite 
	{
		private var star:Starling;
		private var admob:Admob;
		private var preloaderOverlay:Sprite;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
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
		
		private function showAdmob():void
		{
			admob = Admob.getInstance();
			admob.setKeys("ca-app-pub-3669883303109473/6323752906");
			admob.showBanner(Admob.BANNER, AdmobPosition.TOP_LEFT);
		}
		
		private function hideAdmob():void
		{
			if (admob != null)
			{
				admob.hideBanner();
			}
		}
		
		private function onLoaded(e:flash.events.Event):void 
		{
			var logo:Bitmap = e.target.content;
			logo.smoothing = true;
			logo.width = 268 / 540 * stage.fullScreenWidth;
			logo.scaleY = stage.fullScreenWidth / 540;
			logo.x = 136 / 540 * stage.fullScreenWidth;
			logo.y = 720 / 960 * stage.fullScreenHeight;
			preloaderOverlay.addChild(logo);
		}
		
		private function onStarlingRootCreated(e:starling.events.Event):void 
		{
			star.root.addEventListener(DisplayListEvent.HIDE_PRELOADER_OVERLAY, onHidePreloaderOverlay_handler);
			star.root.addEventListener(DisplayListEvent.SHOW_ADMOB, onShowAdmob_handler);
			star.root.addEventListener(DisplayListEvent.HIDE_ADMOB, onHideAdmob_handler);
		}
		
		private function onHideAdmob_handler(e:DisplayListEvent):void 
		{
			hideAdmob();
		}
		
		private function onShowAdmob_handler(e:DisplayListEvent):void 
		{
			showAdmob();
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
		
		private function deactivate(e:flash.events.Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
}