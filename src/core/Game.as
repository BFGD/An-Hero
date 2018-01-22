package core
{
	import flash.media.Sound;
	
	import interfaces.IState;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import states.Barracks;
	import states.Battle;
	import states.Credits;
	import states.End;
	import states.Instructions;
	import states.Menu;
	import states.Splash;
	
	public class Game extends Sprite
	{
		public static const SPLASH_STATE:int = 0;	
		public static const MENU_STATE:int = 1;	
		public static const BARRACKS_STATE:int = 2;	
		public static const INSTRUCTIONS_STATE:int = 3;	
		public static const CREDITS_STATE:int = 4;	
		public static const BATTLE_STATE:int = 5;	
		public static const END_STATE:int = 6;
		
		public static const FEMALE_SELECTED:int = 0;
		public static const MALE_SELECTED:int = 1;
		
		public static const FONT_VCR:String = "VCR OSD Mono";
		
		public static var xCordHill1:int;
		public static var xCordHill2:int;
		
		public static var genderSelect:int; // 0: female, 1: male
		
		public static var gameOutcome:String;
		
		public static var soundUpVisible:Boolean = true;
		public static var soundDownVisisble:Boolean = false;
		
		public static var menuDrop:Boolean = false;
		
		private var current_state:IState;
		
		public function Game()
		{
			Assets.init();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			changeState(SPLASH_STATE);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public static function getCharacterString():String
		{
			if(genderSelect == 0)
			{
				return "Knight_Female";
			} 
			else
			{
				return "Knight_Male";
			}
		}
		
		public function changeState(state:int):void
		{
			if(current_state != null)
			{
				current_state.destroy();
				current_state = null;
			}
			
			switch(state)
			{
				case SPLASH_STATE:
					current_state = new Splash(this)
					break;
				
				case MENU_STATE:
					current_state = new Menu(this)
					break;
				
				case BARRACKS_STATE:
					current_state = new Barracks(this)
					break;
				
				case INSTRUCTIONS_STATE:
					current_state = new Instructions(this)
					break;
				
				case CREDITS_STATE:
					current_state = new Credits(this)
					break;
				
				case BATTLE_STATE:
					current_state = new Battle(this)
					break;
				
				case END_STATE:
					current_state = new End(this)
					break;
			}
			
			addChild(Sprite(current_state));
		}
		
		private function update(event:Event):void
		{
			current_state.update();
		}
	}
}