import java.util.Map;
import java.util.List;

public class Dialogue {

  PFont f;
  private String text;
  private int position;
  private int counter = 0;

  // x and y coordinates for textbox
  private int xPosTextBox = 30;
  private int yPosTextBox = width - 30;
  private int widthTextBox;
  private int heightTextBox;

  // x and y coordinates for text
  private int xPosCharOne = 100;
  private int yPosCharOne = height - 140;

  Dialogue(String text) {
    this.text = text;
  }
  
 void drawDialogue(String text, int character, int position){
   
    typewriteText(text);
    character(character, position);
    
 }

  // int defines the type of character shown on the screen
  // position defines whether the character sits on the left or right side of the screen
  
  void character(int character, int position) {
    // specify drawing class here * i'll handle the animation of the characters. Think about imageMode center
    fill(255);
    rect( xPosTextBox, yPosTextBox, 10, 10 );

      if (position == 0){
        // position determines where the rectangle sits
      }
      
      if(position == 1){
      // position determines where the rectangle sits

      }
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
      text(textBox, xPosCharOne, yPosCharOne, width, height);
    }
  }
