import java.util.List;
ArrayList<String> dialogueOne = new ArrayList<String>();
ArrayList<String> dialogueOneEnd = new ArrayList<String>();
ArrayList<String> minigameOne = new ArrayList<String>();
ArrayList<String> minigameTwo = new ArrayList<String>();
ArrayList<String> minigameThree = new ArrayList<String>();

public class Dialogue {

  PFont f;
  private String text;
  private int position;
  private int counter = 0;

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

  void character(int character, int position) {
    // specify drawing class here * i'll handle the animation of the characters. Think about imageMode center

    if (character == 0) {
    } // antony, paste image
    if (character == 1) {
    } // antagonist, paste image 
    if (character == 2) {
    } // antagonist 2, paste image
    if (character == 3) {
    } // antagonist 3, paste image

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

  void counter(ArrayList a) {
    try {
      typewriteText(dialogueOne.get(dialogueCount));
    } 
    catch(Exception e) {
      println("dialogue Over");
    }
    if (dialogueCount >= a.size()) {
      //
    }
  }

  void allDialogue() {
    dialogueOne(dialogueOne);
    dialogueOneEnd(dialogueOneEnd);
    minigameOneDialogue(minigameOne);
    minigameTwoDialogue(mingameTwo);
    minigameThreeDialogue(minigameThree);
    
  }


  // dialogue strings 

  void dialogueOne(ArrayList a) {
    a.add("*Sigh*...");
    a.add("Who knew saving the world would involve jumping on platforms to save a damsel in distress?");
    a.add("I hope the player knows that the movement keys are A and S.");
    a.add("Oh, and SPACEBAR to jump!"); 
    a.add("Hey you, player!");
    a.add("Get me to the top will you? Gotta rescue the Queen here.");
  }

  void dialogueOneEnd(ArrayList a) {
    a.add("That was easy.");
    a.add("Way too easy.");
    a.add("“One does not simply jump into Myrdor,” Elder Boromant said.");
    a.add("Well, I’m about to-");
    a.add("The cripple fell for my trap. Fool.");
    a.add("He will never survive my treacherous insides.");
  }

  void minigameOneDialogue(ArrayList a) {
    a.add("Great, I’m inside an anteater.");
    a.add("His throat for that matter.");
    a.add("I gotta get out fast.");
    a.add("I’d tickle his uvula, but he doesn’t have one…");
    a.add("Maybe if I just scream my lungs out, he’ll spit me out!");

    a.add("Hey you, player! Be my voice!");
    a.add("Sing high notes to move me up the screen and go low to move me down!");
    a.add("If we get a good enough score, maybe I’ll be able to get out... ");
    a.add("Hope you’ve watched a few episodes of Antmerican Idol!");
  }

  void minigameTwoDialogue(ArrayList a) {
    a.add("He swallowed? Shame, thought he’d spit.");
    a.add("What in the world is that stench…");
    a.add("Stomach acid, fantastic.");
    a.add("Wait, no. FANTASTIC!");
    a.add("FANTASTIC!");
    a.add("If I use my imaginary telekinetic powers to push the acid back...");
    a.add("maybe Anttila will get an upset stomach and he’ll puke me out instead!");
    
    a.add("Hey you, player!");
    a.add("Click on the stomach acid as fast as you can so we can push it back!");
    a.add("Be careful though, choose where you click!");
    a.add("Hey you, player!");
    a.add("Hey you, player!");
    a.add("Hey you, player!");
  }
  
   void minigameThreeDialogue(ArrayList a) {
    a.add("*BLEGHHHH*");
    a.add("Gross.");
    a.add("Cripple! Help me!");
    a.add("How in the...no matter.");
    a.add("Did you know I can shoot antlions from my mouth?");
    a.add("Time for you to die.");
    a.add("maybe Anttila will get an upset stomach and he’ll puke me out instead!");
    
    a.add("Well, Raid sponsors me so I can shoot their cans from MY mouth.");
    a.add("My Queen, get behind me and I’ll protect you.");
    a.add("Time to show this goon who can shoot the farthest.");
  }
  
  void endScreen(ArrayList a) {
    a.add("I’ve never seen such battle prowess...who are y-");
    a.add("Shhhhhhh…give me a kiss and I’ll tell you my name.");
  }
  
}
