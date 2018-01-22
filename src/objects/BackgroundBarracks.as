package objects
{
	import core.Assets;
	import core.Game;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class BackgroundBarracks extends Sprite
	{		
		private var image:Image;
		
		public function BackgroundBarracks()
		{
			image = new Image(Assets.bkgBarracksTexture);
			image.pivotX = image.x * 0.5;
			image.pivotY = image.y * 0.5;
			addChild(image);
		}
		
		public function update():void
		{
			
		}
	}
}