module components.state;

// global program state
public struct State {
    bool paused = true;
    string equation = "4*(1/(1+x*x))";

    double leftBound = 0;
    double rightBound = 1;
    int numBars = 10;
    int intRange;
    double integrationResult;
    bool displayIntegral = false;
}

__gshared State state;