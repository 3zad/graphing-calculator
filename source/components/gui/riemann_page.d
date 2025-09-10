module components.gui.riemann_page;

import fluid;
import raylib;

import components.state;
import components.settings;

import std.conv;

import components.gui.themes;

public class RiemannPage
{
    private State* state;
    private Settings* s;
    private void delegate() onClose;

    private Label sumLabel;

    // Public access to the text inputs for use by the main Gui class if needed
    public TextInput equation, leftBound, rightBound, numBars;
    public TextInput animateBarsLowerBound, animateBarsUpperBound, animateBarsStep, animateSpeed;

    public this(State* state, Settings* s, void delegate() onClose) {
        this.state = state;
        this.s = s;
        this.onClose = onClose;
    }

    public Space buildSpace() {
        return vspace(
            Themes.mainTheme(),
            label("Riemann Sums"),

            hspace(
                label("Riemann sum"),
                leftBound = textInput("Lbound"),
                rightBound = textInput("Rbound"),
            ),
            hspace(
                numBars = textInput("Steps"),
                button("Integrate", delegate() @trusted {
                    (*state).leftBound = to!double(leftBound.value);
                    (*state).rightBound = to!double(rightBound.value);
                    (*state).numBars = to!int(numBars.value);
                    (*state).intRange = to!int((*state).rightBound-(*state).leftBound);
                    (*state).displayIntegral = true;
                }),
            ),

            label("Animate"),
            
            hspace(
                animateBarsLowerBound = textInput("Min bars"),
                animateBarsUpperBound = textInput("Max bars"),
                animateBarsStep = textInput("Step"),
                animateSpeed = textInput("Speed"),
            ),

            hspace(
                button("Start", delegate() @trusted {
                    (*state).animate = true;
                    (*state).animateBarsLowerBound = to!int(animateBarsLowerBound.value);
                    (*state).animateBarsUpperBound = to!int(animateBarsUpperBound.value);
                    (*state).animateBarsStep = to!int(animateBarsStep.value);
                    (*state).animateSpeed = to!int(animateSpeed.value);
                    (*state).displayIntegral = true;
                }),
                button("Stop", delegate() @trusted {
                    (*state).animate = false;
                    (*state).displayIntegral = false;
                }),
            ),

            sumLabel = label("nan"),

            button(.layout!"center", "Close", delegate() @trusted {
                onClose();
            })
        );
    }

    public void update() {
        sumLabel.text = to!string((*state).integrationResult);
    }
}