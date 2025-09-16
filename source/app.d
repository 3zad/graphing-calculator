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


    bool isDragging = false;
    Vector2 dragStartPos;

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
                    state.currentTicks += 1;

                    // check that enough time has passed to update
                    if (state.currentTicks - state.lastUpdateTicks >= state.animateSpeed) {
                        state.lastUpdateTicks = state.currentTicks;
                        state.numBars += state.animateBarsStep;
                        gui.riemannPage.update();
                    }
                    // Check if we need to reset the number of bars
                    if (state.numBars < state.animateBarsUpperBound) {
                        state.integrationResult = middleSum(state.leftBound, state.rightBound, state.numBars, 1);
                    } else {
                        state.numBars = state.animateBarsLowerBound;
                    }
                } else {
                    state.integrationResult = middleSum(state.leftBound, state.rightBound, state.numBars, 1);
                }
            }
        }

        if (IsMouseButtonPressed(0x0)) {
            isDragging = true;
            dragStartPos = GetMousePosition();
        }

        if (isDragging && IsMouseButtonDown(0x0)) {
            Vector2 currentPos = GetMousePosition();
            Vector2 delta = currentPos - dragStartPos;

            // Fix the panning speed being too fast when zoomed very far in
            s.offsetX -= delta.x / (GetScreenWidth()) * (10 * s.gridScalingX);
            s.offsetY -= delta.y / (GetScreenHeight()) * (10 * s.gridScalingY);

            dragStartPos = currentPos;
        }

        // detect mouse release
        if (IsMouseButtonReleased(0x0)) {
            isDragging = false;
        }

        gui.draw();
        EndDrawing();
    }
}
