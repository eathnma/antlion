package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.event.MouseEvent;
import java.awt.Panel;
import java.awt.geom.AffineTransform;
import java.awt.geom.Arc2D;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.awt.geom.QuadCurve2D;
import java.awt.geom.Rectangle2D;
import java.awt.geom.Rectangle2D.Double;
import java.util.ArrayList;

import processing.core.PVector;

public class Snail extends Animal {
	
	private double FieldforRequirement = 1;
	
	// Snail Constructor
	public Snail(float x, float y, int w, int h, double sc, int eyeS) {
		super(x, y, w, h, sc, eyeS); // calling the super from the animal class
		updateFeeler();
		maxSpeed = 1;
		energy = 80;
	}
	
	public PVector getLoc() { 								             // Return location
		return loc;
	}
	
	public double getScale() {
		return scale;
	}
	
	//int test = 0;
	
	public void runAway(Snailzilla s) {
		//System.out.println("running away");		
		FieldforRequirement = 2;
		maxSpeed = 2;
		float angle = (float) Math.atan2(loc.y - s.loc.y, loc.x - s.loc.x);
		
		vel = PVector.fromAngle(angle);
		vel.mult(maxSpeed);
	}
	
	protected void findClosestLeaf(ArrayList<Food> leafList) {
//		if(leafList.size() == 0) { 											 		// if the size of the array is 0, don't run this
//			moveToTarget(null);
//			return null; 
//		}
		if (leafList.size() > 0) {
		
		Food closestLeaf = leafList.get(0); 								 		// typecast this to the first array object?
//		float distToTarget = PVector.dist(loc, closestLeaf.getLoc());
		double attractiveness = closestLeaf.getScale() * PVector.dist(getLoc(), closestLeaf.getLoc());
		
		for (Food l : leafList) if ( PVector.dist(this.getLoc(), l.getLoc()) < attractiveness){ 			// look for the smallest one
				closestLeaf = l; 		
//				distToTarget = PVector.dist(loc, closestLeaf.getLoc());
				attractiveness = closestLeaf.getScale() * PVector.dist(getLoc(), closestLeaf.getLoc());	
			}
		closestLeaf.setColor(this.getColor());
		this.moveToTarget(closestLeaf);	
		}
	}
	
	private void foodEnergy(Food f) {
			energy += 4 * f.getScale();
	}

	public void hunt(ArrayList<Food> leafList) {
		findClosestLeaf(leafList);
		//move();
		for( int i = 0; i < leafList.size(); i++) {
			if(collidesFood(leafList.get(i))) {
				foodEnergy(leafList.get(i));
				leafList.remove(i);
				leafList.add(new Food((double)Math.random() * 1.1 + 1.3, 
			              (int)Util.random(50 + 20, 1150 - 20), 
			              (int)Util.random(50 + 20, 750 - 20)
			              ));
			}
		}
	}
	
	protected void moveToTarget(Food food) {
		PVector target = null;
		if(food!= null)
			target = food.getLoc();
		
		PVector accel = new PVector (0,0);
		if(target != null) {
			PVector path = PVector.sub(target, getLoc());
			path.normalize();
			path.mult((float)0.5);
			accel.add(path);
		}
		vel.add(accel);
		vel.limit(maxSpeed);
		
		// return wall push forces, compute acc
		PVector wallSteerAccel = wallPushForce().div((float)scale);
		
		float speedValue = vel.mag();
		
		// make it turn on wall steering acc
		vel.add(wallSteerAccel);
		
		vel.normalize().mult(speedValue);
		
		loc.add(vel);
		
	}
	
	public boolean collidesFood(Food food) {
		return (getTranslatedShape().intersects(food.getTranslatedShape().getBounds2D()) &&
		        (food.getTranslatedShape().intersects(getTranslatedShape().getBounds2D())) );
	}

	@Override
	public void drawSnail(Graphics2D g) {
		Graphics2D g2 =(Graphics2D) g;
		
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
		
		g2.setColor(Color.black);
		// draw right eye
		g2.draw(rightDot);
		g2.fill(rightDot);
		
		// draw left eye
		g2.draw(leftDot);
		g2.fill(leftDot);
	
		g2.setTransform(at);
		
		g2.setStroke(new BasicStroke(1));
		g2.setColor(Color.PINK);
		g2.draw(getTranslatedShape().getBounds2D());
	
	}
	
	public void drawInfoToggle(Graphics2D g) {
		drawInfo(g, -60, -175);
	}
}


