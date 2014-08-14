class Point {
  float x, y;
  Point (float x, float y) {
    this.x=x;
    this.y=y;
  }
}
class Line {
  Point a, b;
  Line(Point a, Point b) {
    this.a = a;
    this.b = b;
  }
}

class Graph {
  ArrayList<Point> points;
  ArrayList<Line> connections;

  Graph() {
    points = new ArrayList<Point>();
    connections = new ArrayList<Line>();
  }

  boolean addNode(Point newP) {
    if (points.contains(newP)) {
      return false;
    }
    for (Point p : points) {
      if (p.x == newP.x && p.y == newP.y) {
        return false;
      }
    }
    points.add(newP);
    return true;
  }

  Point getNode(float x, float y) {
    for (Point p : points) {
      if (p.x == x && p.y == y) {
        return p;
      }
    }
    return null;
  }

  boolean addConnection(Point a, Point b) {

    if (points.contains(a)&&points.contains(b)) {

      for (Line connection : connections) {
        if (connection.a ==a && connection.b == b) {
          return false;
        }
      }
      connections.add(new Line(a, b));
      return true;
    }
    return false;
  }

  boolean deleteConnection(Point a, Point b) {
    if (points.contains(a)&&points.contains(b)) {
      for (Line connection : connections) {
        if ((connection.a == a && connection.b == b) || (connection.a == b && connection.b == a)) {
          connections.remove(connection);
          return true;
        }
      }
    } 
    return false;
  }

  boolean deleteNode(Point a) {
    if (points.contains(a)) {
      ArrayList<Line> toDelete = new ArrayList<Line>();
      for (Line connection : connections) {
        if (connection.b == a || connection.a == a) {
          toDelete.add(connection); // to stop concurrent modification expection, gather ones to delete first, then delete
        }
      }
      points.remove(a); 
      for (Line remove : toDelete) {
        connections.remove(remove);
      }
      return true;
    }
    return false;
  }

  boolean merge(Point a, Point b) {

    if (points.contains(a)&&points.contains(b)) {
      for (Line connection : connections) {
        if (connection.a == a) {
          connection.a = b;
        } else if (connection.b == a) {
          connection.b = b;
        }
      }
      points.remove(a); 
      return true;
    } 
    return false;
  }

  void draw() {
    stroke(0, 255, 0);
    strokeWeight(3);
    for (Line c : connections) {
      line(c.a.x, c.a.y, c.b.x, c.b.y);
    }
    strokeWeight(5);
    stroke(255, 0, 0);
    for (Point p : points) {
      point(p.x, p.y);
    }
  }
}

Graph g;

void setup() {

  noLoop();
  g = new Graph();
  Point p1 = new Point(10, 20);
  Point p2 = new Point(20, 30);
  Point p3 = new Point(30, 20);
  g.addNode(p1);
  g.addNode(p2);
  g.addNode(p3);
  g.addConnection(p1, p3);
  //g.addConnection(p1,p2);
  g.addConnection(p3, p2);

  //g.deleteConnection(p2,p3);
  //g.deleteNode(p2);
  // g.merge(p3,p2);
}

void draw() {
  g.draw();
}

