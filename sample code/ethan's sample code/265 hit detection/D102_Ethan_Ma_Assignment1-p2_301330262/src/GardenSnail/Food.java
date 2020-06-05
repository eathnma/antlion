package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;

import processing.core.PVector;


public class Food {
	
	private PVector loc;
	private int leafWidth, leafHeight;
	private double scale;
	
	public Food(double sc) {
		loc = new PVector((float) ((SnailPanel.GARDEN_X + 20 + Math.random() * (SnailPanel.GARDEN_W - leafWidth - 60))),
				(float) ((SnailPanel.GARDEN_Y + 20 + Math.random() * (SnailPanel.GARDEN_H - leafHeight - 60))));
		scale = sc;
		leafWidth = 50;
		leafHeight = 20;
	}
	
	public PVector getLoc() {
		return loc;
	}
	
	public void drawFood(Graphics2D g2) {

		AffineTransform at = g2.getTransform();
		g2.translate(loc.x, loc.y);
		g2.setColor(Color.green);
		g2.scale(scale, scale);
		
		g2.fillArc(0, 0, leafWidth, leafHeight, 0, 180);
		g2.fillArc(0, 0, leafWidth, leafHeight, 180, 360);
		//g2.drawArc(x, y, width, height, startAngle, arcAngle);
		
		g2.setTransform(at);
		g2.translate(loc.x, loc.y);
		g2.setColor(Color.black);
		g2.scale(scale, scale);
		
		// LINES ON THE LEAVES
		
		g2.setStroke(new BasicStroke(2)); // stroke thickness
		g2.drawLine(0, 10, 50, 10); // line thru middle
		
		g2.setTransform(at);
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		g2.setStroke(new BasicStroke(1)); // stroke thickness
		
		g2.drawLine(20, 10, 10, 3); // bottom left
		
		g2.setTransform(at);
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		
		g2.drawLine(20, 10, 10, 17); // top left
		
		g2.setTransform(at);
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		
		g2.drawLine(40, 10, 25, 20); // bottom right
		
		g2.setTransform(at);
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		
		g2.drawLine(40, 10, 25, 0); // top right
		
		g2.setTransform(at);

	}
}
