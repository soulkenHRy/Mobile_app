import 'package:flutter/material.dart';
import 'flowchart_models.dart';

class FlowchartViewerWidget extends StatefulWidget {
  final Flowchart flowchart;

  const FlowchartViewerWidget({
    super.key,
    required this.flowchart,
  });

  @override
  State<FlowchartViewerWidget> createState() => _FlowchartViewerWidgetState();
}

class _FlowchartViewerWidgetState extends State<FlowchartViewerWidget> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Color _getNodeColor(NodeType type) {
    switch (type) {
      case NodeType.start:
        return Colors.green.shade100;
      case NodeType.process:
        return Colors.blue.shade100;
      case NodeType.decision:
        return Colors.orange.shade100;
      case NodeType.database:
        return Colors.purple.shade100;
      case NodeType.queue:
        return Colors.yellow.shade100;
      case NodeType.endpoint:
        return Colors.green.shade200;
    }
  }

  IconData _getNodeIcon(NodeType type) {
    switch (type) {
      case NodeType.start:
        return Icons.play_circle;
      case NodeType.process:
        return Icons.settings;
      case NodeType.decision:
        return Icons.help;
      case NodeType.database:
        return Icons.storage;
      case NodeType.queue:
        return Icons.queue;
      case NodeType.endpoint:
        return Icons.flag;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Group nodes by subgraph
    final Map<String?, List<FlowNode>> nodesBySubgraph = {};
    for (var node in widget.flowchart.nodes) {
      nodesBySubgraph.putIfAbsent(node.subgraph, () => []).add(node);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flowchart.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              setState(() {
                final matrix = _transformationController.value.clone();
                matrix.multiply(Matrix4.diagonal3Values(1.2, 1.2, 1.0));
                _transformationController.value = matrix;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                final matrix = _transformationController.value.clone();
                matrix.multiply(Matrix4.diagonal3Values(0.8, 0.8, 1.0));
                _transformationController.value = matrix;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _transformationController.value = Matrix4.identity();
              });
            },
          ),
        ],
      ),
      body: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.1,
        maxScale: 4.0,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display subgraphs
              if (widget.flowchart.subgraphs.isNotEmpty) ...[
                Text(
                  'Layers:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var sg in widget.flowchart.subgraphs)
                      Chip(
                        label: Text(sg),
                        backgroundColor: Colors.blue.shade50,
                      ),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // Display nodes grouped by subgraph
              for (var entry in nodesBySubgraph.entries) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (entry.key != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry.key!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                    for (var node in entry.value) _buildNodeCard(node),
                    const SizedBox(height: 16),
                  ],
                ),
              ],

              // Display edges/connections
              const Divider(height: 32),
              Text(
                'Flow Connections (${widget.flowchart.edges.length}):',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              for (var entry in widget.flowchart.edges.asMap().entries)
                _buildEdgeCard(entry.key + 1, entry.value),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeCard(FlowNode node) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: _getNodeColor(node.type),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getNodeColor(node.type).withOpacity(0.7),
            child: Icon(_getNodeIcon(node.type), size: 20),
          ),
          title: Text(
            '${node.id}: ${node.label.replaceAll('\n', ' • ')}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            node.type.name.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEdgeCard(int index, FlowEdge edge) {
    Color edgeColor;
    IconData edgeIcon;

    switch (edge.style) {
      case EdgeStyle.success:
        edgeColor = Colors.green;
        edgeIcon = Icons.check_circle;
        break;
      case EdgeStyle.failure:
        edgeColor = Colors.red;
        edgeIcon = Icons.error;
        break;
      case EdgeStyle.normal:
        edgeColor = Colors.blue;
        edgeIcon = Icons.arrow_forward;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Card(
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: edgeColor.withOpacity(0.2),
            child: Icon(edgeIcon, size: 16, color: edgeColor),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  edge.from,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16, color: edgeColor),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  edge.to,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              if (edge.label != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    edge.label!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
