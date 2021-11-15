mixin LSPAttributes {
  bool isConformLSP = false;
  bool isBaseClass = false;
  int numOfChildren = 0;
  int nmia = 0;
  int nme = 0;
  int nmo = 0;
  int depthOfInheritance = 0;

  // list of child
  List children = [];

  String toLiskovString() {
    StringBuffer sb = new StringBuffer();
    sb.write("Liskov: ");
    if (isConformLSP) {
      sb.write("Conform");
    } else {
      sb.write("Non-Conform");
    }
    sb.write("\n");
    sb.write("BaseClass: ");
    if (isBaseClass) {
      sb.write("Yes");
    } else {
      sb.write("No");
    }
    sb.write("\n");
    sb.write("NumOfChildren: ");
    sb.write(numOfChildren.toString());
    sb.write("\n");
    sb.write("Nmia: ");
    sb.write(nmia.toString());
    sb.write("\n");
    sb.write("Nme: ");
    sb.write(nme.toString());
    sb.write("\n");
    sb.write("Nmo: ");
    sb.write(nmo.toString());
    sb.write("\n");
    sb.write("DepthOfInheritance: ");
    sb.write(depthOfInheritance.toString());
    sb.write("\n");
    sb.write("Children: ");
    sb.write(children.toString());
    sb.write("\n");
    return sb.toString();
  }
}
