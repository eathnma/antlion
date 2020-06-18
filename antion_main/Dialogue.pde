import java.util.List;
ArrayList<String> dialogueOne = new ArrayList<String>();
ArrayList<String> dialogueOneEnd = new ArrayList<String>();
ArrayList<String> minigameOne = new ArrayList<String>();
ArrayList<String> minigameTwo = new ArrayList<String>();
ArrayList<String> minigameThree = new ArrayList<String>();

public class Dialogue {

  PFont f;

  // load image
  PImage textBoxArt, antonyCropped, antifaCropped, antillaCropped;

  private String text;
  private int position;
  private int counter = 0;

  // x and y coordinates for textbox
  private int xPosTextBox = 40;
  private int yPosTextBox = height - 250;
  private int widthTextBox = width - 60;
  private int heightTextBox = 170;
  private int radiusTextBox = 10;

  // x and y coordinates for text
  private int xPosText = 120;
  private int yPosText = height - 190;

  // character attributes
  private int charSizeX = 1200;
  private int charSizeY = 518;

  // character one
  private int xPosChar0 = -325;
  private int yPosChar0 = height - 600;
  // character two
  private int xPosChar1 = width - 250;
  private int yPosChar1 = height - 350;

  Dialogue(String text) {
    this.text = text;
    textBoxArt = loadImage("textbox.png");
    antonyCropped = loadImage("AntonyCropped.png");
    antifaCropped = loadImage("AntifaCropped.png");
    antillaCropped = loadImage("AntillaCropped.png");
    f = createFont("suez.ttf", 30);
  }

  void typewriteText(String text, int character) {
    String textBox = text.substring(0, counter);

    if (counter < text.length()) {
      if (frameCount %  1 == 0)
        counter++;
    } else if (counter == text.length()) {
      textBox = textBox + " _";
      char flashingUnderscore = textBox.charAt(textBox.length() - 1);
      // can't figure out how to flash a single string item. Will figure out that soon.
    }

    String characterName = " ";
    if (character == 0) {
      image( antonyCropped, xPosChar0, yPosChar0, charSizeX, charSizeY );
      characterName = "Antony";
    }
    if (character == 1) {
      image( antifaCropped, xPosChar0 - 230, yPosChar0, charSizeX, charSizeY );
      characterName = "Queen Antifa";
    } 

    if (character == 2) {
      // antagonist 2, paste image
      println(dialogueCount);
      if (dialogueCount == 0 || dialogueCount == 1 || dialogueCount == 2 || dialogueCount == 3) {
        image( antonyCropped, xPosChar0, yPosChar0, charSizeX, charSizeY );
        characterName = "Antony";
      } else if ( dialogueCount == 4 || dialogueCount == 5) {
        image( antonyCropped, xPosChar0, yPosChar0, charSizeX, charSizeY );
        characterName = "Antilla the Hun";
      }
    }


    if (character == 3) {
    } // antagonist 3, paste image


    // print out the character one by one
    image(textBoxArt, 50, 500, 1083, 233);
    fill(#472600);
    textAlign(LEFT);
    text(textBox, xPosText, yPosText, width, height);

    pushMatrix();
    fill(#FFFFFF);
    textFont(f);
    textAlign(CENTER);
    text(characterName, -290, 512, width, height);
    popMatrix();
  }

  void counter(ArrayList <String> a, int character, int switchLevel) {
    println(dialogueCount);
    try {
      typewriteText(a.get(dialogueCount), character);
    } 
    catch(Exception e) {
      println("dialogue Over");
    }

    if (dialogueCount >= a.size()) {

      if (switchLevel == 10) {
        dialogue = true;
        level = 3;
        println("size count over works");
      } else {

        dialogue = false;
        game = true;
        level = switchLevel;
      }
    }
  }

  void allDialogue() {
    dialogueOne(dialogueOne);
    dialogueOneEnd(dialogueOneEnd);
    minigameOneDialogue(minigameOne);
    minigameTwoDialogue(minigameTwo);
    minigameThreeDialogue(minigameThree);
  }


  // dialogue strings 

  void dialogueOne(ArrayList a) {
    a.add("*Sigh*...");
    a.add("Who knew saving the world would involve jumping on platforms?");
    a.add("I hope the player knows that the movement keys are A and S.");
    a.add("Oh, and SPACEBAR to jump!"); 
    a.add("Hey you, player!");
    a.add("Get me to the top will you? Gotta rescue the Queen here.");
  }

  void dialogueOneEnd(ArrayList a) {
    a.add("That was easy."); //0
    a.add("Way too easy."); //1
    a.add("“One does not simply jump into Myrdor,” Elder Boromant said."); //2
    a.add("Well, I’m about to-"); //3
    a.add("The cripple fell for my trap. Fool."); //4
    a.add("He will never survive my treacherous insides."); //5
  }

  void minigameOneDialogue(ArrayList a) {
    a.add("Great, I’m inside an anteater.");
    a.add("His throat for that matter.");
    a.add("I gotta get out fast.");
    a.add("I’d tickle his uvula, but he doesn’t have one…");
    a.add("Maybe if I just scream my lungs out, he’ll spit me out!");

    a.add("Hey you, player! Be my voice!");
    a.add("Sing high notes to move me up...");
    a.add("and go low to move me down!");
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
    a.add("Maybe Anttila will get an upset stomach and he’ll puke me out instead!");

    a.add("Hey you, player!");
    a.add("Click on the stomach acid as fast as you can so we can push it back!");
    a.add("Be careful though, choose where you click!");
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
