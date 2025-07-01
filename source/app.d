import raylib;

import components.settings;
import components.gui.gui;
import components.grid : grid, graph;
import components.functions : middleSum;

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
    SetTargetFPS(30);

    scope (exit)
        CloseWindow();

    float z = 1;

    while (!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(Colors.BLACK);

        if (!state.paused)
        {
            middleSum(-5, 5, to!int(z)%30, 1);
            grid();
            graph();
            z+=0.1;
        }
        gui.draw();
        EndDrawing();
    }
}
