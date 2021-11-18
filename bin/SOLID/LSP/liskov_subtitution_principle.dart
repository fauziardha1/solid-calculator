import '../../model/class_data_model.dart';

class LiskovSubstitutionPrinciple {
  int _numConformLSP = 0;
  List<UMLClass> classes = [];
  int _numOfHierarchy = 0;
  // ignore: prefer_final_fields
  List<UMLClass> _hierarchys = [];
  double _valueOfLSP = 0;

  LiskovSubstitutionPrinciple({required this.classes}) {
    // step 1: calculate number of children for each class,
    // and calculate number of hierarchy
    setupNumOfChildrenForEachClass(classes);

    // setup hierarchy
    setupHierarchy(classes);

    // step 2: for hierarchy, calculate nmi, nme, nmo
    stepTwo(_hierarchys);

    // last step: calculate value of LSP
    _valueOfLSP = calculateValueOfLSP(_numConformLSP, _numOfHierarchy);
  }

  // setup List of hierarchy
  setupHierarchy(List<UMLClass> classes) {
    for (var cls in classes) {
      if (cls.isBaseClass) {
        _hierarchys.add(cls);
      }
    }
  }

  setupNumOfChildrenForEachClass(List<UMLClass> classList) {
    for (var cls in classList) {
      // check if class is base class
      cls.isBaseClass = cls.ownedElements.isEmpty;
      _numOfHierarchy += cls.ownedElements.isEmpty ? 1 : 0;
    }

    for (var cls in classList) {
      cls = setupClassMemberInheritance(cls, classList);
    }
  }

  // setupClassMemberInheritance check if class has children.
  // If so, check add number of children to class,and return updated class.
  // If class has no children, return old class
  UMLClass setupClassMemberInheritance(UMLClass cls, List<UMLClass> classList) {
    // check if class is child from this class
    for (var child in classList) {
      if (child.isBaseClass) {
        continue;
      }

      // check if child is child from this class, using child ownedElements,
      // for each ownedElement in child ownedElements,
      // check if it is UMLGeneralization and target.ref is equal to cls.id
      for (var ownedElement in child.ownedElements) {
        if (
            //  ownedElement.type == 'UMLGeneralization' &&
            ownedElement.target.ref == cls.id) {
          // check if this child has children
          child = setupClassMemberInheritance(child, classList);

          cls.numOfChildren++;
          cls.children.add(child);
        }
      }
    }
    return cls;
  }

  // step 2: for hierarchy, calculate nmi, nme, nmo
  stepTwo(List<UMLClass> hierarchys) {
    for (var i = 0; i < hierarchys.length; i++) {
      var hierarchy = hierarchys[i];

      // calculate nmi
      hierarchy.nmia = hierarchy.operations.length;
      hierarchy.isConformLSP = true;

      // if class has children, it's conform LSP
      if (hierarchy.children.isEmpty) {
        print('hierarchy ${hierarchy.name} has no children');
        // _numConformLSP++;
        // hierarchy.is_lsp = true;
        // hierarchy.isConformLSP = true;
        continue;
      }

      // for each child, calculate nme and nmo
      for (var child in hierarchy.children) {
        child.nme = 0;
        child.nmo = 0;

        // TODO: this code should be deleted
        // 2.2-1 count nme:  for each operation in child, check if it equal to hierarchy operation
        // for (var operation in child.operations) {
        //   for (var operationHierarchy in hierarchy.operations) {
        //     if (!operationHierarchy.isAbstract) {
        //       continue;
        //     }
        //     if (operation.name == operationHierarchy.name &&
        //         operation.parameters.length ==
        //             operationHierarchy.parameters.length) {
        //       // check if operation parameter is equal to operationHierarchy parameter
        //       bool isEqual = true;
        //       for (var i = 0; i < operation.parameters.length; i++) {
        //         if (operation.parameters[i].dataType !=
        //             operationHierarchy.parameters[i].dataType) {
        //           isEqual = false;
        //           break;
        //         }
        //       }
        //       child.nme += isEqual ? 1 : 0;
        //     }
        //   }
        // }

        // refactoring version of nme and nmia calculation
        for (var hryIdx = 0; hryIdx < hierarchy.operations.length; hryIdx++) {
          var hryOperation = hierarchy.operations[hryIdx];
          if (!hryOperation.isAbstract) {
            continue;
          }

          for (var childIdx = 0;
              childIdx < child.operations.length;
              childIdx++) {
            var childOperation = child.operations[childIdx];
            if (childOperation.name == hryOperation.name &&
                childOperation.parameters.length ==
                    hryOperation.parameters.length) {
              // check if operation parameter is equal to operationHierarchy parameter
              bool isEqual = true;
              for (var i = 0; i < childOperation.parameters.length; i++) {
                if (childOperation.parameters[i].dataType !=
                    hryOperation.parameters[i].dataType) {
                  isEqual = false;
                  break;
                }
              }
              child.nme += isEqual ? 1 : 0;
            }
          }
        }

        // 2.2-2 for each operation in child, count nmo // TODO : old code should be deleted
        // for (var operation in child.operations) {
        //   // if operation is equal to operationHierarchy, nmo++
        //   for (var operationHierarchy in hierarchy.operations) {
        //     if (operationHierarchy.isAbstract) {
        //       continue;
        //     }
        //     if (operation.name == operationHierarchy.name &&
        //         operation.parameters.length ==
        //             operationHierarchy.parameters.length) {
        //       // check if operation parameter is equal to operationHierarchy parameter
        //       bool isEqual = true;
        //       for (var i = 0; i < operation.parameters.length; i++) {
        //         if (operation.parameters[i].dataType !=
        //             operationHierarchy.parameters[i].dataType) {
        //           isEqual = false;
        //           break;
        //         }
        //       }
        //       child.nmo += isEqual ? 1 : 0;
        //     } else if (operation.name == operationHierarchy.name &&
        //         operation.parameters.length !=
        //             operationHierarchy.parameters.length) {
        //       print("operation overloading");
        //       child.nmo++;
        //     }
        //   }
        // }

        // refactroing code to make it correct for nmo
        for (var i = 0; i < hierarchy.operations.length; i++) {
          var operation = hierarchy.operations[i];

          if (operation.isAbstract) {
            continue;
          }

          // check similarity of operation and child operation
          for (var childOptIdx = 0;
              childOptIdx < child.operations.length;
              childOptIdx++) {
            var childOperation = child.operations[childOptIdx];

            // TODO : add condition for operation return value
            if (operation.name == childOperation.name &&
                operation.parameters.length ==
                    childOperation.parameters.length) {
              // check if operation parameter is equal to operationHierarchy parameter
              bool isEqual = true;
              for (var paramIdx = 0;
                  paramIdx < operation.parameters.length;
                  paramIdx++) {
                if (operation.parameters[paramIdx].dataType !=
                    childOperation.parameters[paramIdx].dataType) {
                  isEqual = false;
                  break;
                }
              }
              if (isEqual) {
                child.nmo++;
              }
            } else if (operation.name == childOperation.name &&
                operation.parameters.length !=
                    childOperation.parameters.length) {
              print("operation overloading");
              child.nmo++;
            }
          }
        }
      }

      // 2.3-1 compare nmi and nme for each child
      hierarchy.isConformLSP = true;
      for (var child in hierarchy.children) {
        if (child.nme < hierarchy.nmia || child.nmo != 0) {
          hierarchy.isConformLSP = false;
          break;
        }
      }
      _numConformLSP += hierarchy.isConformLSP ? 1 : 0;
      hierarchy.is_lsp =
          hierarchy.isConformLSP; // set is_lsp for ISP calculation

      for (var child in hierarchy.children) {
        if (child.nme < hierarchy.nmia && child.isAbstract) {
          // lakukan steptwo untuk setiap child
          stepTwo(convertToUMLClasses([child]));
        }
      }
    }
  }

