					
package GardenSnail;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.AffineTransform;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;
import java.io.File;
import java.awt.geom.Line2D.Double;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;

import processing.core.PVector;

public class SnailPanel extends JPanel implements ActionListener {
	
	private Rectangle2D.Double grassLeft;
	private Rectangle2D.Double grassRight;
	private Rectangle2D.Double road;
	
	private Rectangle2D.Double yellowLine1;
	private Rectangle2D.Double yellowLine2;
	private Rectangle2D.Double yellowLine3;
	private Rectangle2D.Double yellowLine4;
	private Rectangle2D.Double yellowLine5;
	private Rectangle2D.Double yellowLine6;
	private Rectangle2D.Double yellowLine7;
	private Rectangle2D.Double yellowLine8;
	
	private Timer timer;
	private ArrayList<Animal> animalList = new ArrayList<Animal>();
	private ArrayList<Food> leafList = new ArrayList<Food>();
	private ArrayList<Missile> missileList = new ArrayList<Missile>(); 
	private HunterSnail hSnail;

	private Dimension paneSize;
	
	private int foodTimer = 150; // setting a timer for the food ( with 30 fps in mind )
	
	public final static int GARDEN_X = 50; // set x position for frame
	public final static int GARDEN_Y = 50; // set y position for frame
	public final static int GARDEN_W = 1150; // set width of grass
	public final static int GARDEN_H = 750; // set height of grass
	
	public static Line2D.Double rightEdge;
	public static Line2D.Double leftEdge;
	public static Line2D.Double topEdge;
	public static Line2D.Double bottomEdge;
	
	public boolean drawSnailAttributes = false;
	
	boolean snailFood;
	boolean foodRespawn;
	
	double leafTimer = 1.1;
	double leafScale = 0.5;
	
	boolean createFood;
	boolean drawLeaf = false;
	public boolean shook1;
	public boolean shook2;
	
	int shookTimer = 40;
	
	private static boolean fire;
	private static boolean program;
	private int deadSnailCounter = 0;
	private int deadSnailzillaCounter = 0;
	
	private int resetTimer = 165;
	
	public SnailPanel() {
		super();
		
		paneSize = new Dimension (1200, 800); // dimension of panel
		this.setPreferredSize(paneSize);
		
		rightEdge = new Line2D.Double(GARDEN_X + GARDEN_W, GARDEN_Y, GARDEN_X + GARDEN_W, GARDEN_Y + GARDEN_H);
		leftEdge = new Line2D.Double(GARDEN_X, GARDEN_Y, GARDEN_X, GARDEN_Y + GARDEN_H);
		topEdge = new Line2D.Double(GARDEN_X, GARDEN_Y, GARDEN_X+GARDEN_W, GARDEN_Y);
		bottomEdge = new Line2D.Double(GARDEN_X, GARDEN_Y + GARDEN_H, GARDEN_X + GARDEN_W, GARDEN_Y + GARDEN_H);
		
		
		//ArrayList for small snails
		for ( int i = 0; i < 12; i++) {
//			animalList.add(new Snail((float) Util.random(GARDEN_X, GARDEN_W), (float)Util.random(GARDEN_Y, GARDEN_H), 45, 60, (double) (Math.random() * 0.8 + 0.4), (int) (Math.random()* 10 + 5)));
			eatThisAnimal();
		}
		//ArrayList for Snailliza
		// add a snailzilla count variable and make it constant
		for( int i = 0; i < 6; i++) {
			feedThisAnimal();
		}
		
		for (int i = 0; i < 15; i++) {
			leafList.add(new Food((double)Math.random() * 0.4 + 0.8, 
					              (int)Util.random(GARDEN_X + 70, GARDEN_W - 70), 
					              (int)Util.random(GARDEN_Y + 70, GARDEN_H - 70)
					              ));
		}
		
		hSnail = new HunterSnail(50, 50, 45, 60, 1, 8);
		
		  grassLeft = new Rectangle2D.Double();
		 grassRight = new Rectangle2D.Double();
			   road = new Rectangle2D.Double();
			   
		yellowLine1 = new Rectangle2D.Double();
		yellowLine2 = new Rectangle2D.Double();
		yellowLine3 = new Rectangle2D.Double();
		yellowLine4 = new Rectangle2D.Double();
		yellowLine5 = new Rectangle2D.Double();
		yellowLine6 = new Rectangle2D.Double();	
		yellowLine7 = new Rectangle2D.Double();	
		yellowLine8 = new Rectangle2D.Double();
		
		setBackgroundAttributes();
		
		timer = new Timer(33, this);
		timer.start(); 
		
		addKeyListener(new MyKeyAdapter());
		setFocusable(true);
	}
	
