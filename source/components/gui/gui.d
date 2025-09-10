module components.gui.gui;

import fluid;
import fluid.theme;
import raylib;

import components.grid;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

import components.state;
import components.settings;
import components.gui.color_palette;
import components.gui.global_fonts : minecraftFont;
import components.sums : middleSum;

import components.gui.settings_page;

public class Gui
{
    private State* state;
    private Settings* s;

    private Space root;
    private enum Page { welcome, settings, graphSettings, clear }
    private Page currentPageState;

    private Slider!double incSlider;
    private Label incSliderLabel;

    // Public access
    public TextInput equation, leftBound, rightBound, numBars;
    public TextInput scaleXLower, scaleXUpper, scaleYLower, scaleYUpper;

    private SettingsPage settingsPage;

    public this(State* state, Settings* s) {
        this.state = state;
        this.s = s;

        currentPageState = Page.welcome;

        // Switch pages
        this.settingsPage = new SettingsPage(state, s,
            () @trusted {
                currentPageState = Page.graphSettings;
                root = buildRootSpace();
            },
            () @trusted {
                currentPageState = Page.clear;
                root = buildRootSpace();
            }
        );

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
                return settingsPage.buildSpace();

            case Page.clear:
                return clearPage();

            case Page.graphSettings:
                return graphSettingsPage();

            default:
                return vspace(label("Error: Unknown Page State. Please contact the developer."));
        }
    }

    private Space graphSettingsPage() {
        return vspace(
            mainTheme(),
            
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

            button(.layout!"center", "Close", delegate() @trusted {
                currentPageState = Page.settings;
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
            }),
            label(to!string((*state).integrationResult))
        );
    }

    public void draw()
    {
        root.draw();
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
