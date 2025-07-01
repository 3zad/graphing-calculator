module components.draw;

import components.settings;
import components.evaluator : evaluateEquation;

import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

void graphRectangle(double x, double y, double w, double h, Color c) {
    if (h < 0) {
        h = h*-1;
    }
    DrawRectangleV(Vector2((x*s.gridScalingX+s.WIDTH/2-s.offsetX-w/2), (-y*s.gridScalingY+s.HEIGHT/2-s.offsetY-h/2)), Vector2(w, h), c);
}

void graphLine(double sx, double sy, double ex, double ey, Color c) {
    DrawLineV(Vector2((sx*s.gridScalingX+s.WIDTH/2-s.offsetX), (-sy*s.gridScalingY+s.HEIGHT/2-s.offsetY)), Vector2((ex*s.gridScalingX+s.WIDTH/2-s.offsetX), (-ey*s.gridScalingY+s.HEIGHT/2-s.offsetY)), c);
}
