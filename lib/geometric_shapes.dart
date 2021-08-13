import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class GeoMetricShapes extends StatefulWidget {
  @override
  _GeoMetricShapesState createState() => _GeoMetricShapesState();
}

class _GeoMetricShapesState extends State<GeoMetricShapes> {
  ArCoreController arCoreController;

  void whenArCoreViewCreated(ArCoreController arCoreController) {
    arCoreController = arCoreController;

    addSphere(arCoreController);
    addCube(arCoreController);
    addCylinder(arCoreController);
  }

  Future addSphere(ArCoreController coreController) async {
    final ByteData textureBytes = await rootBundle.load("assets/earth.jpg");

    final materials = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [materials],
      radius: 0.1,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );

    coreController.addArCoreNode(node);
  }

  Future addCube(ArCoreController coreController) async {
    final materials = ArCoreMaterial(
      color: Colors.green,
      metallic: 1.0,
    );

    final cube = ArCoreCube(
      materials: [materials],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );

    coreController.addArCoreNode(node);
  }

  Future addCylinder(ArCoreController coreController) async {
    final materials = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );

    final cylinder = ArCoreCylinder(
      materials: [materials],
      radius: 0.5,
      height: 0.3,
    );

    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );

    coreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    super.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AR Geometric Shapes App',
        ),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
      ),
    );
  }
}
