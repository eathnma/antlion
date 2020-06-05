						

								// READ ME //

// I've highlighted some Criteria, just in case it isn't clear

//	Criteria 3: Two Different Visual Appearances
// 				1: The shell is a different color everytime you run the program
//				2: The size of the eyes change everytime you run the program ( very slightly). 
//				   You can see evidence of this in the Snail Constructor ( SnailPanel line 52 )

//  Criteria 12: Food Consumed & New Food after 5 Seconds
//				1: You can find the Timer on ( line 37 )
//				2: Lines 101 - 121 is the logic behind it

							// ethan ma, 301330262

package GardenSnail;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.AffineTransform;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;

import processing.core.PVector;

public class SnailPanel extends JPanel implements ActionListener {
	private Snail snail;
	private Timer timer;
	
	private int foodTimer = 150; // setting a timer for the food ( with 30 fps in mind )
	
	public final static int GARDEN_X = 50; // set x position for frame
	public final static int GARDEN_Y = 50; // set y position for frame
	public final static int GARDEN_W = 500; // set width of grass
	public final static int GARDEN_H = 500; // set height of grass
	
	private Food food = null;
	
	boolean snailFood;
	boolean foodRespawn;
	
	public SnailPanel() {
		super();
		setPreferredSize(new Dimension(600, 600)); // dimension of panel
		timer = new Timer(33, this);
		timer.start(); 
		double scale = 1.0; // change this value to increase the SNAIL
		PVector loc = new PVector(GARDEN_X + GARDEN_W / 2, GARDEN_Y + GARDEN_H / 2); // middle position
		snail = new Snail(loc, 45, 60, scale,(int) (Math.random()* 10 + 5)); // new Snail Object
		food = new Food(0.5);
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g); // Call JPanel's method to clear the background
		Graphics2D g2 = (Graphics2D) g;
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		g2.setColor(new Color(112, 112, 112));
		g2.fillRect(GARDEN_X, GARDEN_Y, GARDEN_W, GARDEN_H);
		
		paintRoad(g2);
		
		if (food != null) food.drawFood(g2); // draw food first before snail
		
		snail.drawSnail(g2);
			
	}
	
	public void paintRoad(Graphics2D g2) {
		AffineTransform at = g2.getTransform();
		
		g2.setColor(new Color(60,177,28)); // GREEN GRASS
		
		g2.translate(GARDEN_X, GARDEN_Y);
		g2.fillRect(0, 0, 93, 500);
		
		g2.fillRect(410, 0, 93, 500);
	
		g2.setTransform(at);
		
		g2.translate(300, 500);
		g2.setColor(new Color(255,242,0)); // YELLOW for YELLOW STRIPES
		
		g2.fillRect(-5, -19, 10, 38);
		g2.fillRect(-5, -100, 10, 38);
		g2.fillRect(-5, -180, 10, 38);
		g2.fillRect(-5, -260, 10, 38);
		g2.fillRect(-5, -340, 10, 38);
		g2.fillRect(-5, -420, 10, 38);
		
		g2.setTransform(at);
		
	}
	
	@Override // for timer classes 
	public void actionPerformed(ActionEvent e) {
		snail.move();
		
		System.out.println(snailFood);
		
		if(foodRespawn) {
			foodTimer--; // run foodtimer if foodRespawn
		}
		
		if(foodTimer < 0) {   // once foodTimer hits 80
			snailFood = false;
			foodRespawn = false;
			foodTimer = 150;
			food = new Food(0.5);
		}
		
		if (food != null && snail.approach(food.getLoc())) { // Only when seed is not null, hit detection! 
			food = null;
			foodRespawn = true;
		}
		
		repaint();
	}
	
	
	public static void main(String[] args) {
		JFrame frame = new JFrame("ITS A SNAIL");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		SnailPanel bugPanel = new SnailPanel();
		frame.add(bugPanel);
		frame.pack();
		frame.setVisible(true);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
