import '../../model/class_data_model.dart';
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
    setNumOfSUP(classes);
    _numOfCOCP = countnumOfCOCP(listNOC);
    _valueOCP = calculateValueOCP(_numOfCOCP, _numOfSUP);
  }

  double get valueOCP => _valueOCP;
  List<Map<String, dynamic>> get listNOC => _listNOC;

  // get Depth of Inheritance from a class
  int getDepthOfInheritanceFromClass(UMLClass cls, List<UMLClass> listCls) {
    int depth = 0;
    late UMLClass parent;
    print(
        "not in => ${cls.name} : $depth, isParentNull:${cls.parent == null}, parent.ref : ${cls.parent.ref}");
    if (cls.parent != null &&
        cls.parent.ref != "" &&
        cls.parent.ref != modelID) {
      print("${cls.name} : $depth");
      parent = listCls.firstWhere((element) => element.id == cls.parent.ref);
      depth = getDepthOfInheritanceFromClass(parent, listCls) + 1;
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
    for (var i = 0; i < listCls.length; i++) {
      if (listCls[i].parent != null &&
          listCls[i].parent.ref != "" &&
          listCls[i].parent.ref == cls.id) {
        numOfChildren++;
        numOfChildren += countNumberOfChildren(listCls[i], listCls);
      }
    }
    return numOfChildren;
  }

  // count number of COCP
  int countnumOfCOCP(List<Map<String, dynamic>> listNOC) {
    int count = 0;

    for (var cOCP in listNOC) {
      if (cOCP[IsAbstract] && cOCP[DIT] > 0) {
        count++;
      }
    }

    return count;
  }

  // initiate numOfSUP value
  void setNumOfSUP(List<UMLClass> listCls) {
    _numOfSUP = 0;
    listCls.forEach((element) {
      _numOfSUP += element.parent.ref == modelID ? 1 : 0;
    });
  }

  // calulate value of OCP
  double calculateValueOCP(int nCOCP, int nSUP) {
    return (nCOCP / nSUP).toDouble();
  }
}
