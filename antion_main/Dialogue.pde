import java.util.List;
import java.util.Map;

public class Dialogue {

  PFont f;
  private String text;
  private int position;
  private int counter = 0;
  
  private Map<String, Integer> beginningDialogue = new HashMap<String, Integer>();

  // x and y coordinates for textbox
  private int xPosTextBox = 30;
  private int yPosTextBox = height - 200;
  private int widthTextBox = width - 60;
  private int heightTextBox = 170;
  private int radiusTextBox = 10;

  // x and y coordinates for text
  private int xPosText = 100;
  private int yPosText = height - 140;
  
  // character attributes
  private int charSize = 150;

  // character one
  private int xPosChar0 = 125;
  private int yPosChar0 = height - 350;
  // character two
  private int xPosChar1 = width - 250;
  private int yPosChar1 = height - 350;

  Dialogue(String text) {
    this.text = text;
  }
  
  // 0 : ANTONY
  // 1 : ANTAGONIST
  // 2 : ANTOGONIST 2
  // 3 : QUEEN LATIFA

  void drawDialogue(String dialogue, int position) {  
    if( dialogue == "beginningDialogue"){
       //ArrayList<String, int> beginningCommentary = new ArrayList<String, int>();
       //beginningCommentary.add(new String("i'm trying to test line 1"), new int(0));
       //beginningCommentary.add(new String("i'm trying to test line 2"), new int(0));
       
                            //KEY : VALUE
       beginningDialogue.put("i'm trying to test line 1", 0 );
       beginningDialogue.put("i'm trying to test line 2", 1 );
       beginningDialogue.put("i'm trying to test line 3", 1 );
       beginningDialogue.put("Hello World!", 1);
       beginningDialogue.put("i'm trying to test line 4", 2 );
    }
    
    int chara = beginningDialogue.get("i'm trying to test line 4");
    println(chara);
    
    character(chara, position);
    typewriteText(text);
  }

  void character(int character, int position) {
    // specify drawing class here * i'll handle the animation of the characters. Think about imageMode center
    
    if(character == 0){} // antony, paste image
    if(character == 1){} // antagonist, paste image 
    if(character == 2){} // antagonist 2, paste image
    if(character == 3){} // antagonist 3, paste image
    
    // position 0 = left
    if (position == 0) {
      //println("position 0");
      fill(200);
      rect( xPosChar0, yPosChar0, charSize, charSize );
      
    }
 
    // position 1 = right
    if (position == 1) {
      // position determines where the rectangle sits
      //println("position 1");
      fill(200);
      rect( xPosChar1, yPosChar1, charSize, charSize );
    }
    
    // text box drawing
    fill(100);
    rect( xPosTextBox, yPosTextBox, widthTextBox, heightTextBox, radiusTextBox );
    
  }

  void typewriteText(String text) {
    String textBox = text.substring(0, counter);

    if (counter < text.length()) {
      if (frameCount %4 == 0)
        counter++;
    } else if (counter == text.length()) {
      textBox = textBox + " _";
      char flashingUnderscore = textBox.charAt(textBox.length() - 1);
      // can't figure out how to flash a single string item. Will figure out that soon.
    }
     
    // print out the character one by one
    fill(255);
    text(textBox, xPosText, yPosText, width, height);
  }
  
}


//////////////////////////// DIALOGUE STRINGS /////////////////////////////////////
//level one 
String antonyStrings[] = {"first string", "second string", "third string"}; 
