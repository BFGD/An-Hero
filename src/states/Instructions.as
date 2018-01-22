package states
{
	import com.greensock.TweenMax;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import objects.BackgroundHills;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Instructions extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundHills;
		private var menubtn:Button;
		private var slateInstructions:Image;
		
		public function Instructions(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundHills();
			background.hills1.x = Game.xCordHill1;
			background.hills2.x = Game.xCordHill2;
			addChild(background)
			
			menubtn = new Button(Assets.ta.getTexture("btnMenu_Up"));
			menubtn.pivotX = menubtn.width * 0.5;
			menubtn.pivotY = menubtn.height * 0.5;
			menubtn.y = 590;
			menubtn.x = 475;
			TweenMax.to(menubtn, 1, {y:490});
			menubtn.scaleX = 0.2;
			menubtn.scaleY = 0.2;
			menubtn.addEventListener(Event.TRIGGERED, onMenu);
			addChild(menubtn);
			
			slateInstructions = new Image(Assets.slateInstructionsTexture);
			slateInstructions.pivotX = slateInstructions.width * 0.5;
			slateInstructions.pivotY = slateInstructions.height * 0.5;
			slateInstructions.y = -500;
			slateInstructions.x = 475;
			TweenMax.to(slateInstructions, 1, {y:250});
			addChild(slateInstructions);
		}
		
		private function onMenu():void
		{
			Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
			game.changeState(Game.MENU_STATE);
		}
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
			background.removeFromParent(true);
			background = null;
			
			menubtn.removeFromParent(true);
			menubtn = null;
			
			removeFromParent(true);
		}
	}
}