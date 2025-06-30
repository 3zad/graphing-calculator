import raylib;

import components.settings;
import components.gui.gui;
import components.grid;
import components.functions;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

import components.state;

void main()
{

    State state = State();

    Grid grid = new Grid();
    Gui gui = new Gui(&state);

    InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(30);

    scope (exit)
        CloseWindow();

    int z = 1;

    while (!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(Colors.BLACK);

        if (!state.paused)
        {
            Functions.middleSum(-5, 5, z, 1);
            grid.grid();
            grid.graph();
            z++;
        }
        gui.draw();
        EndDrawing();
    }
}
