// TODO:
/*
    - Ability to import a list of points ex. [(1,2), (2,4), (3,2)...]
    - Random point scatter to calculate the area under a curve enclosed in a box
*/

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
import components.settings : s;
import components.mouse_handler : MouseHandler;
import components.integration_handler : IntegrationHandler;

void main()
{
    // DI for this
    Gui gui = new Gui(&state, &s);

    SetConfigFlags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
    SetConfigFlags(ConfigFlags.FLAG_WINDOW_ALWAYS_RUN);
    InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(1000);

    scope (exit)
        CloseWindow();

    MouseHandler mouseHandler = new MouseHandler(&state, &s);
    IntegrationHandler integrationHandler = new IntegrationHandler(&state, &s, &gui);

    while (!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(Colors.BLACK);

        if (!state.paused)
        {
            grid();
            graph();
            integrationHandler.update();

        }

        mouseHandler.update();

        gui.draw();
        EndDrawing();
    }
}
