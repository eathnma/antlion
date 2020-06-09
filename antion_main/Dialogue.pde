import java.util.Map;
import java.util.List;

public class Dialogue {

  PFont f;
  private String text;
  private int position;

  Dialogue(String text) {
    this.text = text;
  }

  public void drawString(String text) {
    fill(255);

    int x = 10;
    for (int i = 0; i < text.length(); i++) {
      text(text.charAt(i), x, height/2);
      x += 10;
      delay(500);
    }
  }



  //private Map<Integer, DialogueNode> nodes = new HashMap<Integer, DialogueNode>();

  //public DialogueNode getNode(int id) {
  //  return nodes.get(id);
  //}

  //public void addNode(DialogueNode node) {
  //  this.nodes.put(node.getID(), node);
  //}

  //public int getStart() {
  //  return 0;
  //}
}

// this static tag might mess things up
//public static class DialogueNode {
//  private ArrayList<Integer> pointers = new ArrayList<Integer>();
//  private ArrayList<String> labels = new ArrayList<String>();

//  private String text;
//  private int id;

//  private NODE_TYPE type;

//  enum NODE_TYPE {
//    MULTIPLE_CHOICE, 
//      LINEAR, 
//      END, 
//      ;
//  }

//  public DialogueNode(String text, int id) {
//    this.text = text;
//    this.id = id;
//    type = NODE_TYPE.END;
//  }

//  public void addChoice(String option, int nodeId) {
//    if (type == NODE_TYPE.LINEAR) {
//      pointers.clear();
//    }
//    labels.add(option);
//    pointers.add(nodeId);
//    type = NODE_TYPE.MULTIPLE_CHOICE;
//  }

//  public void makeLinear(int nodeId) {
//    pointers.clear();
//    labels.clear();
//    pointers.add(nodeId);
//    type = NODE_TYPE.LINEAR;
//  }

//  public List<Integer> getPointers() {
//    return pointers;
//  }

//  public List<String> getLabels() {
//    return labels;
//  }

//  public NODE_TYPE getType() {
//    return type;
//  }

//  public int getID() {
//    return id;
//  }
//}

//public class DialogueTraverser {

//  private Dialogue dialogue;
//  private DialogueNode currentNode;

//  public DialogueTraverser(Dialogue dialogue){
//    this.dialogue = dialogue;
//    currentNode = dialogue.getNode(dialogue.getStart());
//  }

//  public DialogueNode getNextNode(int pointerIndex){
//    DialogueNode nextNode = dialogue.getNode(currentNode.getPointers().get(pointerIndex));
//    currentNode = nextNode;
//    return nextNode;
//  }

//  public List<String> getOptions() {
//    return currentNode.getLabels();
//  }

//  public String getText(){
//    return currentNode.getText();
//  }

//  public NODE_TYPE getType(){
//    return currentNode.getType();
//  }

//}
