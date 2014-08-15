class GraphEdge {
  GraphNode a, b;
  GraphEdge(GraphNode a, GraphNode b) {
    this.a = a;
    this.b = b;
    this.a.edges.add(this);
    this.b.edges.add(this);
  }
  void invalidate() {
    a.edges.remove(this);
    b.edges.remove(this);
  }

  boolean hasNode(GraphNode c) {
    if (c == a) {
      return true;
    }
    if (c == b) {
      return true;
    }
    return false;
  }

  GraphNode getOtherNode(GraphNode c) {
    if (c == a) {
      return b;
    }
    if (c == b) {
      return a;
    } 
    return null;
  }
}

