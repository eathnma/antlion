/* 						READ ME
 * 
 *          JUSTIFICATIONS FOR SUPERCLASSES 
 *          
 *          1) All creatures have a FOV, draw method, move method, getForce method.
 *          Therefore, they go into the Superclass
 *          2) The eatable Snail has 4 distinct methods
 *          	- runaway from the big snail
 *          	- searching for food
 *          	- hunting for food
 *          	- colliding with food
 *          These methods are only specific to the eatable snail, and therefore they belong in that class
 *          3) Snailzilla has 3 distinct methods
 *          	- To move towards the eatable snail
 *          	- To detect collision with the eatable snail
 *          	- To check collision with the eatable snail
 *        	These methods are only specific to Snailzilla, and therefore they belong in that class
 * */


package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.awt.geom.Arc2D;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Line2D.Double;
import java.awt.geom.QuadCurve2D;
import java.awt.geom.Rectangle2D;
import java.util.ArrayList;

import processing.core.PVector;
public abstract class Animal {
	protected  Ellipse2D.Double body;
	protected  Ellipse2D.Double butt;
	protected  Ellipse2D.Double shell;
	protected  Ellipse2D.Double leftDot;
	protected  Ellipse2D.Double rightDot;
	protected  QuadCurve2D.Double leftArc;
	protected  QuadCurve2D.Double rightArc;
	
	private Dimension panelSize;	//field to reference panel's dimension
	private Dimension dimension; 
	
	protected PVector loc;
	protected PVector vel;
	protected float maxSpeed;
	private int bodyW;
	private int bodyH;
	protected double scale;
	protected int eyeSize;
	protected int buttAnimation = -15;
	
	protected Color myColor;
	private Area outline;
	
	int counter;
	boolean counterRun = false;
	
	protected PVector feelerVector;
	protected Line2D feeler;
	
	protected Area fovBox;
	protected Arc2D.Double fov;
	
	protected float energy;
	
	protected Color shellColor;

	public Animal(float x, float y, int w, int h, double sc, int eyeS) {
		
	    loc = new PVector(x, y);
		this.bodyW = w;
		this.bodyH = h;
		this.scale = sc;
		this.vel = new PVector(1, 1);
		counter = 0;
		eyeSize = eyeS;
		
		while (maxSpeed == 0)
		this.maxSpeed = (float) ((double) (Math.random() * 1) + 1.5);
		
		int red = 	 (int) (Math.random()* 255 + 0);
		int green =  (int) (Math.random()* 255 + 0);
		int blue =   (int) (Math.random()* 255 + 0);
		
		myColor = new Color (red, green, blue);
		
		shellColor = new Color (255, 0, 0);
		
		setCircleAttributes();
		setAttributes();
		updateFeeler();
	}
	
	public void setSpeed() {
		maxSpeed = (float) 0.8;
	}
	
	public void setColor(Color color) {
		myColor = new Color(255,0,0);
	}
	
	public void drawSnailDying(Graphics2D g) {
		Graphics2D g2 =(Graphics2D) g;
		g2.setStroke(new BasicStroke(3));
		g2.setColor(Color.red);
	}
	
	public void energyStatus() {
		energy -= 0.10;
		// System.out.println(energy); // i'm pretty sure this works?
	}
	
	public void getShot() {
		energy -= 9;
	}
	
	public void drawInfo(Graphics2D g, int w, int h) {
		AffineTransform at = g.getTransform();
		g.translate(loc.x,loc.y);
		
		Font f = new Font("Arial", Font.BOLD, 9);
		g.setFont(f);
		
		g.translate( -30, -50);
		
		g.setColor(Color.white);
		
		String energyString = String.format("%.2f", energy);
		g.drawString("Energy: " + energyString, 0, 0);
		
		String speedXString = String.format("%.2f", vel.x);
		g.drawString("Speed X: " + speedXString, 0, 15);
		
		String speedYString = String.format("%.2f", vel.y);
		g.drawString("Speed Y: " + speedYString, 0, 30);
		
		g.setTransform(at);
	}
	
	protected void setAttributes() {	
		leftArc = new QuadCurve2D.Double(0, 0, 10, 10, -15, -40);		// LEFT ANTENNA
		rightArc = new QuadCurve2D.Double(0, 0, 10, 10, 18, -40);
		
		outline = new Area();
		outline.add(new Area(body));
		outline.add(new Area(leftDot));
		outline.add(new Area(rightDot));
		outline.add(new Area(butt));
		outline.add(new Area(shell));
	}
	
	protected void setCircleAttributes() {
		butt = new Ellipse2D.Double(-15, buttAnimation, 30, 51); 		  // SNAIL ASS
		body = new Ellipse2D.Double(-bodyW /2 , -bodyH /2, bodyW, bodyH); // SNAIL BODY
		shell = new Ellipse2D.Double(-20, -15, 41, 50);					  // SNAIL SHELL
		rightDot = new Ellipse2D.Double(-18, -43, eyeSize, eyeSize);	  // RIGHT DOT
		leftDot = new Ellipse2D.Double(15, -42, eyeSize, eyeSize);		  // LEFT DOT
	}
	
