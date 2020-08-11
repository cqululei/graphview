part of graphview;

class TreeEdgeRenderer extends EdgeRenderer {
  BuchheimWalkerConfiguration configuration;

  TreeEdgeRenderer(this.configuration);

  var linePath = Path();

  @override
  void render(Canvas canvas, Graph graph, Paint paint) {
    graph.nodes.forEach((node) {
      var children = graph.successorsOf(node);

      children.forEach((child) {
        linePath.reset();
        switch (configuration.orientation) {
          case BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM:
            // position at the middle-top of the child
            linePath.moveTo((child.x + child.width / 2), child.y);
            // draws a line from the child's middle-top halfway up to its parent
            linePath.lineTo(child.x + child.width / 2, child.y - configuration.levelSeparation / 2);
            // draws a line from the previous point to the middle of the parents width
            linePath.lineTo(node.x + node.width / 2, child.y - configuration.levelSeparation / 2);

            // position at the middle of the level separation under the parent
            linePath.moveTo(node.x + node.width / 2, child.y - configuration.levelSeparation / 2);
            // draws a line up to the parents middle-bottom
            linePath.lineTo(node.x + node.width / 2, node.y + node.height);

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP:
            linePath.moveTo(child.x + child.width / 2, child.y + child.height);
            linePath.lineTo(child.x + child.width / 2, child.y + child.height + configuration.levelSeparation / 2);
            linePath.lineTo(node.x + node.width / 2, child.y + child.height + configuration.levelSeparation / 2);

            linePath.moveTo(node.x + node.width / 2, child.y + child.height + configuration.levelSeparation / 2);
            linePath.lineTo(node.x + node.width / 2, node.y + node.height);

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT:
            linePath.moveTo(child.x, child.y + child.height / 2);
            linePath.lineTo(child.x - configuration.levelSeparation / 2, child.y + child.height / 2);
            linePath.lineTo(child.x - configuration.levelSeparation / 2, node.y + node.height / 2);

            linePath.moveTo(child.x - configuration.levelSeparation / 2, node.y + node.height / 2);
            linePath.lineTo(node.x + node.width, node.y + node.height / 2);

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT:
            linePath.moveTo(child.x + child.width, child.y + child.height / 2);
            linePath.lineTo(child.x + child.width + configuration.levelSeparation / 2, child.y + child.height / 2);
            linePath.lineTo(child.x + child.width + configuration.levelSeparation / 2, node.y + node.height / 2);

            linePath.moveTo(child.x + child.width + configuration.levelSeparation / 2, node.y + node.height / 2);
            linePath.lineTo(node.x + node.width, node.y + node.height / 2);
        }
        canvas.drawPath(linePath, paint);
      });
    });
  }
}
