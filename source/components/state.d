module components.state;

// global program state
public struct State {
    bool paused = true;
    string equation = "0.1*x*x*x+1/x";
}

__gshared State state;