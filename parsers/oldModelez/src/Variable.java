package modelezAim;


public class Variable
{
    String Name;
    ////    int Type;     // must be Aim.Endogenous or Aim.Exogenous.
    int DataType; // must be Aim.Data, Aim.Notd, or Aim.Dtrm
    int Delay;

    public Variable(String s) {
	Name = s;
    }

    ////    public void setType(int n) { Type = n; }
    public void setDataType(int n) { DataType = n; }
    public void setDelay(int n) { Delay = n; }

    public int returnDelay() { return Delay; }

}
