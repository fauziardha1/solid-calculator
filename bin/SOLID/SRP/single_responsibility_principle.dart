import '../../model/class_data_model.dart' show UMLClass;
import '../../model/operation_data_model.dart' show UMLOperation;

class SRP {
  late List<UMLClass> classes;
  late double valueOfSRP;
  late int numOfConformSRP;
  late int numOfClasses;
  late List<CAMC> listOfCAMC;

  SRP({required this.classes}) {
    numOfClasses = classes.length;
    listOfCAMC = addCAMC(classes: classes);
    numOfClasses = classes.length;
    numOfConformSRP = calculateNumOfConformSRP(listOfCAMC: listOfCAMC);
    valueOfSRP = calculateValueOfSRP(
        numOfConformSRP: numOfConformSRP, numOfClasses: numOfClasses);
  }

  List<CAMC> addCAMC({required List<UMLClass> classes}) {
    listOfCAMC = [];

    for (var classData in classes) {
      listOfCAMC.add(CAMC(classToCheck: classData));
    }
    return listOfCAMC;
  }

  int calculateNumOfConformSRP({required List<CAMC> listOfCAMC}) {
    int nCSRP = 0;
    for (var camc in listOfCAMC) {
      if (camc.getCAMCValue() >= .35) {
        nCSRP++;
        camc.classToCheck.is_srp = true;
      }
    }
    return nCSRP;
  }

  double calculateValueOfSRP(
      {required int numOfConformSRP, required int numOfClasses}) {
    var srpVal = (numOfConformSRP / numOfClasses);
    return srpVal;
  }

  // override to string
  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write("#" * 20 + " SRP " + "#" * 20 + "\n");
    sb.write("Single Responsibility Principle: \n");
    sb.write("\x1B[33mValue of SRP: $valueOfSRP \x1B[0m\n");
    sb.write("Number of classes: $numOfClasses \n");
    sb.write("Number of classes that conform SRP: $numOfConformSRP \n");
    sb.write("#" * 20 + "#" * 20 + "\n");
    return sb.toString();

    // return 'SRP{classes: ${classes.length}, valueOfSRP: $valueOfSRP, numOfConformSRP: $numOfConformSRP, numOfClasses: $numOfClasses, listOfCAMC: $listOfCAMC}';
  }
}

class CAMC {
  late UMLClass classToCheck;
  late double camcValue;
  late int numOfOperationInClass;
  late int numOfParameterTypeInClass;
  late List<String> listOfParameterTypeInClass;

  CAMC({required this.classToCheck}) {
    numOfOperationInClass = calculateNumOfOperationInClass(classToCheck);
    listOfParameterTypeInClass = countListOfParameterTypeInClass(classToCheck);
    numOfParameterTypeInClass = listOfParameterTypeInClass.length;
    camcValue = calculateCAMC(
        aClass: classToCheck,
        listOfParameterTypeInClass: listOfParameterTypeInClass,
        numOfOperation: numOfOperationInClass);
  }

  int calculateNumOfOperationInClass(UMLClass aClass) {
    return aClass.operations.length;
  }

  List<String> countListOfParameterTypeInClass(UMLClass aClass) {
    List<String> listOfParameterType = [];

    for (var operation in aClass.operations) {
      for (var parameter in operation.parameters) {
        if (!listOfParameterType.contains(parameter.name) &&
            parameter.name != '') {
          listOfParameterType.add(parameter.name);
        }
      }
    }

    return listOfParameterType;
  }

  double calculateCAMC(
      {required UMLClass aClass,
      required List<String> listOfParameterTypeInClass,
      required int numOfOperation}) {
    double camcValue = 0;
    int numOfAllParameterType = 0;

    for (var operation in aClass.operations) {
      numOfAllParameterType += numOfParameterInOperation(
          operation: operation,
          listOfParameterType: listOfParameterTypeInClass);
    }

    camcValue = numOfAllParameterType /
        ((listOfParameterTypeInClass.length + 1) * numOfOperation);

    return camcValue;
  }

  int numOfParameterInOperation(
      {required UMLOperation operation,
      required List<String> listOfParameterType}) {
    int numOfIntersectionParameter = 1; // 1 is for the parameter "this"

    for (var parameter in operation.parameters) {
      if (listOfParameterType.contains(parameter.name)) {
        numOfIntersectionParameter++;
      }
    }

    return numOfIntersectionParameter;
  }

  double getCAMCValue() => camcValue;

  // override to string
  @override
  String toString() {
    return 'CAMC{classToCheck: ${classToCheck.name}, camcValue: $camcValue, numOfOperationInClass: $numOfOperationInClass, numOfParameterTypeInClass: $numOfParameterTypeInClass, listOfParameterTypeInClass: $listOfParameterTypeInClass}';
  }
}
