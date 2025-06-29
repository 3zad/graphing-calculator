import raylib;

import components.settings;
import components.gui;
import components.grid;
import components.functions;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

import components.state;

void main() {


    Grid grid = new Grid();
    Gui gui = new Gui(State());

    //Create window
	InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(30);

    scope (exit) CloseWindow();

    int z = 1;

	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        Functions.middleSum(-5, 5, z, 1);
        grid.grid();
        grid.graph();
        gui.draw();
        EndDrawing();
        
        if (z < 10) {
            z++;
        }
	}
}