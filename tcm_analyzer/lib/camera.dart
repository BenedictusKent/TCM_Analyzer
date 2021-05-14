import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tcm_analyzer/home.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imgPath;
  int _pointers = 0;
  int tap = 0;
  double _baseScale = 1.0;
  double _currentScale = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print("Error: $err.code\nError Message: $err.message");
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Take picture"),
      backgroundColor: Color(0xFE2B3F87),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                      6.5 /
                      8,
                  width: MediaQuery.of(context).size.width,
                  child: _cameraPreviewWidget(),
                ),
                Container(
                  width: 205,
                  height: 205,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                        style: BorderStyle.solid),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                )
              ],
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  1.18 /
                  8,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Color(0xFE2B3F87),
              child: CircularButton(
                  Colors.yellow[800], 60, 60, Icon(Icons.camera), () {
                _onCapturePressed(context);
              }),
            )
          ],
        ),
      ),
    );
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller.value.hasError) {
        print("Camera error ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text("Loading",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w900));
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Listener(
          onPointerDown: (_) {
            _pointers++;
            if (tap == 0) {
              tap = 1;
              controller.setFocusMode(FocusMode.locked);
            } else if (tap == 1) {
              tap = 0;
              controller.setFocusMode(FocusMode.auto);
            }
          },
          onPointerUp: (_) => _pointers--,
          child: CameraPreview(
            controller,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onScaleStart: _handleScaleStart,
                  onScaleUpdate: _handleScaleUpdate,
                  onTapDown: (details) => onViewFinderTap(details, constraints),
                );
              },
            ),
          ),
        ));
  }

  void _onCapturePressed(context) async {
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      XFile test = await controller.takePicture();
      Navigator.pushNamed(context, '/view', arguments: test);
    } catch (e) {
      print(e);
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (controller == null || _pointers != 2) return;
    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);
    await controller.setZoomLevel(_currentScale);
  }
}
