import '../../model/class_data_model.dart';

class DependencyInversionPrinciple {
  late List<UMLClass> classes;
  List<UMLClass> _listDCC = [];
  int _numOfDep = 0;
  int _numConformDIP = 0;
  double _valueDIP = 0;

  DependencyInversionPrinciple({required this.classes}) {
    //  count DCC
    _listDCC = [...getDCC(classes)];

    // count number of ConformDIP
    _numConformDIP = countNumConformDIP(_listDCC);

    // calculate value of dip
    _valueDIP = calculateValueDIP(_numConformDIP, _numOfDep);
  }

  // calculateValueDIP function to calculate value of DIP of class diagram project
  // @param numConformDIP: number of ConformDIP
  // @param numOfDep: number of dependency
  // @return value of DIP : double
  double calculateValueDIP(int numConformDIP, int numOfDCC) {
    return numConformDIP == 0 || numOfDCC == 0 ? 0 : (numConformDIP / numOfDCC);
  }

// getDCC count number of Direct Class Coupling
// @param classes: list of classes
// @return list of classes: list of classes
  List<UMLClass> getDCC(List<UMLClass> classes) {
    List<UMLClass> dcc = [];

    for (UMLClass cls in classes) {
      bool isDCC = false;
      for (var attr in cls.attributes) {
        // for each attribute, check if it is a dependency
        for (var tempidx = 0; tempidx < classes.length; tempidx++) {
          var tempcls = classes[tempidx];
          if (tempcls != cls) {
            if (attr.dataType.contains(tempcls.name) ||
                attr.dataType.contains(tempcls.id)) {
              isDCC = true;
              _numOfDep++;
              cls.dipDCCTo.add(tempcls);
            }
          }
        }
        if (isDCC) {
          dcc.add(cls);
        }
      }
    }

    return dcc;
  }

// countNumConformDIP function to count number of ConformDIP
// @param listDCC: list of classes
// @return number of ConformDIP: int
  int countNumConformDIP(List<UMLClass> dcc) {
    int numConformDIP = 0;
    for (UMLClass cls in dcc) {
      for (var dccTo in cls.dipDCCTo) {
        if (dccTo.isAbstract || dccTo.type == 'UMLInterface') {
          numConformDIP++;
        }
      }
    }

    return numConformDIP;
  }

  double get valueDIP => _valueDIP;

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("#" * 20 + " DIP " + "#" * 20 + "\n");
    sb.write("Dependency Inversion Principle:\n");
    sb.write("\x1B[33mValue of DIP: ${_valueDIP}\x1B[0m\n");
    sb.write("classes len: ${classes.length}\n");
    sb.write("DCC len: ${_listDCC.length}\n");
    sb.write("Number of Dependencies: ${_numOfDep}\n");
    sb.write("Number of Conform Dependencies: ${_numConformDIP}\n");

    for (UMLClass cls in classes) {
      for (var attr in cls.attributes) {
        sb.write("class ${cls.name} attr type: ${attr.toString()}\n");
      }
    }
    sb.write("#" * 20 + "#" * 20 + "\n");
    sb.write("\n");
    return sb.toString();
  }
}
