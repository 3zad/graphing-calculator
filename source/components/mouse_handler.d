module components.mouse_handler;

import raylib;

import components.state;
import components.settings;

public class MouseHandler {
    private State* state;
    private Settings* s;

    bool isDragging = false;
    Vector2 dragStartPos;

    public this(State* state, Settings* s) {
        this.state = state;
        this.s = s;
    }

    public void update() {
        handlePanning();
        handleScroll();
    }

    private void handlePanning() {
        if (IsMouseButtonPressed(0x0)) {
            isDragging = true;
            dragStartPos = GetMousePosition();
        }

        if (isDragging && IsMouseButtonDown(0x0)) {
            Vector2 currentPos = GetMousePosition();
            Vector2 delta = currentPos - dragStartPos;

            // Fix the panning speed being too fast when zoomed very far in
            s.offsetX -= delta.x / (512) * (10 * s.gridScalingX);
            s.offsetY -= delta.y / (512) * (10 * s.gridScalingY);

            dragStartPos = currentPos;
        }

        // detect mouse release
        if (IsMouseButtonReleased(0x0)) {
            isDragging = false;
        }
    }

    private void handleScroll() {
        if (GetMouseWheelMove() != 0) {
            float wheelMove = GetMouseWheelMove();
            s.gridScalingX *= (1 - wheelMove * 0.1);
            s.gridScalingY *= (1 - wheelMove * 0.1);

            s.inc *= 1/(1 - wheelMove * 0.1);
            s.refresh = true;
        }
    }

    ~this() {
        import std.stdio;
        writeln("byebyeeeee");
    }
}