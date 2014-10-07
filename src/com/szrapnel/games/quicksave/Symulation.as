package com.szrapnel.games.quicksave
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import starling.core.Starling;
	
    public class Symulation extends Sprite
	{
		private static const debugMode:Boolean = false;
        private var _space:Space;
		private var _ball:Body;
		private var _platform:Body;
		private var debug:BitmapDebug;
		private var leftWall:Body;
		private var rightWall:Body;
		private var rightWallBot:Body;
		private var dockWallTop:Body;
		private var dockWallBot:Body;
		private var bouncyMaterial:Material;
		private var glueMaterial:Material;
 
        public function Symulation():void
		{
            super();
			
			generate();
        }
		
        private function generate():void
		{
            var gravity:Vec2 = Vec2.weak(0, 600);
            space = new Space(gravity);
			space.worldAngularDrag = 0.001;
			space.worldLinearDrag = 0.001;
			
			bouncyMaterial = new Material(1, 0.5, 0.5, 1);
			glueMaterial = new Material(0, 5, 5, 1, 1);
			
            setUp();
        }
		
        private function setUp():void
		{
            var w:int = 540;
            var h:int = 960;
			
            _ball = new Body(BodyType.DYNAMIC);
            ball.shapes.add(new Polygon(Polygon.box(50,50)));
            ball.position.setxy(w / 2, -100);
			ball.setShapeMaterials(bouncyMaterial);
            ball.angularVel = 10;
            ball.space = space;
			ball.disableCCD = true;
			
			_platform = new Body(BodyType.KINEMATIC);
			platform.allowRotation = false;
            platform.shapes.add(new Polygon(Polygon.rect(10, -5, 125, 25)));
            platform.shapes.add(new Polygon(Polygon.rect(10, -40, 15, 40)));
            platform.shapes.add(new Polygon(Polygon.rect(120, -40, 15, 40)));
			platform.setShapeMaterials(glueMaterial);
            platform.position.setxy(100, h/2);
            platform.velocity.x = 0;
            platform.space = space;
			platform.disableCCD = true;
			
			leftWall = new Body(BodyType.STATIC);
            leftWall.shapes.add(new Polygon(Polygon.rect(0, -100, 5, h + 200)));
			leftWall.setShapeMaterials(glueMaterial);
            leftWall.space = space;
			leftWall.disableCCD = true;
			
			rightWall = new Body(BodyType.STATIC);
            rightWall.shapes.add(new Polygon(Polygon.rect(w - 5, -100, 5, 475)));
			rightWall.setShapeMaterials(glueMaterial);
            rightWall.space = space;
			rightWall.disableCCD = true;
			
			rightWallBot = new Body(BodyType.STATIC);
            rightWallBot.shapes.add(new Polygon(Polygon.rect(w - 5, 545, 5, 455)));
			rightWallBot.setShapeMaterials(glueMaterial);
            rightWallBot.space = space;
			rightWallBot.disableCCD = true;
			
			dockWallTop = new Body(BodyType.STATIC);
            dockWallTop.shapes.add(new Polygon(Polygon.rect(0, 0, 22, 25)));
			dockWallTop.setShapeMaterials(glueMaterial);
            dockWallTop.space = space;
			dockWallTop.position.setxy(w - 22, 373);
			dockWallTop.disableCCD = true;
			
			dockWallBot = new Body(BodyType.STATIC);
            dockWallBot.shapes.add(new Polygon(Polygon.rect(0, 0, 22, 25)));
			dockWallBot.setShapeMaterials(glueMaterial);
			dockWallBot.position.setxy(w - 22, 523);
            dockWallBot.space = space;
			dockWallBot.disableCCD = true;
			
			if (debugMode)
			{
				debug = new BitmapDebug(w, h, 0, true);
				debug.display.scaleX = Starling.current.viewPort.width / 540;
				debug.display.scaleY = Starling.current.viewPort.height / 960;
				Starling.current.nativeStage.addChild(debug.display);
			}
        }
		
		public function reset():void
		{
			ball.position.setxy(270, -100);
			ball.velocity = Vec2.weak(0, 0);
            ball.angularVel = 0;
			ball.rotation = 0;
			
			platform.position.setxy(100, 480);
            platform.velocity.x = 0;
		}
		
		public function dropNewCow():void
		{
			ball.position.setxy((540 - 90) * Math.random(), -100);
			ball.angularVel = 0;
			ball.rotation = 0;
            ball.velocity = Vec2.weak(0, 0);
		}
		
        public function update(time:Number):void
		{
            space.step(time, 4, 4);	
			
			lowerForces();
			illegalCollisions();
			
			if (debugMode)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
        }
		
		private function illegalCollisions():void 
		{
			if (platform.position.x < 0)
			{
				platform.position.x = 0;
				platform.velocity.x = 0;
			}
			if (ball.position.x < 24 && platform.position.x < 24)
			{
				platform.position.x = 25;
				platform.velocity.x = 0;
			}
		}
		
		private function lowerForces():void 
		{
			if (platform.position.x < 520)
			{
				platform.velocity.x += 35;
			}
			else
			{
				platform.position.x = 520;
				platform.velocity.x = 0;
			}
		}
		
		public function get ball():Body 
		{
			return _ball;
		}
		
		public function get platform():Body 
		{
			return _platform;
		}
		
		public function get space():Space 
		{
			return _space;
		}
		
		public function set space(value:Space):void 
		{
			_space = value;
		}
    }
}