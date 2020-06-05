package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Polygon;
import java.awt.geom.AffineTransform;
import java.awt.geom.Arc2D;
import java.awt.geom.Arc2D.Double;

import processing.core.PVector;

import java.awt.geom.Area;
import java.awt.geom.Line2D;

public class Snailzilla extends Animal{
	
	private double angle;
	private double dir;
	private double FieldForRequirement = 0;
	
	private Color myColor;

	public Snailzilla(float x, float y, int w, int h, double sc, int eyeS){
		super( x, y, w, h, sc, eyeS);
		updateFeeler();
		energy = (float) (150 * scale);
		
		this.maxSpeed = (float) ((double) (Math.random() * 1) + 1.2);
		
		int red = 	 (int) (Math.random()* 255 + 0);
		int green =  (int) (Math.random()* 255 + 0);
		int blue =   (int) (Math.random()* 255 + 0);
		
		myColor = new Color (red, green, blue);
	}
	
	public void moveVeryFast(Snail s) {
		maxSpeed = 3;
		PVector accel = new PVector(0,0);
		//maxSpeed = 10;
		PVector path = PVector.sub(s.getLoc(), getLoc());
		accel.add(path);
		
		vel.add(accel);
		vel.limit(maxSpeed);
	}
	
	public void moveVerySlow() {
		maxSpeed = 2;
	}
	
	public void drawInfo(Graphics2D g, int w, int h) {
		AffineTransform at = g.getTransform();
		g.translate(loc.x,loc.y);
		
		Font f = new Font("Arial", Font.BOLD, 10);
		g.setFont(f);
		
		g.translate( -30, -100);
		
		g.setColor(Color.white);
		
		String energyString = String.format("%.2f", energy);
		g.drawString("Energy: " + energyString, 0, 0);
		
		String speedXString = String.format("%.2f", vel.x);
		g.drawString("Speed X: " + speedXString, 0, 20);
		
		String speedYString = String.format("%.2f", vel.y);
		g.drawString("Speed Y: " + speedYString, 0, 40);
		
		g.setTransform(at);
		
	}
	
	public void drawSnail(Graphics2D g) {
		Graphics2D g2 =(Graphics2D) g;
		
		FieldForRequirement = 1;
		
		double angle = vel.heading(); // ask the TA about this...
		double changeAngle = Math.toRadians(90);
		angle = angle + changeAngle;
		
		AffineTransform at = g2.getTransform();
		
		if(counter < 0) {			// ANIMATION FOR BUTT MOVEMENT
			counterRun = true;
		} else if ( counter > 15 ){
			counterRun = false;
		}
		
		if(counterRun) {
			counter++; 
			buttAnimation += 1;
		} else {
			counter--;
			buttAnimation -= 1;
		}
		
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		g2.rotate(angle);
		
		g2.setStroke(new BasicStroke(1));
		
		g2.setColor(Color.red);
		g2.draw(fov);
		
		//black butt
		g2.setColor(Color.black);
		butt.setFrame(-15, buttAnimation, 30, 51);
		g2.draw(butt);
		g2.fill(butt);
		
		// draw antenna
		g2.draw(leftArc);
		g2.draw(rightArc);
	
		// draw body
		g2.setColor(new Color(117,76,36)); // set color of snail to dark brown
		g2.draw(body);
		g2.fill(body);
		
		// SHELL
		g2.setColor(myColor); // set randomized colour
		g2.draw(shell);
		g2.fill(shell);
		
		g2.setStroke(new BasicStroke(4));
		
		if(energy > 100) {
		// draw right eye
		g2.setColor(Color.white);
		g2.draw(rightDot);
		g2.setColor(Color.black);
		g2.fill(rightDot);
		
		// draw left eye
		g2.setColor(Color.white);
		g2.draw(leftDot);
		g2.setColor(Color.black);
		g2.fill(leftDot);
		}
	
		g2.setTransform(at);
		
		g2.setStroke(new BasicStroke(1));
		g.setColor(Color.PINK);
		g.draw(getTranslatedShape().getBounds2D());
	}	
	
	public void drawInfoToggle(Graphics2D g) {
		drawInfo(g, -60, -175);
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
	
	public boolean checkHeadOn(Animal animal) {
		if (vel.x * animal.vel.x < 0 && vel.y * animal.vel.y < 0) {
			return true;
		}
		return false;
	}
	
	public boolean detectFeeler(Animal a) {
		boolean hit = false;
		if(getFeeler().getBounds2D().intersects(a.getTranslatedShape().getBounds2D()))
			hit = true;
				
		return hit;
	}
	
}
