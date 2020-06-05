package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;
import java.util.ArrayList;

import processing.core.PVector;

public class HunterSnail extends Animal {
	private Rectangle2D.Double gunBarrel;
	private Rectangle2D.Double gunTip;
	
//	public ArrayList <Missile> missileList = new ArrayList<Missile>();
	
	public float health = 100;
	
	public HunterSnail(float x, float y, int w, int h, double sc, int eyeS) {
		super(x,y,w,h,sc,eyeS);
		setGun();
		maxSpeed = 4;
	}
	
	public void update() {
		move();
	}
	
	public void fire(ArrayList<Missile> missileList) {
//		PVector mSpeed = PVector.fromAngle(vel.heading()).mult(5);
		missileList.add(new Missile(loc.x + 35, loc.y - 3, 12, 1));
		//System.out.println("spacebar_fire status");
	}
	
	private void setGun() {
		gunBarrel = new Rectangle2D.Double(-5, -35, 10, 43);
		gunTip = new Rectangle2D.Double(-2.5, -40, 5, 5);
	}

	@Override
	public void drawSnail(Graphics2D g) {
		
		Graphics2D g2 =(Graphics2D) g;
		
		double angle = Math.toRadians(90); // ask the TA about this...
		
		AffineTransform at = g2.getTransform();
		
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		g2.rotate(angle);
		
		g2.setStroke(new BasicStroke(1));
		
//		g2.setColor(Color.red);
//		g2.draw(fov);

		//black butt
		g2.setColor(Color.black);
		butt.setFrame(-15, buttAnimation, 30, 51);
		g2.draw(butt);
		g2.fill(butt);
		
		// draw antenna
		g2.draw(leftArc);
		g2.draw(rightArc);
	
		// draw body
		g2.setColor(new Color(117,76,36)); // set color of snail to dark brownd
		g2.draw(body);
		g2.fill(body);
		
		// SHELL
		g2.setColor(myColor); // set randomized colour
		
		g2.draw(shell);
		g2.fill(shell);
		
		g2.setColor(Color.RED);
		// draw right eye
		g2.draw(rightDot);
		g2.fill(rightDot);
		
		g2.setColor(Color.white);
		// draw left eye
		g2.draw(leftDot);
		
		// draw gun barrel
		g2.setColor(new Color(102,102,102));
		g2.fill(gunBarrel);
		
		// draw gun tip
		g2.setColor(Color.BLACK);
		g2.fill(gunTip);
	
		g2.setTransform(at);
	}
	
	public void move() {
		vel.x = 0;
		vel.normalize().mult(maxSpeed);
		loc.add(vel.x,vel.y);
		checkCollision();
	}
	
	public void drawInfo(Graphics2D g, int w, int h){
		AffineTransform at = g.getTransform();
		g.translate(loc.x,loc.y);
		
		Font f = new Font("Arial", Font.BOLD, 12);
		g.setFont(f);
		
		g.translate( -35, -30);
		
		g.setColor(Color.BLACK);
		
		String healthString = String.format("%.2f", health);
		g.drawString("Health: " + healthString, 0, 0);
		
		g.setTransform(at);
	}

	@Override
	public void drawInfoToggle(Graphics2D g) {
		drawInfo(g, -60, -175);
	}
}
