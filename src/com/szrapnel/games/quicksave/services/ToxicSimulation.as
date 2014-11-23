package com.szrapnel.games.quicksave.services
{
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class ToxicSimulation extends FirePitSimulation
	{
		private var obstacleLeft:Body;
		private var obstacleRight:Body;
		
		public function ToxicSimulation():void
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			obstacleLeft = new Body(BodyType.STATIC);
			obstacleLeft.shapes.add(new Circle(20));
			obstacleLeft.setShapeMaterials(glueMaterial);
			obstacleLeft.position.setxy(170, 370);
			obstacleLeft.space = space;
			
			obstacleRight = new Body(BodyType.STATIC);
			obstacleRight.shapes.add(new Circle(20));
			obstacleRight.setShapeMaterials(glueMaterial);
			obstacleRight.position.setxy(370, 370);
			obstacleRight.space = space;
		}
		
	}
}