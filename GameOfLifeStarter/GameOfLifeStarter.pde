import java.util.Arrays;

final int SPACING = 9; // each cell's width/height //<>// //<>//
final float DENSITY = 0.2; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
boolean paused = false;

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];

  // STEP 1 - Populate initial grid (you may want to use Arrays.toString to check it)
  for (int row = 0; row < height / SPACING; row++){
    for (int col = 0; col < width / SPACING; col++){
      if (Math.random() < DENSITY){
        grid[row][col] = 1;
      } else {
        grid[row][col] = 0;
      }
    }
  }

}

void draw() {
  showGrid(); // STEP 2 - Implement this method so you can see your 2D array
  if (!paused) {
    grid = calcNextGrid();
  }

}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  
  for (int row = 0; row < grid.length; row++){
    for (int col = 0; col < grid[0].length; col++){
      int neighbors = countNeighbors(row, col);

      boolean bouttaLive = (grid[row][col] == 1 && (neighbors == 2 || neighbors == 3)) || (grid[row][col] == 0 && neighbors == 3);
      nextGrid[row][col] = bouttaLive? 1 : 0;
    }
  }

  // your code here

  return nextGrid;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  
  for (int row = 0; row < height / SPACING; row++){
    for (int col = 0; col < width / SPACING; col++){
      int topNum = 0;
      int bottomNum = 0;
      int leftNum = 0;
      int rightNum = 0;
      int topRight = 0;
      int bottomRight = 0;
      int bottomLeft = 0;
      int topLeft = 0;

      //top
      if (y > 0) topNum = grid[y - 1][x];
      //bottom
      if (y < grid.length - 1) bottomNum = grid[y + 1][x];
      //left
      if (x > 0) leftNum = grid [y][x - 1];
      //right
      if (x < grid.length - 1) rightNum = grid[y][x + 1];
      //top left
      if (y > 0 && x > 0) topLeft = grid[y - 1][x - 1];
      //top right
      if (y > 0 && (x < grid[0].length - 1)) topRight = grid[y - 1][x + 1];
      // bottom left
      if (y < grid.length - 1 && x > 0) bottomLeft = grid[y + 1][x - 1];
      //bottom right
      if (y < grid.length - 1 && x < grid[0].length - 1) bottomRight = grid[y + 1][x + 1];
      //add the numbers
       n = topNum + bottomNum + leftNum + rightNum + topLeft + topRight + bottomLeft + bottomRight;   
    }

  }
    return n;
}

void showGrid() {
  // your code here
  for (int row = 0; row < height / SPACING; row++){
    for (int col = 0; col < width / SPACING; col++){
      if (grid[row][col] == 0){
        fill (214, 212, 212); 
      } else {
        fill (240, 98, 98);
      }
      
      square(col * SPACING, row * SPACING, SPACING);
    }
  }
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
  // each square (cell) has a width and height of SPACING. 
  // you will need to calculate the x and y position as you loop through the grid

}

// i looked up how processing detects a key
void keyPressed() {
  if (key == ' '){
    paused = !paused;
  }
}
