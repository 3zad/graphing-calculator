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
import components.sums : middleSum;

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

    while (!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(Colors.BLACK);

        if (!state.paused)
        {
            grid();
            graph();

            if (state.displayIntegral)
            {
                if (state.animate) {
                    if (state.numBars < state.animateBarsUpperBound) {
                        gui.riemannPage.update();
                        state.integrationResult = middleSum(state.leftBound, state.rightBound, state.numBars, 1);
                        state.numBars += state.animateBarsStep;
                    } else {
                        state.numBars = state.animateBarsLowerBound;
                    }
                } else {
                    state.integrationResult = middleSum(state.leftBound, state.rightBound, state.numBars, 1);
                }
            }
        }
        gui.draw();
        EndDrawing();
    }
}
