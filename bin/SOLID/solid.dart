import '../model/class_data_model.dart';
import 'DIP/dependency_inversion_principle.dart';
import 'ISP/interface_segregation_principle.dart';
import 'LSP/liskov_subtitution_principle.dart';
import 'OCP/open_close_principle.dart';
import 'SRP/single_responsibility_principle.dart';

class SOLID {
  late SRP srp;
  late OCP ocp;
  late LiskovSubstitutionPrinciple lsp;
  late InterfaceSegregationPrinciple isp;
  late DependencyInversionPrinciple dip;
  late List<UMLClass> classes;
  late String modelID;

  SOLID({required this.classes, required this.modelID}) {
    srp = SRP(classes: classes);
    ocp = OCP(
      classes: classes,
      modelID: modelID,
    );
    lsp = LiskovSubstitutionPrinciple(
      classes: classes,
    );
    isp = InterfaceSegregationPrinciple(classes);
    dip = DependencyInversionPrinciple(
      classes: classes,
    );
  }

  @override
  String toString() {
    return srp.toString() +
        "\n" +
        ocp.toString() +
        "\n" +
        lsp.toString() +
        "\n" +
        isp.toString() +
        "\n" +
        dip.toString();
  }
}
