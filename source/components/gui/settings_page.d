module components.gui.settings_page;

import fluid;
import raylib;

import components.state;
import components.settings;

import std.conv;

import components.gui.themes;

public class SettingsPage
{
    private State* state;
    private Settings* s;
    private void delegate() onGraphSettings, onRiemann, onClose;

    // Public access to the text inputs for use by the main Gui class if needed
    public TextInput equation, leftBound, rightBound, numBars;

    public this(State* state, Settings* s, 
        void delegate() onGraphSettings, 
        void delegate() onRiemann, 
        void delegate() onClose
    ) {
        this.state = state;
        this.s = s;
        this.onGraphSettings = onGraphSettings;
        this.onRiemann = onRiemann;
        this.onClose = onClose;
    }

    public Space buildSpace() {
        return vspace(
            Themes.mainTheme(),
            hspace(
                label("Settings"),
                button("Graph settings", delegate() @trusted {
                    onGraphSettings();
                }),
                button("Riemann sums", delegate() @trusted {
                    onRiemann();
                })
            ),
            hspace(
                equation = textInput("Equation..."),
                button("Graph", delegate() @trusted {
                    (*state).equation = to!string(equation.value);
                })
            ),

            button(.layout!"center", "Close", delegate() @trusted {
                onClose();
            })
        );
    }
}