	private class MyKeyAdapter extends KeyAdapter{
		@Override
		public void keyPressed(KeyEvent e) {
			if(e.getKeyCode() == KeyEvent.VK_D){
				drawSnailAttributes = true;
			}
			
			if(e.getKeyCode() == KeyEvent.VK_SPACE) {
				fire = true;
				//System.out.println("firing works!");
			}
		}
		
		public void keyReleased(KeyEvent e) {
			if(e.getKeyCode() == KeyEvent.VK_D){
				drawSnailAttributes = false;
			}
			
			if(e.getKeyCode() == KeyEvent.VK_SPACE) {
				fire = false;
				//System.out.println("firing works!");
			}
		}
	}
	
	private void eatThisAnimal() {
		animalList.add(new Snail((float) Util.random(GARDEN_X, GARDEN_W), (float)Util.random(GARDEN_Y, GARDEN_H), 45, 60, 0.5, (int) (Math.random()* 10 + 5)));
	}
	private void feedThisAnimal() {
		animalList.add(new Snailzilla((float)Util.random(GARDEN_X, GARDEN_W), (float) Util.random(GARDEN_Y, GARDEN_H), 45, 60, (double) (Math.random()* 0.8 + 0.6), (int) (Math.random()* 10 + 5)));
	}

	private void setBackgroundAttributes() {
		// GRASS LEFT
		grassLeft.setFrame(0, 0, 193, GARDEN_H - 50);
		// GRASS RIGHT
		grassRight.setFrame(GARDEN_W - 240 , 0, 193, GARDEN_H - 50);
		// YELLOW LINES
		yellowLine1.setFrame(300, -20, 10, 38);
		yellowLine2.setFrame(300, -100, 10, 38);
		yellowLine3.setFrame(300, -180, 10, 38);
		yellowLine4.setFrame(300, -260, 10, 38);
		yellowLine5.setFrame(300, -340, 10, 38);
		yellowLine6.setFrame(300, -420, 10, 38);
		yellowLine7.setFrame(300, 60, 10, 38);
		yellowLine8.setFrame(300, 140, 10, 38);
	}
	 
	private void paintRoad(Graphics2D g2) {

		AffineTransform at = g2.getTransform();
		
		g2.setColor(new Color(60,177,28)); // GREEN GRASS
		
		g2.translate(GARDEN_X, GARDEN_Y );
		
		g2.fill(grassLeft); // grass left
		g2.fill(grassRight); // grass right
	
		g2.setTransform(at);
		
		g2.translate(300, 500);
		g2.setColor(new Color(255,242,0)); // YELLOW for YELLOW STRIPES
		
		g2.fill(yellowLine1);
		g2.fill(yellowLine2);
		g2.fill(yellowLine3);
		g2.fill(yellowLine4);
		g2.fill(yellowLine5);
		g2.fill(yellowLine6);
		g2.fill(yellowLine7);
		g2.fill(yellowLine8);
		
		g2.setTransform(at);
	}
	
	private void drawStatusBar(Graphics2D g) {
		Font f = new Font("Courier",Font.BOLD, 15);
		g.setFont(f);
		g.setColor(Color.BLACK);
		g.fillRect(0, 750, 1200, 100);
		g.setColor(Color.white);
		g.drawString("Press D to toggle Snail Information", 30, 780);
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g); // Call JPanel's method to clear the background
		Graphics2D g2 = (Graphics2D) g;
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		g2.setColor(new Color(112, 112, 112));
		g2.fillRect(GARDEN_X, GARDEN_Y, GARDEN_W - 50, GARDEN_H - 50);
		
		paintRoad(g2);
		
		for (int i = 0; i < missileList.size(); i++) {
			if(deadSnailCounter >= 6 && deadSnailzillaCounter < 3)
			missileList.get(i).drawMissile(g2);
		}
		
		for (int i = 0; i < leafList.size(); i++) { // drawing leaf objects & looping
			leafList.get(i).drawFood(g2);
		}
		
		if(drawSnailAttributes) {
			hSnail.drawInfoToggle(g2);
		}
		
		for (int i = 0; i < animalList.size(); i++) {
			Animal animali = animalList.get(i);
			animali.drawSnail(g2);
			
			if(drawSnailAttributes) {
			   animali.drawInfoToggle(g2);
			}		
			
			if(animali.energy < 75) {
				animali.setSpeed();
			}
		}
		
		if(deadSnailCounter >= 6 && deadSnailzillaCounter < 3) {
			hSnail.drawSnail(g2);
		}
		
