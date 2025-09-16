module components.gui.graph_settings_page;

import fluid;

import std.range;
import std.conv;

import components.state;
import components.settings;

import components.gui.themes;

public class GraphSettingsPage {
    private State* state;
    private Settings* s;
    private void delegate() onClose;

    public TextInput scaleXLower, scaleXUpper, scaleYLower, scaleYUpper;

    private Slider!double incSlider;
    private Label incSliderLabel;

    public this(State* state, Settings* s, void delegate() onClose) {
        this.state = state;
        this.s = s;
        this.onClose = onClose;
    }

    public Space buildSpace() {
        return vspace(
            Themes.mainTheme(),
            
            label("Graph Settings"),
            hspace(
                scaleXLower = textInput(""),
                label(" < x < "),
                scaleXUpper = textInput(""),
            ),

            hspace(
                scaleYLower = textInput(""),
                label(" < y < "),
                scaleYUpper = textInput(""),
            ),

            button("Set", delegate() @trusted {
                (*s).gridScalingX = to!int((*s).gridScalingX*0.9);
            }),

            label("Scale graph"),
            hspace(
                button("-", delegate() @trusted {
                    (*s).gridScalingX = to!int((*s).gridScalingX*0.9);
                }),
                label(" x "),
                button("+", delegate() @trusted {
                    (*s).gridScalingX = to!int((*s).gridScalingX*1.1);
                }),
            ),

            hspace(
                button("-", delegate() @trusted {
                    (*s).gridScalingY = to!int((*s).gridScalingY*0.9);
                }),
                label(" y "),
                button("+", delegate() @trusted {
                    (*s).gridScalingY = to!int((*s).gridScalingY*1.1);
                }),
            ),

            label("Shift Graph"),
            hspace(
                button("-", delegate() @trusted {
                    (*s).offsetX -= 100;
                }),
                label(" x "),
                button("+", delegate() @trusted {
                    (*s).offsetX += 100;
                }),
            ),

            hspace(
                button("-", delegate() @trusted {
                    (*s).offsetY += 100;
                }),
                label(" y "),
                button("+", delegate() @trusted {
                    (*s).offsetY -= 100;
                }),
            ),


            hspace(
                label("Graph increment: "),
                incSliderLabel = label(to!string(s.inc)),
            ),
            incSlider = slider!double(
                .layout!"fill",
                iota(0.05,10, 0.05),
                delegate {
                    (*s).inc = to!double(incSlider.value.text);
                    incSliderLabel.text = incSlider.value.text;
                }
            ),

            button("Home", delegate() @trusted {
                s.gridScalingX = 50;
                s.gridScalingY = 50;
                s.offsetX = 0;
                s.offsetY = 0;
            }),

            button(.layout!"center", "Close", delegate() @trusted {
                onClose();
            })
        );
    }
}