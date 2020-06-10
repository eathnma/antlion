import java.util.Map;
import java.util.List;

public class Dialogue {

  PFont f;
  private String text;
  private int position;
  private int counter = 0;

  Dialogue(String text) {
    this.text = text;
  }


  void typewriteText(String textOne) {
    String textBox = textOne.substring(0, counter);

    if (counter < textOne.length()) {
      if (frameCount %4 == 0)
        counter++;
    } else if (counter == textOne.length()) {
      textBox = textBox + "_";
    }
    text(textBox, 0, 40, width, height);
  }
}
