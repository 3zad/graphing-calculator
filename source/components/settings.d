module components.settings;

public struct Settings {
    //All data immutable by the user
    immutable int WIDTH = 512;
    immutable int HEIGHT = 512;

    //All data mutable by the user
    int graphW = WIDTH;
    int graphH = HEIGHT;

    double gridThickness = 0.025;
    double gridScalingX = 50;
    double gridScalingY = 50;
    double offsetX = 0;
    double offsetY = 0;
    double gridIncPower = 0;
    double gridInc = 0;

    double inc = 0.1;

    //All data mutable by the program
    bool refresh = true;
}

__gshared Settings s;