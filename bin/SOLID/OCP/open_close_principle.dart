import '../../model/class_data_model.dart';
import '../../model/dependency_data_model.dart';
import '../query_const.dart';

class OCP {
  late double _valueOCP;
  late int _numOfCOCP;
  late int _numOfSUP;
  late String modelID;
  List<UMLClass> classes = [];
  List<Map<String, dynamic>> _listNOC = [];

  OCP({required this.classes, required this.modelID}) {
    setListNOC(classes);
    setNumOfSUP(_listNOC);
    _numOfCOCP = countnumOfCOCP(_listNOC);
    _valueOCP = calculateValueOCP(_numOfCOCP, _numOfSUP);
  }

  double get valueOCP => _valueOCP;
  List<Map<String, dynamic>> get listNOC => _listNOC;

  // get Depth of Inheritance from a class
  // return number of parent of a class
  int getDepthOfInheritanceFromClass(UMLClass cls, List<UMLClass> listCls) {
    int depth = 0;
    late UMLDependency dependency;
    late UMLClass temp;

    // if dependency list is empty, it's base class
    if (cls.ownedElements.isNotEmpty) {
      // get parent class
      try {
        dependency = cls.ownedElements
            .firstWhere((element) => element.type == "UMLGeneralization");
      } catch (e) {
        print("no data UMLGeneraliztion here");
        return depth;
      }

      try {
        temp = listCls
            .firstWhere((element) => element.id == dependency.target.ref);
      } catch (e) {
        print("error: $e");
        return depth;
      }

      depth = getDepthOfInheritanceFromClass(temp, listCls) + 1;
    }
    return depth;
  }

  // set value of _listNOC
  void setListNOC(List<UMLClass> listCls) {
    _listNOC = [];
    for (var i = 0; i < listCls.length; i++) {
      _listNOC.add({
        CLASSNAME: listCls[i].name,
        IsAbstract: listCls[i].isAbstract,
        DIT: getDepthOfInheritanceFromClass(listCls[i], listCls),
        // add value number of children for each class
        NOC: countNumberOfChildren(listCls[i], listCls)
      });
    }
  }

  // count number of children for each class
  int countNumberOfChildren(UMLClass cls, List<UMLClass> listCls) {
    int numOfChildren = 0;

    for (var aClass in listCls) {
      // check its dependency, does it contain UMLGeneralization and target.ref is cls.ref
      if (aClass.ownedElements.any((element) =>
          element.target.ref == cls.id &&
          element.type == "UMLGeneralization")) {
        numOfChildren++;
      }
    }
    return numOfChildren;
  }

  // count number of COCP
  int countnumOfCOCP(List<Map<String, dynamic>> listNOC) {
    int count = 0;
    for (var cOCP in listNOC) {
      if (cOCP[IsAbstract] && cOCP[NOC] > 0) {
        count++;
      }
    }

    return count;
  }

  // initiate numOfSUP value
  void setNumOfSUP(List<Map<String, dynamic>> listCls) {
    _numOfSUP = 0;
    listCls.forEach((element) {
      _numOfSUP += element[DIT] == 0 ? 1 : 0;
    });
  }

  // calulate value of OCP
  double calculateValueOCP(int nCOCP, int nSUP) {
    return (nCOCP / nSUP).toDouble();
  }

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("#" * 20 + " OCP " + "#" * 20 + "\n");
    sb.writeln("Open/Closed Prinsiple:");
    sb.write("\x1B[33mValue of OCP: " + valueOCP.toString() + "\x1B[0m\n");
    sb.write("Number of COCP: " + _numOfCOCP.toString() + "\n");
    sb.write("Number of SUP: " + _numOfSUP.toString() + "\n");
    sb.write("#" * 20 + "#" * 20 + "\n");
    return sb.toString();
  }
}
