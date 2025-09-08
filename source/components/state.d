module components.state;

// global program state
public struct State {
    bool paused = true;
    string equation = "4*(1/(1+x*x))";

    double leftBound, rightBound;
    int intRange;
    double integrationResult;
    bool displayIntegral = false;
}

__gshared State state;