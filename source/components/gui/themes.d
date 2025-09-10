module components.gui.themes;

import fluid;
import fluid.theme;

import components.gui.color_palette;
import components.gui.global_fonts : minecraftFont;

public class Themes {
    public static Theme mainTheme() {
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

    public static Theme introTheme() {

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