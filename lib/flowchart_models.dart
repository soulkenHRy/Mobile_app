/// Data models for flowchart visualization

/// Enum for different node types
enum NodeType {
  start,
  process,
  decision,
  database,
  queue,
  endpoint,
}

/// Enum for edge/connection styles
enum EdgeStyle {
  normal,
  success,
  failure,
}

/// Represents a single node in the flowchart
class FlowNode {
  final String id;
  final String label;
  final NodeType type;
  final String? subgraph; // Optional subgraph/layer this node belongs to

  const FlowNode({
    required this.id,
    required this.label,
    required this.type,
    this.subgraph,
  });
}

/// Represents a connection/edge between two nodes
class FlowEdge {
  final String from;
  final String to;
  final String? label;
  final EdgeStyle style;

  const FlowEdge({
    required this.from,
    required this.to,
    this.label,
    this.style = EdgeStyle.normal,
  });
}

/// Represents a complete flowchart with nodes, edges, and metadata
class Flowchart {
  final String title;
  final List<FlowNode> nodes;
  final List<FlowEdge> edges;
  final List<String> subgraphs; // List of layer/subgraph names

  const Flowchart({
    required this.title,
    required this.nodes,
    required this.edges,
    this.subgraphs = const [],
  });
}
