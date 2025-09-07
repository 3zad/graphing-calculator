import raylib;

import components.settings;
import components.gui.gui;
import components.grid : grid, graph;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

import components.state : state;

void main()
{
    // DI for this
    Gui gui = new Gui(&state);

    InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(1000);

    scope (exit)
        CloseWindow();

    while (!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(Colors.BLACK);

        if (!state.paused)
        {
            grid();
            graph();
        }
        gui.draw();
        EndDrawing();
    }
}