  // convertToUMLClasses convert List of UMLClass to List of UMLClass
  // It recieve List of dynamic, and return List of UMLClasss
  List<UMLClass> convertToUMLClasses(List<dynamic> clsList) {
    List<UMLClass> classes = [];
    for (var cls in clsList) {
      late UMLClass item;
      try {
        item = UMLClass(
          id: cls.id,
          name: cls.name,
          ownedElements: cls.ownedElements,
          attributes: cls.attributes,
          isAbstract: cls.isAbstract,
          operations: cls.operations,
          parent: cls.parent,
          type: cls.type,
        );
        item.isConformLSP = cls.isConformLSP;
        item.isBaseClass = cls.isBaseClass;
        item.numOfChildren = cls.numOfChildren;
        item.nmia = cls.nmia;
        item.nme = cls.nme;
        item.nmo = cls.nmo;
        item.depthOfInheritance = cls.depthOfInheritance;
        item.children = cls.children;
      } catch (e) {
        print("UMLClass parsing got error - convertToUMLClasses : LSP => $e");
        continue;
      }

      classes.add(item);
    }
    return classes;
  }

  //  last step : calculate depth of inheritance
  double calculateValueOfLSP(int nCLSP, int noh) {
    return nCLSP / noh;
  }

  double get valueOfLSP => _valueOfLSP;

  List<UMLClass> get hierarchys => _hierarchys;

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write("#" * 20 + " LSP " + "#" * 20 + "\n");
    sb.write('Liskov Substitution Principle:\n');
    sb.write("\x1B[33mValue of DIP: ${_valueOfLSP}\x1B[0m\n");
    sb.write('Number of Hierarchy (NOH): $_numOfHierarchy\n');
    sb.write('Number of CLSP : $_numConformLSP\n');
    for (var cls in _hierarchys) {
      sb.write('Class: ${cls.name}\n');
      sb.write('\tNumber of children: ${cls.numOfChildren}\n');
      sb.write('\tBaseClass: ${cls.isBaseClass ? "YES" : "NO"}\n');
      sb.write('\tConform LSP: ${cls.isConformLSP ? "YES" : "NO"}\n');
      sb.write('\tConform SRP: ${cls.is_srp ? "YES" : "NO"}\n');
      sb.write('\tChildren: ');
      for (var child in cls.children) {
        sb.write('${child.name}, ');
        // sb.write(child.toLiskovString() + '\n');
      }
      sb.write('\n');
    }
    sb.write('#' * 20 + '#' * 20 + '\n');
    return sb.toString();
  }
}
