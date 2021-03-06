import 'dart:convert';
import 'dart:io';
import 'SOLID/query_const.dart';
import 'SOLID/solid.dart';
import 'model/class_data_model.dart';
import 'model/mainmodel_data_model.dart';

main() async {
  late SOLID solid;
  late UMLProject? project;
  late List<UMLClass>? classes;
  late String modelID;

  // parsing to be project
  project = await loadProject(paths[ProjectPath] as String);
  modelID = project.ownedElements.first.id;
  classes = project.ownedElements.first.ownedElements;

  solid = SOLID(classes: classes, modelID: modelID);
  print(solid.toString());
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
  var response = "";
  try {
    response = contents as String;
  } catch (e) {
    print(e);
    return UMLProject(type: "", id: "", name: "", ownedElements: []);
  }

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
