module components.gui.gui;

import fluid;
import fluid.theme;
import raylib;

import components.grid;

import std.format;
import std.stdio;
import std.conv;

import components.state;
import components.settings;

import components.gui.settings_page;
import components.gui.graph_settings_page;
import components.gui.riemann_page;

import components.gui.themes;

public class Gui
{
    private State* state;
    private Settings* s;

    private Space root;
    private enum Page { welcome, settings, graphSettings, riemann, clear }
    private Page currentPageState;

    private SettingsPage settingsPage;
    private GraphSettingsPage graphSettingsPage;
    public RiemannPage riemannPage;

    public this(State* state, Settings* s) {
        this.state = state;
        this.s = s;

        currentPageState = Page.welcome;

        // Pass in the delegates for page switching 
        this.settingsPage = new SettingsPage(state, s,
            () @trusted {
                currentPageState = Page.graphSettings;
                root = buildRootSpace();
            },
            () @trusted {
                currentPageState = Page.riemann;
                root = buildRootSpace();
            },
            () @trusted {
                currentPageState = Page.clear;
                root = buildRootSpace();
            }
        );

        this.graphSettingsPage = new GraphSettingsPage(state, s,
            () @trusted {
                currentPageState = Page.settings;
                root = buildRootSpace();
            }
        );

        this.riemannPage = new RiemannPage(state, s,
            () @trusted {
                currentPageState = Page.clear;
                root = buildRootSpace();
            }
        );
        // --------------------------------------------

        root = buildRootSpace();
    }

    private Space buildRootSpace()
    {
        switch (currentPageState)
        {
            case Page.welcome:
                return vspace(
                    Themes.introTheme(),
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
                return graphSettingsPage.buildSpace();

            case Page.riemann:
                return riemannPage.buildSpace();

            default:
                return vspace(label("Error: Unknown Page State. Please contact the developer."));
        }
    }

    // Too small to be its own class
    private Space clearPage() {
        return vspace(
            Themes.mainTheme(),
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
}
