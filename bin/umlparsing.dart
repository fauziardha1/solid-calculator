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
  late String modelID;

  // parsing to be project
  project = await loadProject(paths[OCPBadPath] as String);
  modelID = project.ownedElements.first.id;
  classes = project.ownedElements.first.ownedElements;

  printSRP(classes);

  // test OCP
  printOCP(classes, modelID);
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

// print SRP is a void to test SRP calculation
printSRP(List<UMLClass> classes) {
  SRP srp = SRP(classes: classes);

  print("SRP : " + srp.valueOfSRP.toString());

  // print(srp.toString());

  // print all camc
  for (var element in srp.listOfCAMC) {
    print("camc : ${element.getCAMCValue()}");
  }
}

// print OCP is void to test OCP calculation
printOCP(List<UMLClass> classes, String modelID) {
  OCP ocp = OCP(classes: classes, modelID: modelID);

  print("VOCP : " +
      ocp.valueOCP.toString() +
      "\n" +
      ocp.listNOC.length.toString());

  // print all camc
  for (var element in ocp.listNOC) {
    print("Class Name : " +
        element[CLASSNAME] +
        " isAbstract: ${element[IsAbstract]}");
    print("NOC : ${element[NOC]}");
    print("DIT : ${element[DIT]}\n");
  }
}
