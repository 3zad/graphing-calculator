module components.gui.gui;

import fluid;
import fluid.theme;
import raylib;

import components.grid;
import components.settings;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

import components.state;
import components.gui.color_palette;
import components.gui.global_fonts : minecraftFont;

public class Gui
{
    private State* state;
    private Space root;
    private enum Page { welcome, settings, clear }
    private Page currentPageState;

    // Public access
    public TextInput equation;
    public FloatInput leftBound, rightBound;

    public this(State* state) {
        this.state = state;

        currentPageState = Page.welcome;
        root = buildRootSpace();
    }

    private Space buildRootSpace()
    {
        switch (currentPageState)
        {
            case Page.welcome:
                return vspace(
                    introTheme(),
                    .layout!"center", vframe(
                        label(.layout!"center", "Graphing Calculator"),
                        button(.layout!"center", "Continue", delegate() @trusted {
                            currentPageState = Page.clear;
                            (*state).paused = false;
                            root = buildRootSpace();
                        })),
                    //imageView(.layout!"center", "image.png", Vector2(200, 200)),
                );

            case Page.settings:
                return settingsPage();

            case Page.clear:
                return clearPage();

            default:
                return vspace(label("Error: Unknown Page State. Please contact the developer."));
        }
    }

    private Space settingsPage() {
        return vspace(
            mainTheme(),
            label("settings page"),
            hspace(
                equation = textInput("Equation...", delegate {
                    (*state).equation = to!string(equation.value);
                }),
                button("Graph", delegate() @trusted {
                    (*state).equation = to!string(equation.value);
                })
            ),

            vspace(
                label("Riemann sum"),
                hspace(
                    label("Left bound: ")
                ),
                hspace(
                    label("Right bound: ")
                ),
            ),

            button(.layout!"center", "Close", delegate() @trusted {
                currentPageState = Page.clear;
                root = buildRootSpace();
            })
        );
    }

    private Space clearPage() {
        return vspace(
            mainTheme(),
            button(.layout!"center", "Settings", delegate() @trusted {
                currentPageState = Page.settings;
                root = buildRootSpace();
            })
        );
    }

    public void draw()
    {
        root.draw();
    }

    private Theme mainTheme() {
        return Theme(
            rule!Label(
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
            )
        );
    }

    private Theme introTheme() {

        return Theme(
            rule!GridRow(margin = 100),
            rule!Button(
                typeface = minecraftFont,
                backgroundColor = color(UIColors.primary),
                textColor = color(UIColors.textColor),
                margin = 10,
                padding = 5,
            ),

            rule!Frame(
                backgroundColor = color(UIColors.background),
            ),
            rule!Label(
                typeface = minecraftFont,
                textColor = color(UIColors.textColor),
            )
        );
    }
}
