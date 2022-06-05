import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import '3d.dart';

class ChangeColor extends StatefulWidget {
  const ChangeColor({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<ChangeColor> createState() => _ChangeColorState();
}

class _ChangeColorState extends State<ChangeColor> {
  ArCoreNode sphereNode;
  ArCoreController controller;
  double metalic = 0.0;
  double roughness = 0.4;
  double reflectance = 0.5;
  Color color = Colors.yellow;

  void whenArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(arCoreController);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );

    sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(sphereNode);
  }

  onColorChange(Color newColor) {
    if (newColor != this.color) {
      this.color = newColor;
      updateMaterials();
    }
  }

  onMetalicChange(double newMetallic) {
    if (newMetallic != this.metalic) {
      metalic = newMetallic;
      updateMaterials();
    }
  }

  onRoughnessChange(double newRoughness) {
    if (newRoughness != this.roughness) {
      this.roughness = newRoughness;
      updateMaterials();
    }
  }

  onReflectanceChange(double newReflectance) {
    if (newReflectance != this.reflectance) {
      this.reflectance = newReflectance;
      updateMaterials();
    }
  }

  updateMaterials() {
    debugPrint("updateMaterials");
    if (sphereNode == null) {
      return;
    }
    debugPrint("updateMaterials sphere node not null");
    final material = ArCoreMaterial(
      color: color,
      metallic: metalic,
      roughness: roughness,
      reflectance: reflectance,
    );
    sphereNode.shape.materials.value = [material];
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  ArCoreController arCoreController;
  String objectSelected;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SphereControl(
              initialColor: color,
              initialRoughnessValue: roughness,
              initialReflectanceValue: reflectance,
              initialMetallicValue: metalic,
              onColorChange: onColorChange,
              onMetallicChange: onMetalicChange,
              onReflectanceChange: onReflectanceChange,
              onRoughnessChange: onRoughnessChange,
            ),
            Expanded(
              child: ArCoreView(
                onArCoreViewCreated: whenArCoreViewCreated,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NextButton(
                onTab: (value) {
                  objectSelected = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SphereControl extends StatefulWidget {
  final double initialRoughnessValue;
  final double initialReflectanceValue;
  final double initialMetallicValue;
  final Color initialColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<double> onMetallicChange;
  final ValueChanged<double> onRoughnessChange;
  final ValueChanged<double> onReflectanceChange;

  const SphereControl({
    Key key,
    this.initialRoughnessValue,
    this.initialReflectanceValue,
    this.initialMetallicValue,
    this.initialColor,
    this.onColorChange,
    this.onMetallicChange,
    this.onReflectanceChange,
    this.onRoughnessChange,
  }) : super(key: key);

  @override
  State<SphereControl> createState() => _SphereControlState();
}

class _SphereControlState extends State<SphereControl> {
  double metallicValue;
  double roughnessValue;
  double reflectanceValue;
  Color color;

  @override
  void initState() {
    roughnessValue = widget.initialRoughnessValue;
    reflectanceValue = widget.initialReflectanceValue;
    roughnessValue = widget.initialRoughnessValue;
    color = widget.initialColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final newColor = Colors.accents[Random().nextInt(14)];
                  widget.onColorChange(newColor);
                  setState(() {
                    color = newColor;
                  });
                },
                child: Text("random color"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
                    final newColor = Colors.yellow;
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    final newColor = Colors.blue;
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    final newColor = Colors.red;
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    final newColor = Colors.green;
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Metallic"),
              Checkbox(
                  value: metallicValue == 1.0,
                  onChanged: (value) {
                    metallicValue = value ? 1.0 : 0.0;
                    widget.onMetallicChange(metallicValue);
                  }),
            ],
          ),
          Row(
            children: [
              Text("Roughness"),
              Expanded(
                child: Slider(
                    value: roughnessValue,
                    divisions: 10,
                    onChangeEnd: (value) {
                      roughnessValue = value;
                      widget.onRoughnessChange(roughnessValue);
                    },
                    onChanged: (double value) {
                      setState(() {
                        roughnessValue = value;
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Text("Reflectance"),
              Expanded(
                child: Slider(
                    value: reflectanceValue,
                    divisions: 10,
                    onChangeEnd: (value) {
                      reflectanceValue = value;
                      widget.onReflectanceChange(reflectanceValue);
                    },
                    onChanged: (double value) {
                      setState(() {
                        reflectanceValue = value;
                      });
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  const NextButton({Key key, Null Function(dynamic value) onTab})
      : super(key: key);

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Object3DScreen()));
      },
      child: Text('NEXT'),
    );
  }
}
