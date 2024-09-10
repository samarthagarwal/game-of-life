import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: GameOfLife()));
}

class GameOfLife extends FlameGame with TapDetector {
  final int rows = 110;
  final int cols = 100;
  late double cellSize;
  late List<List<bool>> grid;
  late List<List<bool>> nextGrid;

  double timeSinceLastUpdate = 0.0;
  final double updateInterval = 1 / 30;
  final gap = 3;

  // Offsets for centering the grid on the screen
  double xOffset = 0.0;
  double yOffset = 0.0;

  @override
  Color backgroundColor() {
    return const Color(0xFF201F30);
  }

  @override
  Future<void> onLoad() async {
    cellSize = size.x / 100.0;
    grid = List.generate(rows, (_) => List.generate(cols, (_) => Random().nextBool()));
    nextGrid = List.generate(rows, (_) => List.generate(cols, (_) => false));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = const Color(0xFFCBCE63);

    // Calculate grid width and height
    double gridWidth = cols * cellSize;
    double gridHeight = rows * cellSize;
    // Get screen size and calculate offsets to center the grid
    xOffset = (size.x - gridWidth) / 2;
    yOffset = (size.y - gridHeight) / 2;

    // Draw the cells
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (grid[row][col]) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(col * cellSize + gap + xOffset, row * cellSize + gap + yOffset, cellSize - gap, cellSize - gap),
              const Radius.circular(2),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastUpdate += dt;

    if (timeSinceLastUpdate >= updateInterval) {
      timeSinceLastUpdate = 0.0;
      // Update grid based on the rules of Conway's Game of Life
      for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
          int neighbors = countNeighbors(row, col);
          if (grid[row][col] && (neighbors < 2 || neighbors > 3)) {
            nextGrid[row][col] = false;
          } else if (!grid[row][col] && neighbors == 3) {
            nextGrid[row][col] = true;
          } else {
            nextGrid[row][col] = grid[row][col];
          }
        }
      }

      // Swap grids
      List<List<bool>> temp = grid;
      grid = nextGrid;
      nextGrid = temp;
    }
  }

  int countNeighbors(int row, int col) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        int newRow = (row + i + rows) % rows;
        int newCol = (col + j + cols) % cols;
        if (grid[newRow][newCol]) count++;
      }
    }
    return count;
  }

  @override
  void onTapDown(TapDownInfo info) {
    final tapPosition = info.eventPosition.widget;

    int row = (tapPosition.y / cellSize).floor();
    int col = (tapPosition.x / cellSize).floor();

    if (row >= 0 && row < rows && col >= 0 && col < cols) {
      print('Tapped on cell at row $row, col $col');
      grid[row][col] = !grid[row][col];
    }
  }
}
