package GardenSnail;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.util.ArrayList;

import processing.core.PVector;

public class Missile {

	private PVector pos, speed;
	private double size;
	private Ellipse2D missile;
	private float maxSpeed;
	
	private Area outline;
	
	public Missile(float x, float y, float speedx, float speedy) {
		pos = new PVector(x,y);
		speed = new PVector(speedx,speedy);
		size = 0.8;
		maxSpeed = 30;
		setShapeAttributes();
		setOutline();
	}
	
	private void setShapeAttributes() {
		missile = new Ellipse2D.Double( 0, 0, 10, 10);
	}
	
	public void drawMissile(Graphics2D g) {
		AffineTransform at = g.getTransform();
		g.translate(pos.x, pos.y);
		g.scale(size, size);
		g.setColor(Color.BLACK);
		g.fill(missile);
		g.setTransform(at);
	}
	
	private Shape getTranslatedShape() {
		AffineTransform at = new AffineTransform();
		at.translate(pos.x, pos.y);
		at.scale(size, size);
		at.rotate(speed.heading());
		return at.createTransformedShape(outline);
	}

	private void setOutline() {
		outline = new Area(missile);
	}
	
	public void moveMissile() {
	    pos.add(speed);
	}
	
	private void findBiggestSnailzilla(ArrayList <Animal> animalList) {
		Animal biggestSnailzilla = animalList.get(0);
		
		for(Animal a : animalList) {
			if(biggestSnailzilla instanceof Snailzilla) {
				Snailzilla sz = (Snailzilla) animalList.get(0);
				double biggest = sz.getScale();
				
				if(sz.getScale() < biggest) {
					biggestSnailzilla = a;
					biggest = sz.getScale();
				}
			}
		}
		moveToSnailzilla(biggestSnailzilla);
	}
	
	public PVector getPos() {
		return pos;
	}
	
	private void moveToSnailzilla(Animal s) {
		
		PVector accel = new PVector(0,0);
		
		PVector path = PVector.sub(s.getLoc(), getPos());
		
		accel.add(path);
		speed.add(accel);
		speed.limit(maxSpeed);
	}
	
	public void update(ArrayList<Animal> animalList, ArrayList<Missile> missileList) {
		moveMissile();
		findBiggestSnailzilla(animalList);
	
		for(Animal ani : animalList) {
				if(isColliding(ani)) {
					ani.getShot();
					missileList.remove(0);
					break;
				}
			}
		}

	
	private boolean isColliding(Animal other) {
		if (getTranslatedShape().intersects(other.getTranslatedShape().getBounds2D()) 
				&& other.getTranslatedShape().intersects(getTranslatedShape().getBounds2D())){
			return true;
		}
		return false;
	}
}
