module components.state;

// global program state
public struct State {
    bool paused = true;
    string equation = "4*(1/(1+x*x))";

    double leftBound, rightBound;

    double integrationResult;
}

__gshared State state;