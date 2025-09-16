module components.grid;

import components.settings;
import components.evaluator : evaluateEquation;
import components.draw : graphRectangle, graphLine;

import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;


void grid()
{

    // y-axis
    graphRectangle(0, -s.offsetY/100, 2, GetScreenHeight()-s.gridThickness*GetScreenHeight(), Colors.WHITE);

    // x-axis
    graphRectangle(s.offsetX/100, 0, GetScreenWidth()-s.gridThickness*GetScreenWidth(), 2, Colors.WHITE);

    graphRectangle(50, 10, 20, 20, Colors.WHITE);
    
    // Markers and grid lines
    for (int z = -1; z < 2; z+=2) {
        int markerPos = 0;
        while (markerPos < GetScreenWidth() && markerPos > -GetScreenWidth()) {
            graphRectangle(markerPos, 0, 1, GetScreenHeight(), Colors.GRAY);
            graphRectangle(markerPos, 0, 2, 50, Colors.RED);
            markerPos += z;
        }
    }

    for (int z = -1; z < 2; z+=2) {
        int markerPos = 0;
        while (markerPos < GetScreenHeight() && markerPos > -GetScreenHeight()) {
            graphRectangle(0, markerPos, GetScreenWidth(), 1, Colors.GRAY);
            graphRectangle(0, markerPos, 50, 2, Colors.RED);
            markerPos += z;
        }
    }
}

void graph() {
    for (double z = 10*(-s.offsetX-500); z < 10*(s.graphW-s.offsetX); z += s.inc) {
        double nextY = evaluateEquation(z+s.inc);
        graphLine(z, evaluateEquation(z), z+s.inc, nextY, Colors.RED);
    }
}
