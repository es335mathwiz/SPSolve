package modelezAim;
public class Equation
{
  String Name;
  Node LHS;
  Node RHS;
  int EqType;  // must be Aim.Stoch or Aim.Imposed.

  public Equation(String s, Node left, Node right, int etype) {
    Name = s;
    LHS = left;
    RHS = right;
    EqType = etype;
  }
  
  public Equation(String s, int etype) {
    Name = s;
    EqType = etype;
  }

  public void setLHS(Node n) {
    LHS = n;
  }
  
  public void setRHS(Node n) {
    RHS = n;
  }
  
  public void Print() { 
    LHS.PrintSubtree();
    System.out.print(" =\n         ");
    RHS.PrintSubtree();
    System.out.println("\n\n");
}

  public void ExpandSubtrees() {
    LHS = LHS.ExpandSubtree();
    RHS = RHS.ExpandSubtree();
  }

}

