import 'dart:convert';
import 'dart:io';

import 'SOLID/OCP/open_close_principle.dart';
import 'SOLID/SRP/single_responsibility_principle.dart';
import 'SOLID/query_const.dart';
import 'model/class_data_model.dart';
import 'model/mainmodel_data_model.dart';

main(List<String> args) async {
  late UMLProject project;
  late List<UMLClass> classes;
  // String path = '/Users/fauzi.saputra/Documents/Person.mdj';
  // String path =
  //     '/Users/fauzi.saputra/Documents/thesis_uml_project/separated_mobile_phone.mdj';

  // path for testing OCP
  String path =
      '/Users/fauzi.saputra/Documents/thesis_uml_project/ocp_good_case.mdj';

  // parsing to be project
  project = await loadProject(path);
  classes = project.ownedElements[0].ownedElements;

  // print(project.ownedElements[0].ownedElements[0].toString());

  print("class length : " + classes.length.toString());

  // printSRP(classes);

  // test OCP
  printOCP(classes, project.ownedElements[0].id);
}

// load Project from mdj file
Future<UMLProject> loadProject(String path) async {
  var file = File(path);
  var contents;

  if (await file.exists()) {
    contents = await file.readAsString();
    // print(contents);
  } else {
    print('File does not exist');
  }

  // read file and cast to string
  var response = contents as String;

  // replace "_type" to be "type"
  response = response.replaceAll("_type", "UMLKind");

  // decode json
  var json = jsonDecode(response);

  // get the list of classes
  var JsonClasses = json['ownedElements'][0]['ownedElements'] as List;

  // remove first class
  JsonClasses = JsonClasses.getRange(1, JsonClasses.length).toList();
  json['ownedElements'][0]['ownedElements'] = JsonClasses;

  json = jsonEncode(json);

  // parsing to be project
  var project = UMLProject.fromJson(json);

  return project;
}

printSRP(List<UMLClass> classes) {
  SRP srp = SRP(classes: classes);

  print("SRP : " + srp.valueOfSRP.toString());

  // print(srp.toString());

  // print all camc
  for (var element in srp.listOfCAMC) {
    print("camc : ${element.getCAMCValue()}");
  }
}

printOCP(List<UMLClass> classes, String modelID) {
  OCP ocp = OCP(classes: classes, modelID: modelID);

  print("OCP : " + ocp.valueOCP.toString() + "\n");

  // print all camc
  for (var element in ocp.listNOC) {
    print("Class Name : " +
        element[CLASSNAME] +
        " isAbstract: ${element[IsAbstract]}");
    print("NOC : ${element[NOC]}");
    print("DIT : ${element[DIT]}\n");
  }
}
