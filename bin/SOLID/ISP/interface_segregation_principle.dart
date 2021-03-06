import '../../model/class_data_model.dart';

class InterfaceSegregationPrinciple {
  late List<UMLClass> classes;
  int _numOfCISP = 0;
  int _numOfInterface = 0;
  late double _valueOfISP;
  List<UMLClass> listInterface = [];

  InterfaceSegregationPrinciple(this.classes) {
    _numOfInterface = _getNumOfInterface();
    _numOfCISP = _getNumOfCISP();
    _valueOfISP = _getValueOfISP();
  }

  int _getNumOfInterface() {
    int numOfInterface = 0;
    for (UMLClass cls in classes) {
      if (cls.type == "UMLInterface") {
        numOfInterface++;
        listInterface.add(cls);
      }
    }
    return numOfInterface;
  }

  int _getNumOfCISP() {
    int numOfCISP = 0;
    for (var cls in listInterface) {
      if (cls.is_srp && cls.isConformLSP && cls.type == "UMLInterface") {
        numOfCISP++;
      }
    }
    return numOfCISP;
  }

  double _getValueOfISP() {
    return _numOfCISP == 0 || _numOfInterface == 0
        ? 0
        : _numOfCISP / _numOfInterface;
  }

  double get valueOfISP => _valueOfISP;

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.writeln("#" * 20 + " ISP " + "#" * 20);
    sb.write("Interface Segregation Principle");
    sb.write("\n");
    sb.write("\x1B[33mValue of SRP: $_valueOfISP \x1B[0m");
    sb.write("\n");
    sb.write("Number of Interface: ");
    sb.write(_numOfInterface);
    sb.write("\n");
    sb.write("Number of Confirm ISP: ");
    sb.write(_numOfCISP);
    sb.write("\n");

    sb.writeln("interface len : " + listInterface.length.toString());
    sb.writeln("#" * 40);
    return sb.toString();
  }
}
