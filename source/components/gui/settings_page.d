// components/gui/pages/SettingsPage.d
module components.gui.settings_page;

import fluid;
import fluid.theme;
import raylib;

import components.state;
import components.settings;
import components.gui.global_fonts : minecraftFont;
import components.gui.color_palette;

import std.conv;
import std.stdio;

public class SettingsPage
{
    private State* state;
    private Settings* s;
    private void delegate() onGraphSettings, onClose;

    // Public access to the text inputs for use by the main Gui class if needed
    public TextInput equation, leftBound, rightBound, numBars;

    public this(State* state, Settings* s, void delegate() onGraphSettings, void delegate() onClose) {
        this.state = state;
        this.s = s;
        this.onGraphSettings = onGraphSettings;
        this.onClose = onClose;
    }

    public Space buildSpace() {
        return vspace(
            mainTheme(),
            hspace(
                label("Settings"),
                button("Graph settings", delegate() @trusted {
                    onGraphSettings();
                })
            ),
            hspace(
                equation = textInput("Equation..."),
                button("Graph", delegate() @trusted {
                    (*state).equation = to!string(equation.value);
                })
            ),

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
            button(.layout!"center", "Close", delegate() @trusted {
                onClose();
            })
        );
    }
    
    private Theme mainTheme() {
        return Theme(
            rule!Label(
                backgroundColor = color("#fff"),
                typeface = minecraftFont,
            ),
            rule!Button(
                typeface = minecraftFont,
            ),
            rule!TextInput(
                typeface = minecraftFont,
            ),
            rule!FloatInput(
                typeface = minecraftFont,
            ),
            rule!IntInput(
                typeface = minecraftFont,
            ),
            rule!SliderHandle(
                backgroundColor = color("#fff"),
            ),
            rule!AbstractSlider(
                backgroundColor = color("#ddd"),
                lineColor = color("#ddd"),
            ),
        );
    }
}