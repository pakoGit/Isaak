package faceless.global 
{
	import flash.text.Font;

public class Assets 
{
	[Embed(source = "../../../lib/effects.png")]public static var effectsPNG:Class;
	[Embed(source = "../../../lib/font/nokiafc22.ttf", fontName = "Nokia", fontStyle = "normal", fontWeight = "bold", mimeType = "application/x-font-truetype", advancedAntiAliasing = "true", embedAsCFF = "false")]
	private var uiFont:Class;
	
	public function Assets() {
		Font.registerFont(uiFont);
	}
}
}