import java.util.HashSet;

class Graph {
  ArrayList<GraphNode> nodes;
  ArrayList<GraphEdge> edges;

  Graph() {
    nodes = new ArrayList<GraphNode>();
    edges = new ArrayList<GraphEdge>();
  }

  boolean addNode(GraphNode newNode) {
    if (nodes.contains(newNode)) {
      return false;
    }
    for (GraphNode n : nodes) {
      if (n.x == newNode.x && n.y == newNode.y) {
        return false;
      }
    }
    nodes.add(newNode);
    return true;
  }

  GraphNode getNode(float x, float y) {
    for (GraphNode n : nodes) {
      if (n.x == x && n.y == y) {
        return n;
      }
    }
    return null;
  }
  //TODO:check if it is already contained 
  boolean addEdge(GraphNode a, GraphNode b) {

    if (nodes.contains(a)&&nodes.contains(b)) {

      for (GraphEdge edge : edges) {
        if (edge.a ==a && edge.b == b) {
          return false;
        }
      }
      edges.add(new GraphEdge(a, b));
      return true;
    }
    return false;
  }

  GraphEdge getDirectionalEdge(GraphNode a, GraphNode b) {
    if (nodes.contains(a)&&nodes.contains(b)) {
      for (GraphEdge edge : edges) {
        if (edge.a == a && edge.b == b) {
          return edge;
        }
      }
    }
    return null;
  }

  GraphEdge getEdge(GraphNode a, GraphNode b) {
    if (nodes.contains(a)&&nodes.contains(b)) {
      for (GraphEdge edge : edges) {
        if ((edge.a == a && edge.b == b) || (edge.a == b && edge.b == a)) {
          return edge;
        }
      }
    }
    return null;
  }

  boolean deleteEdge(GraphNode a, GraphNode b) {
    return deleteEdge(getEdge(a, b));
  }

  boolean deleteEdge(GraphEdge edge) {
    //checks if the edge is in the graph and removes it
    if (edges.remove(edge)) {
      edge.invalidate();
      return true;
    }
    //else notify the client the edge is not in the graph
    else {
      return false;
    }
  }

  boolean deleteNode(GraphNode a) {
    if (nodes.contains(a)) {
      ArrayList<GraphEdge> toDelete = new ArrayList<GraphEdge>();
      for (GraphEdge edge : a.edges) {
        toDelete.add(edge);
      }
      for (GraphEdge remove : toDelete) {
        remove.invalidate();
        edges.remove(remove);
      }
      return true;
    }
    return false;
  }
  //TODO: refactor
  //TODO: make sure it removes or avoids duplicates as well
  boolean mergeInto(GraphNode a, GraphNode b) {

    if (nodes.contains(a)&&nodes.contains(b)) {
      deleteEdge(a, b);
      ArrayList<GraphEdge> toDelete = new ArrayList<GraphEdge>();
      for (GraphEdge edge : a.edges) {
        GraphNode other = edge.getOtherNode(a);
        if (!other.isConnected(b)) {
          addEdge(other, b);
        }
        toDelete.add(edge);
      }
      for (GraphEdge remove : toDelete) {
        remove.invalidate();
        edges.remove(remove);
      }
      nodes.remove(a); 
      return true;
    } 
    return false;
  }

  GraphNode getClosestNodeInRadius(float x, float y, float radius) {
    GraphNode returnedNode = null;
    float minDistance = radius;
    for (GraphNode currentNode : nodes) {
      float distDiff = dist(x, y, currentNode.x, currentNode.y);
      if (distDiff<minDistance) {
        returnedNode=currentNode;
        minDistance=distDiff;
      }
    }
    return returnedNode;
  }
  ArrayList<GraphNode> getNodesInRadius(float x, float y, float radius) {
    ArrayList<GraphNode> returnedNodes = new ArrayList<GraphNode>();
    
    for (GraphNode currentNode : nodes) {
      float distDiff = dist(x, y, currentNode.x, currentNode.y);
      if (distDiff<radius) {
        returnedNodes.add(currentNode);
      }
    }
    return returnedNodes;
  }

  GraphNode getClosestUnconnectedNode(GraphNode sourceNode, float distance) {
    GraphNode returnedNode = null;

    //make a list of connected nodes and their respective connections
    //i.e.up to second degree connections
    HashSet<GraphNode> neighbours = new HashSet<GraphNode>();
    neighbours.add(sourceNode);
    for (GraphEdge edge : sourceNode.edges) {
      GraphNode connectedNode = edge.getOtherNode(sourceNode);
      neighbours.add(connectedNode);
      for (GraphEdge secondaryEdge : connectedNode.edges) {
        neighbours.add(secondaryEdge.getOtherNode(connectedNode));
      }
    }

    //find the closest node not in the list of second degree connections
    float minDistance = distance;
    for (GraphNode currentNode : nodes) {
      float distDiff = dist(sourceNode.x, sourceNode.y, currentNode.x, currentNode.y);
      if (distDiff<minDistance && !neighbours.contains(currentNode)) {
        returnedNode=currentNode;
        minDistance=distDiff;
      }
    }
    return returnedNode;
  }

  boolean snapToClosestNode(GraphNode sourceNode, float distance) {
    GraphNode destinationNode = getClosestUnconnectedNode(sourceNode, distance);
    if (destinationNode!=null) {
      mergeInto(sourceNode, destinationNode);
      return true;
    }
    return false;
  }

  void draw() {
    stroke(0, 255, 0);
    strokeWeight(3);
    for (GraphEdge c : edges) {
      line(c.a.x, c.a.y, c.b.x, c.b.y);
    }
    strokeWeight(5);
    stroke(255, 0, 0);
    for (GraphNode p : nodes) {
      point(p.x, p.y);
    }
  }
}

