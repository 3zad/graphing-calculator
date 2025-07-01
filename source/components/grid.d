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
    graphRectangle(0, -s.offsetY/100, 2, s.HEIGHT-s.gridThickness*s.HEIGHT, Colors.WHITE);
    graphRectangle(s.offsetX/100, 0, s.WIDTH-s.gridThickness*s.WIDTH, 2, Colors.WHITE);
    
    for (int z = -1; z < 2; z+=2) {
        int markerPos = 0;
        while (markerPos < s.WIDTH-s.offsetX && markerPos > -s.WIDTH-s.offsetX) {
            graphRectangle(markerPos, 0, 2, 50, Colors.RED);
            markerPos += z;
        }
    }

    for (int z = -1; z < 2; z+=2) {
        int markerPos = 0;
        while (markerPos < s.HEIGHT-s.offsetY && markerPos > -s.HEIGHT-s.offsetY) {
            graphRectangle(0, markerPos, 50, 2, Colors.RED);
            markerPos += z;
        }
    }
}

void graph() {
    double inc = 0.1;
    for (double z = 10*(-s.offsetX-500); z < 10*(s.graphW-s.offsetX); z += inc) {
        double nextY = evaluateEquation(z+inc);
        graphLine(z, evaluateEquation(z), z+inc, nextY, Colors.RED);
    }
}
