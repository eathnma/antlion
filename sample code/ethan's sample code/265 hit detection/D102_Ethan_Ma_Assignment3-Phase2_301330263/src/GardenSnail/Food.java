package GardenSnail;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.event.MouseEvent;
import java.awt.geom.AffineTransform;
import java.awt.geom.Arc2D;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Line2D.Double;
import java.awt.geom.Line2D.Double;

import processing.core.PVector;


public class Food {
	private Ellipse2D.Double baseLeaf;
	private Line2D.Double topLeft;
	private Line2D.Double topRight;
	private Line2D.Double bottomLeft;
	private Line2D.Double bottomRight;
	private Line2D.Double middle;
	
	private int attraction;
	private PVector loc;
	private int leafWidth, leafHeight;
	private double scale;
	private Color seedColor;
	
	private Area outline;
	
	public Food(double sc, int x, int y) {
//		loc = new PVector((float) ((SnailPanel.GARDEN_X + 20 + Math.random() * (SnailPanel.GARDEN_W - leafWidth - 60))),
//				(float) ((SnailPanel.GARDEN_Y + 20 + Math.random() * (SnailPanel.GARDEN_H - leafHeight - 60))));
		loc = new PVector(x, y);
		scale = sc;
		leafWidth = 50;
		leafHeight = 20;
		
		topLeft = new Line2D.Double();
		topRight = new Line2D.Double();
		bottomLeft = new Line2D.Double();
		bottomRight = new Line2D.Double();
		middle = new Line2D.Double();
		
		setAttributes();
	}
	
	public PVector getLoc() {
		return loc;
	}
	
	public void setLoc(int x, int y) {
		loc = new PVector( x, y );
	}

	public void setColor(Color color) {
		seedColor = color;
	}
	
	public double getScale() {
		return scale;
	}
	
	public boolean checkMouseHit(MouseEvent e) {
		return  (Math.abs(e.getX() - loc.x) < leafWidth/2 * scale) &&
	            (Math.abs(e.getY() - loc.y) < leafHeight/2 * scale);
	}
	
	public void enlarge(double incr) {
		scale = scale + incr;
	}
	
	public double getS() {
		return scale;
	}

	public void setAttributes() {
		// BASE LEAF
		this.baseLeaf = new Ellipse2D.Double(0, 0, leafWidth, leafHeight);
		
		outline = new Area(baseLeaf);
		
		//TOP LEFT LINE
		topLeft.setLine(20, 10, 10, 17);
		// TOP RIGHT LINE
		topRight.setLine(40, 10, 25, 0);
		// BOTTOM LEFT LINE
		bottomLeft.setLine(20, 10, 10, 3);
		// BOTTOM RIGHT LINE
		bottomRight.setLine(40, 10, 25, 20);
		// MIDDLE 
		middle.setLine(0, 10, 50, 10);
	}

public Shape getTranslatedShape() {
		AffineTransform af = new AffineTransform();
		af.translate(loc.x, loc.y);
		af.scale(scale, scale);
		return af.createTransformedShape(baseLeaf);
	}

public void drawFood(Graphics2D g) {
		Graphics2D g2 =(Graphics2D) g;
	
		AffineTransform at = g2.getTransform();
		g2.translate(loc.x, loc.y);
		g2.scale(scale, scale);
		
		g2.setColor(seedColor);
		g2.draw(baseLeaf);
		g2.fill(baseLeaf);
		
		// LINES ON THE LEAVES
		g2.setColor(Color.black);
		g2.setStroke(new BasicStroke(2)); // stroke thickness
		g2.draw(middle);
		
		g2.setStroke(new BasicStroke(1)); // stroke thickness
		g2.draw(bottomLeft); // bottom left
		g2.draw(topLeft); // top left
		g2.draw(bottomRight); // bottom right
		g2.draw(topRight); // top right
		
		g2.setTransform(at);
		
		g.setColor(Color.PINK);
		g.draw(getTranslatedShape().getBounds2D());
	}
}