		drawStatusBar(g2);
	}
	
	void destroyAnimal(Animal a) {
		
		animalList.remove(a);
		//System.out.println("deleted");
	}
	
	@Override // for timer classes 
	public void actionPerformed(ActionEvent e) {		
		if(deadSnailCounter >= 6 && deadSnailzillaCounter < 3) {
			hSnail.update(); // moves the snail up and down the screen.
			
			if(fire) {
				hSnail.fire(missileList);
			}
			
			for (int i = 0; i < missileList.size(); i++) {
				Missile missilei = missileList.get(i);
				missilei.update(animalList, missileList);
			}
		}
//		try {
//		} catch (Exception e1) {
//			System.out.println("something wrong");
//			
//		}	
		for (int i = 0; i < animalList.size(); i++) {
			Animal animali = animalList.get(i);
			
			if(hSnail.detectCollision(animali)) {
				hSnail.health -= 10;
			}
			
			animali.energyStatus(); // depletes energy
			
			if(animali.energy < 0) {
				if(animali instanceof Snailzilla) {
					deadSnailzillaCounter += 1;
				}
				destroyAnimal(animali);
			}
			
			
			
			if(deadSnailzillaCounter >= 3) {
				System.out.println("Counter less than 3");
				resetTimer--;
				if(resetTimer <= 0) {
					System.out.println(deadSnailzillaCounter);
					/*
					for(int d = 0; d < animalList.size(); d++) {
						//Animal a = animalList.get((d);
						destroyAnimal(animalList.get(d));
					}
					*/
					animalList.clear();
					
					System.out.println("removed enemies");
					
					
					for ( int j = 0; j < 12; j++) {
//						animalList.add(new Snail((float) Util.random(GARDEN_X, GARDEN_W), (float)Util.random(GARDEN_Y, GARDEN_H), 45, 60, (double) (Math.random() * 0.8 + 0.4), (int) (Math.random()* 10 + 5)));
						eatThisAnimal();
					}
					//ArrayList for Snailliza
					for( int j = 0; j < 6; j++) {
						feedThisAnimal();
					}
					
					
					hSnail.health = 100;
					deadSnailCounter = 0;
					deadSnailzillaCounter = 0;
					resetTimer = 165;
				}
			}
			
			for (int j = 0; (i != j) && j < animalList.size(); j++) {
				Animal animalj = animalList.get(j);
							
				if(animali.detectCollision(animalj)) {
				// the code for two snails colliding
				  if (animali instanceof Snailzilla && animalj instanceof Snail) {
					  Snailzilla animaliS = (Snailzilla) animali;
					  Snail animalSnailOne = (Snail) animalj;
						destroyAnimal(animalj);
						deadSnailCounter += 1;
//						  if(animaliS.detectFeeler(animalj)) {
//							  System.out.println("CRITERIA 5");
//						  }
					  
				  } else if (animali instanceof Snail && animalj instanceof Snailzilla) {
					  Snailzilla animaljS = (Snailzilla) animalj;
							  destroyAnimal(animali);
							  deadSnailCounter += 1;
							  
//					  if(animaljS.detectFeeler(animali)) {
//						  System.out.println("CRITERIA 5");
//					  }
				  } 
			   }
				 if (animali instanceof Snailzilla && animalj instanceof Snail) {
					 Snailzilla animaliS = (Snailzilla) animali;
					 Snail animalSnailOne = (Snail) animalj;
					 if( animaliS.detectFeeler(animalj)) {
						 animaliS.moveVeryFast(animalSnailOne);
						 animalSnailOne.runAway(animaliS);
//						 System.out.println("Feeler detected");
					 } else {
						 animalSnailOne.hunt(leafList);
						 //animaliS.moveVerySlow();
					 }
	
					 
				 } 
				 /*else if (animali instanceof Snail && animalj instanceof Snailzilla) {
					 Snailzilla animaljS = (Snailzilla) animalj;
					 Snail animalSnailTwo = (Snail) animali;
					 if( animaljS.detectFeeler(animalj)) {
						 animaljS.moveVeryFast(animalSnailTwo);
						 animalSnailTwo.runAway(animaljS);
//						 System.out.println("Feeler detected");
					 } else {
						 animalSnailTwo.hunt(leafList);
						// animaljS.moveVerySlow();
					 }
				 }*/
			}
			
//			if(animali instanceof Snail) {
//				Snail animalSnail = (Snail) animali;
//				animalSnail.hunt(leafList);
//			}
			
			if(animali instanceof Snailzilla) {
				Snailzilla snailzillaSnail = (Snailzilla) animali;
				snailzillaSnail.move();
//				if(snailzillaSnail.detectFeeler(animali)) {
//					System.out.println("broken");
//				}
			}
			animali.checkCollision();
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
