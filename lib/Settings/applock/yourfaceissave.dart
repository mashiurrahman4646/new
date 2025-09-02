import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class FaceAuthenticationScreen extends StatefulWidget {
  @override
  _FaceAuthenticationScreenState createState() => _FaceAuthenticationScreenState();
}

class _FaceAuthenticationScreenState extends State<FaceAuthenticationScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  CameraController? _cameraController;
  Timer? _timer;
  bool _isScanning = false;
  bool _isComplete = false;
  bool _isCameraInitialized = false;
  int _secondsRemaining = 30;
  String _statusMessage = 'initializing_camera'.tr;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() {
          _statusMessage = 'no_camera_found'.tr;
        });
        return;
      }

      CameraDescription frontCamera;
      try {
        frontCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      } catch (e) {
        frontCamera = cameras.first;
      }

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _statusMessage = 'position_face'.tr;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statusMessage = 'camera_init_failed'.tr;
        });
      }
      print('Camera initialization error: $e');
    }
  }

  void _startScanning() {
    if (!_isCameraInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('camera_not_ready'.tr),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isScanning = true;
      _secondsRemaining = 30;
      _statusMessage = 'keep_face_in_circle'.tr;
    });

    _progressController.forward();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsRemaining--;
        });

        if (_secondsRemaining <= 0) {
          _completeScan();
        }
      }
    });
  }

  void _completeScan() {
    _timer?.cancel();
    _progressController.stop();
    _pulseController.stop();

    setState(() {
      _isScanning = false;
      _isComplete = true;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'faceid_saved'.tr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'faceid_saved_desc'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Get.offNamedUntil('/settings', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B82F6),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'continue_button'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double circleRadius = screenWidth * 0.35;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(child: CameraPreview(_cameraController!))
          else
            _buildLoadingBackground(),

          // Overlay with cutout circle
          ClipPath(
            clipper: CircleClipper(
              centerX: screenWidth / 2,
              centerY: screenHeight / 2,
              radius: circleRadius,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.8),
            ),
          ),

          // Back button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
              ),
            ),
          ),

          // Circle centered
          Center(
            child: Container(
              width: circleRadius * 2,
              height: circleRadius * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size(circleRadius * 2, circleRadius * 2),
                        painter: CircularProgressPainter(
                          progress: _progressAnimation.value,
                          isScanning: _isScanning,
                        ),
                      );
                    },
                  ),
                  if (_isScanning)
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: circleRadius * 1.5,
                            height: circleRadius * 1.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF3B82F6).withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  Container(
                    width: circleRadius * 1.4,
                    height: circleRadius * 1.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isScanning
                            ? Color(0xFF3B82F6)
                            : Colors.white.withOpacity(0.8),
                        width: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Status text and button aligned BELOW the circle
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 120), // below circle
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isScanning
                        ? 'keep_face_in_circle'.tr
                        : _isCameraInitialized
                        ? 'position_face'.tr
                        : _statusMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  if (_isScanning)
                    Text(
                      '${'scanning'.tr} $_secondsRemaining ${'seconds_remaining'.tr}',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    )
                  else if (!_isComplete && _isCameraInitialized)
                    Text(
                      'tap_to_begin'.tr,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                ],
              ),
            ),
          ),

          // Bottom button
          if (!_isScanning && !_isComplete && _isCameraInitialized)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startScanning,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B82F6),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.face, color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'authenticate_faceid'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black87, Colors.black],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isCameraInitialized)
              CircularProgressIndicator(color: Color(0xFF3B82F6)),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final bool isScanning;

  CircularProgressPainter({
    required this.progress,
    required this.isScanning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isScanning) return;

    final Paint backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = Color(0xFF3B82F6)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.2;

    canvas.drawCircle(center, radius, backgroundPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -3.14159 / 2;
    final sweepAngle = 2 * 3.14159 * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CircleClipper extends CustomClipper<Path> {
  final double centerX;
  final double centerY;
  final double radius;

  CircleClipper({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}