module components.integration_handler;

import raylib;

import components.state : State;
import components.settings : Settings;
import components.gui.gui : Gui;

import components.sums : middleSum;

public class IntegrationHandler {
    private State* state;
    private Settings* s;
    private Gui* gui;

    public this(State* state, Settings* s, Gui* gui) {
        this.state = state;
        this.s = s;
        this.gui = gui;
    }

    public void update() {
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
}