	protected void updateFeeler() {
		double angle = vel.heading(); // ask the TA about this...
		double changeAngle = Math.toRadians(90);
		angle = angle + changeAngle;
		
		AffineTransform at = new AffineTransform(); 
		at.translate(loc.x, loc.y);
		at.rotate(angle);
		at.scale(scale, scale);
		
//		follow this ratio
//		fov = new Arc2D.Double(-sight, -sight, sight*2, sight*2, -55, 110, Arc2D.PIE);  // new arc 

		fov = new Arc2D.Double( -75, -75, 150, 150, 50, 70, Arc2D.PIE);
		fovBox = new Area(fov);
	}
	
	public Shape getFeeler() {
		  double angle = vel.heading(); // ask the TA about this...
		  double changeAngle = Math.toRadians(90);
		  angle = angle + changeAngle;
		  
		  AffineTransform at = new AffineTransform();
	      at.translate(loc.x, loc.y);
	      at.rotate(angle);
	      at.scale(scale, scale);
	      return at.createTransformedShape(fovBox);
	}
	
	public abstract void drawSnail(Graphics2D g) ;
	
	public abstract void drawInfoToggle(Graphics2D g);
	
	public void move() {
		vel.normalize().mult(maxSpeed);
		
		float speedValue = vel.mag();
		
		PVector wallSteerAccel = wallPushForce().div((float)scale);
		// to make it turn on the wall steering acc
		vel.add(wallSteerAccel);
		
		vel.normalize().mult(speedValue);
		
		loc.add(vel);
		
		//checkCollision();
		wallPushForce();
	}
	
	public Shape getTranslatedShape() {
		double angle = vel.heading(); // ask the TA about this...
		double changeAngle = Math.toRadians(90);
		angle = angle + changeAngle;
		
		AffineTransform at = new AffineTransform(); 
		at.translate(loc.x, loc.y);
		at.rotate(angle);
		at.scale(scale, scale);
		return at.createTransformedShape(outline);
	}
	
	public void checkCollision() {
		int panelSizeW = 1200;
		int panelSizeH = 800;
		
		Rectangle2D.Double top = new Rectangle2D.Double(50, 50, panelSizeW, 10);
		Rectangle2D.Double bottom = new Rectangle2D.Double(50, panelSizeH - 50, panelSizeW - 50, 10);
		Rectangle2D.Double left = new Rectangle2D.Double(50, 50, 10, panelSizeH -50 );
		Rectangle2D.Double right = new Rectangle2D.Double(panelSizeW - 50, 50, 10, panelSizeH - 50);

		if (getTranslatedShape().intersects(left) && vel.x < 0) {
			vel.x *= -1;
		}
		if (getTranslatedShape().intersects(right) && vel.x > 0) {
			vel.x *= -1;
		}
		if (getTranslatedShape().intersects(top) && vel.y < 0) {
			vel.y *= -1;
		}
		if (getTranslatedShape().intersects(bottom) && vel.y > 0) {
			vel.y *= -1;
		}
		
	}
	
	PVector wallPushForce() {
		PVector force = new PVector();
		float wallCoef = 200.0f;
		
		// compute force based on distance from edge
		double distance = 0;
		
		distance = SnailPanel.leftEdge.ptLineDist(loc.x, loc.y) - bodyW * scale;
		force.add(new PVector((float) (+wallCoef / Math.pow(distance, 2)), 0.0f)); //left wall force
		
		distance = SnailPanel.rightEdge.ptLineDist(loc.x, loc.y) - bodyW * scale;
		force.add(new PVector((float) (-wallCoef / Math.pow(distance, 2)), 0.0f)); //right wall force
		
		distance = SnailPanel.topEdge.ptLineDist(loc.x, loc.y) - bodyH * scale;
		force.add(new PVector(0.0f, (float) (+wallCoef / Math.pow(distance, 2))));	//top wall force
		
		distance = SnailPanel.bottomEdge.ptLineDist(loc.x, loc.y) - bodyH * scale;
		force.add(new PVector(0.0f, (float) (-wallCoef / Math.pow(distance, 2))));	//bottom wall force
		
		return force;
	}
	
	public boolean detectCollision(Animal a) {	
		if (getTranslatedShape().intersects(a.getTranslatedShape().getBounds2D()) 
				&& a.getTranslatedShape().intersects(getTranslatedShape().getBounds2D())) {
			return true;
		}
		return false;
	} 
	
	public boolean eat(Animal animal) {
		if (checkHeadOn(animal)) {
			System.out.println("eat function through");
			return true;
		}
		return false;
	}
	
	protected boolean checkHeadOn(Animal animal) {
		if (vel.x * animal.vel.x < 0 && vel.y * animal.vel.y < 0) {
			return true;
		}
		return false;
	}

	
	public PVector getLoc() { 								             // Return location
		return loc;
	}
	
	public Color getColor() {
		return myColor;
	}
	
	public double getScale() {
		return scale;
	}
	
	public double getEnergy() {
		return energy;
	}
	
	
}
