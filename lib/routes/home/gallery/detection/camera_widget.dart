import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:rolobox/routes/home/gallery/facial_analysis.dart';
import 'scanner_utils.dart';

class FaceDetectionPage extends StatefulWidget {
  @override
  _FaceDetectionPageState createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  CameraController _controller;
  CameraLensDirection _direction = CameraLensDirection.back;
  final FaceDetector _detector = FirebaseVision.instance.faceDetector();
  List<Face> faces;
  bool _isDetecting = false;

  String selectedImagePath;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  void _initCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _controller = CameraController(description, ResolutionPreset.high);
    await _controller.initialize();

    _controller.startImageStream((CameraImage image) {
      if (_isDetecting) return;
      _isDetecting = true;

      _detector
          .processImage(ScannerUtils.getFirebaseVisionImage(
              image, description.sensorOrientation))
          .then((List<Face> result) {
        if (mounted) {
          setState(() {
            faces = result;
          });
        }
      }).whenComplete(() => _isDetecting = false);
    });
  }

  void _onSwitchCamera() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }
    if (_controller.value.isStreamingImages) {
      await _controller.stopImageStream();
    }
    await _controller.dispose();

    if (mounted) {
      setState(() {
        _controller = null;
      });
    }

    _initCamera();
  }

  void _onPickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    selectedImagePath = image.path;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FacialAnalysisWidget(
          imagePath: selectedImagePath,
        ),
      ),
    );
  }

  void _onPhotoTaken() async {
    try {
      if (_controller == null || !_controller.value.isInitialized) {
        print("camera uninitialized.");
      } else {
        String filename = DateTime.now().toString();
        final path = join(
          (await getTemporaryDirectory()).path,
          '$filename.jpg',
        );
        if (_controller.value.isStreamingImages) {
          await _controller.stopImageStream();
        }
        await _controller.initialize();
        await _controller.takePicture(path);
        await GallerySaver.saveImage(path);
        // the path where the gallery saver save the image.
        String filepath = "/storage/emulated/0/Pictures/$filename.jpg";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FacialAnalysisWidget(
              imagePath: filepath,
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _cameraPreview(size),
            _buildFaceBounds(),
            _bottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _cameraPreview(Size size) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container(
        child: Center(child: const Text('Camera Initializing')),
      );
    }

    return Transform.scale(
      scale: _controller.value.aspectRatio / size.aspectRatio,
      child: Container(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: CameraPreview(_controller),
        ),
      ),
    );
  }

  Widget _buildFaceBounds() {
    const Text noFaceText = Text('No Faces!');
    if (faces == null ||
        _controller == null ||
        !_controller.value.isInitialized) {
      return noFaceText;
    }

    final Size imageSize = Size(_controller.value.previewSize.height,
        _controller.value.previewSize.width);

    CustomPainter painter = FaceDetectorPainter(imageSize, faces, _direction);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _bottomActions(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ActionButton(
            iconData: Icons.photo_library,
            iconSize: 24,
            onPressed: _onPickImage,
          ),
          ActionButton(
            iconData: Icons.camera,
            iconSize: 48,
            onPressed: _onPhotoTaken,
          ),
          ActionButton(
            iconData: Icons.switch_camera,
            iconSize: 24,
            onPressed: _onSwitchCamera,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose().then((_) {
      _detector.close();
    });
    super.dispose();
  }
}

class ActionButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final VoidCallback onPressed;

  ActionButton({this.iconData, this.iconSize, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color iconColor = iconSize == 24
        ? Theme.of(context).primaryColor
        : Theme.of(context).accentColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(iconSize),
        color: iconColor,
      ),
      child: IconButton(
        icon: Icon(iconData, color: Colors.white),
        iconSize: iconSize,
        onPressed: onPressed,
      ),
    );
  }
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces, this.direction);

  final Size absoluteImageSize;
  final List<Face> faces;
  final CameraLensDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.yellow;

    for (Face face in faces) {
      double left = direction == CameraLensDirection.back
          ? face.boundingBox.left * scaleX
          : (absoluteImageSize.width - face.boundingBox.right) * scaleX;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            left,
            face.boundingBox.top * scaleY,
            face.boundingBox.width * scaleX,
            face.boundingBox.height * scaleY,
          ),
          Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
