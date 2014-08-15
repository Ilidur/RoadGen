class GraphNode {
  float x, y;
  ArrayList<GraphEdge> edges;
  GraphNode (float x, float y) {
    this.x=x;
    this.y=y;
    edges = new ArrayList<GraphEdge>();
  }
  boolean isConnected(GraphNode other) {
    for (GraphEdge edge : edges) {
      if (edge.hasNode(other)) {
        return true;
      }
    }
    return false;
  }
  GraphEdge getEdge(GraphNode other) {
    for (GraphEdge edge : edges) {
      if (edge.hasNode(other)) {
        return edge;
      }
    }
    return null;
  }
}
