# Conway's Game of Life in Flutter with Flame

This project implements Conway's Game of Life using the Flutter framework and the Flame game engine. The Game of Life is a cellular automaton devised by mathematician John Conway, where cells on a grid evolve over discrete time steps based on a set of rules.

### Features:

- A grid of size 200x200 cells.
- Interactive grid where users can toggle cell states with a tap.
- Adjustable simulation speed.
- Grid is dynamically centered on the screen, regardless of device size or orientation.

### How It Works:

Each cell in the grid follows these basic rules:

- Any live cell with fewer than two live neighbors dies, as if by underpopulation.
- Any live cell with two or three live neighbors lives on to the next generation.
- Any live cell with more than three live neighbors dies, as if by overpopulation.
- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

### Demo:

![Demo](demo.webm)
