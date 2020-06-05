package GardenSnail;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;

import processing.core.PVector;


public class Snail {
	private PVector loc;
	private PVector vel;
	private int bodyW;
	private int bodyH;
	private double scale;
	private int dir = 1;
	private double angle;
	private int eyeSize;
	
	private int buttAnimation = -15;
	
	private Color myColor;
	
	int counter;
	boolean counterRun = false;
	
	// Snail Constructor
	public Snail(PVector loc, int w, int h, double sc, int eyeS) {
		this.loc = loc;
		bodyW = w;
		bodyH = h;
		scale = sc;
		vel = new PVector(1, 1);
		counter = 0;
		eyeSize = eyeS;
		
		int red = 	 (int) (Math.random()* 255 + 0);
		int green =  (int) (Math.random()* 255 + 0);
		int blue =   (int) (Math.random()* 255 + 0);
		
		myColor = new Color (red, green, blue);
	}
	
	public void drawSnail(Graphics2D g2) {
		AffineTransform at = g2.getTransform();
		double angle = vel.heading(); // ask the TA about this...
		double changeAngle = Math.toRadians(90);
		angle = angle + changeAngle;
		
		g2.translate(loc.x, loc.y); // live updates on movements
		g2.scale(scale, scale);
		g2.rotate(angle);
		
		if(counter < 0) {
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
		
		//black butt
		g2.setColor(Color.black);
		g2.fillOval(-15, buttAnimation, 30, 51); // you can randomize the size of the butt here
		
		System.out.println(counter);
		
		g2.setTransform(at);
		
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		g2.rotate(angle);
		
		g2.setColor(Color.black);
		
		// draw antenna
		g2.drawArc(-25, -40, bodyW / 2, bodyH / 2, 0, 90);
		g2.drawArc(5, -40, bodyW / 2, bodyH / 2, 180, -90);
		
		g2.setColor(new Color(117,76,36)); // set color of snail to black
		
		// draw body
		g2.setColor(Color.black);
		
		g2.setColor(new Color(117,76,36)); // set color of snail to dark brown
		g2.fillOval(-bodyW /2 , -bodyH /2, bodyW, bodyH);
		
		g2.setTransform(at);
		
		// SHELL
		
		g2.translate(loc.x, loc.y);
		g2.rotate(angle);
		g2.scale(scale, scale);
		
		g2.setColor(myColor);
		
		g2.drawOval(-20, -15, 41, 50);
		g2.fillOval(-20, -15, 41, 50);
		
		g2.setTransform(at);
		
		g2.translate(loc.x, loc.y);
		g2.rotate(angle);
		g2.scale(scale, scale);
		
		g2.setColor(Color.black);
		
		// draw right eye
		g2.drawOval(-18, -43, eyeSize, eyeSize);
		g2.fillOval(-18, -43, eyeSize, eyeSize);
		
		g2.setTransform(at);
		
		g2.translate(loc.x, loc.y);
		g2.rotate(angle);
		g2.scale(scale, scale);
		
		// draw left eye
	    g2.drawOval(15, -42, eyeSize, eyeSize);
		g2.fillOval(15, -42, eyeSize, eyeSize);
		
		g2.setTransform(at);
	}
	
	boolean approach(PVector targ) { // hasn't been implemented into panel yet
		boolean reach = false;
		
		PVector path = PVector.sub(targ, loc);
		
		float angle = path.heading();
		
		vel = PVector.fromAngle(angle);
		vel.mult(2);
		
		// check if bug reaches target
		if (path.mag()- bodyW / 2 <= 20 ) {
			reach = true;
		}
		
		return reach;
	}
	
	public void move() {
		loc.add(vel);
		parameters(); // MAKE SURE THIS COMES BEFORE DIRECTION!!?
		//walk randomly
		
		angle += 0.03 * dir; 
	    if ( Math.random()*32 < 1) {
	      dir *= -1;
     }
	    vel.set((float) (1* Math.cos(angle)), (float) (1* Math.sin(angle))); 
	}
	
	private void parameters() {
		
		// fix the antenna!?!?!? ( FIX )
		
		// collision right
		if (loc.x + (bodyW / 2 + bodyW / 4 + 20) > (SnailPanel.GARDEN_X + SnailPanel.GARDEN_W)) {
			loc.x = SnailPanel.GARDEN_X + SnailPanel.GARDEN_W - (bodyW / 2 + bodyW / 4 + 20);
			vel.x = -vel.x;
			System.out.println("hit");
		}

		// collision left
		if (loc.x - (bodyW / 2 + bodyW / 4 + 20) < SnailPanel.GARDEN_X) {
			loc.x = SnailPanel.GARDEN_X + (bodyW / 2 + bodyW / 4 + 20);
			vel.x = -vel.x;
			System.out.println("hit");
		}

		// collision bottom
		if (loc.y + (bodyW / 2 + bodyW / 4 + 20) > (SnailPanel.GARDEN_Y + SnailPanel.GARDEN_H)) {
			loc.y = SnailPanel.GARDEN_Y + SnailPanel.GARDEN_H - (bodyW / 2 + bodyW / 4 + 20);
			vel.y = -vel.y;
			System.out.println("hit");
		}
		// collision top
		if (loc.y - (bodyW / 2 + bodyW / 4 + 20) < SnailPanel.GARDEN_Y) {
			loc.y = SnailPanel.GARDEN_Y + (bodyW / 2 + bodyW / 4 + 20);
			vel.y = -vel.y;
			System.out.println("hit");
		}
	  }
	
	}

