package com.szrapnel.games.quicksave.services
{
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class SwampSimulation extends FirePitSimulation
	{
		private var obstacle:Body;
		
		public function SwampSimulation():void
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			obstacle = new Body(BodyType.STATIC);
			obstacle.shapes.add(new Circle(20));
			obstacle.setShapeMaterials(glueMaterial);
			obstacle.position.setxy(270, 250);
			obstacle.space = space;
		}
		
	}
}