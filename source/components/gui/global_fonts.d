module components.gui.global_fonts;

import fluid;
import fluid.typeface;
import fluid.theme;
import raylib;

__gshared Typeface minecraftFont;

static this() {
    minecraftFont = Style.loadTypeface("./source/resources/fonts/minecraft_font.ttf");
}