module components.functions;

import raylib;

import components.settings;
import components.grid;
import components.evaluator;
import components.draw : graphRectangle;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;
import std.regex;

import components.state : state;

void rightSum(double a, double b, int n, double buffer = 0) {
    sumBase(a, b, n, 0, buffer);
}

void leftSum(double a, double b, int n, double buffer = 0) {
    sumBase(a, b, n, 1, buffer);
}

void middleSum(double a, double b, int n, double buffer = 0) {
    sumBase(a, b, n, 0.5, buffer);
}

void sumBase(double a, double b, int n, double rlm, double buffer) {
    double inc = (b-a)/n;
    double i = a+inc;
    double y;
    int count = 0;
    while (i < to!int(b) || count < n) {
        y = evaluateEquation(i-inc*rlm);
        double width = inc*s.gridScalingX-buffer;
        if (width < 1) {
            width = 1;
        }
        graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, width, (y)*s.gridScalingY, Colors.BLUE);
        i += inc;
        count++;
    }
}

void trapezoidalSum(double a, double b, int n, double rlm, double buffer) {
    double inc = (b-a)/n;
    double i = a+inc;
    double y;
    int count = 0;
    while (i < to!int(b) || count < n) {
        y = evaluateEquation(i-inc*rlm);
        graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
        i += inc;
        count++;
    }
}

static double evaluateEquation(double x) {
    return Evaluator(state.equation, x).eval;
}
