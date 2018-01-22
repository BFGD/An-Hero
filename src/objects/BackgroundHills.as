package objects
{
	import core.Assets;
	import core.Game;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class BackgroundHills extends Sprite
	{
		public var hills1:Image;
		public var hills2:Image;
		private var count:int = 0;
	
		
		public function BackgroundHills()
		{
			hills1 = new Image(Assets.bkgHillsTexture);
			addChild(hills1);
			
			hills2 = new Image(Assets.bkgHillsTexture);
			if(hills2.x == 0)
			{
				hills2.x = -950;
			}
			
			addChild(hills2);
		}
		
		public function update():void
		{
			if(count%2 == 0)
			{
				hills1.x += 1;
				
				if(hills1.x >= 950)
				{
					hills1.x = -950;
				}
				
				hills2.x += 1;
				
				if(hills2.x >= 950)
				{
					hills2.x = -950;
				}
			}
			Game.xCordHill1 = hills1.x;
			Game.xCordHill2 = hills2.x;
			count++;
			
		}
	}
}