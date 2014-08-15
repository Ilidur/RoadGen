
Graph g;

void setup() {

  noLoop();
  g = new Graph();
  GraphNode p1 = new GraphNode(10, 20);
  GraphNode p2 = new GraphNode(20, 30);
  GraphNode p3 = new GraphNode(30, 20);
  GraphNode p4 = new GraphNode(50, 20);
  g.addNode(p1);
  g.addNode(p2);
  g.addNode(p3);
  g.addNode(p4);
  g.addEdge(p1, p3);
  g.addEdge(p3, p2);
  g.addEdge(p2, p4);
  

}

void draw() {
  g.draw();
}

