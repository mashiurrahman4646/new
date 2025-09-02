import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import '../../colors/app_colors.dart';
import 'face_login_controller.dart';
import '../../routes/app_routes.dart';

class FaceLoginScreen extends StatefulWidget {
  @override
  _FaceLoginScreenState createState() => _FaceLoginScreenState();
}

class _FaceLoginScreenState extends State<FaceLoginScreen>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  List<CameraDescription> _cameras = [];

  late AnimationController _animationController;
  late Animation<double> _animation;

  final FaceLoginController controller = Get.put(FaceLoginController());

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;
      final frontCamera = _cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
      Get.snackbar(
        'Camera Error',
        'Unable to access camera. Please check permissions.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _startVerification() {
    controller.startVerification();
    _animationController.reset();
    _animationController.forward();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        controller.completeVerification();
        // Navigate to MainHomeScreen after successful verification
        Get.offNamed(AppRoutes.mainHome);
      }
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back arrow
        title: const Text(
          'Face Verification',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<FaceLoginController>(
        builder: (controller) => Stack(
          children: [
            // Camera Preview (Base Layer)
            if (_isCameraInitialized)
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary500),
              ),

            // Face Detection Overlay
            if (_isCameraInitialized)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return FaceOverlayWidget(
                      screenSize: screenSize,
                      progress: _animation.value,
                      isVerifying: controller.isVerifying,
                    );
                  },
                ),
              ),

            // Top Instructions
            if (!controller.isVerifying)
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Position your face within the circle and tap the button below to start verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

            // Bottom Section
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54, Colors.black87],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.isVerifying)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary500.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Verifying... Keep your face in the circle',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (!controller.isVerifying)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isCameraInitialized ? _startVerification : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary500,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.face, size: 24),
                              SizedBox(width: 8),
                              Text(
                                'Authenticate Using Face ID',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (!controller.isVerifying)
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoutes.login),
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceOverlayWidget extends StatelessWidget {
  final Size screenSize;
  final double progress;
  final bool isVerifying;

  const FaceOverlayWidget({
    Key? key,
    required this.screenSize,
    required this.progress,
    required this.isVerifying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final center = Offset(screenSize.width / 2, screenSize.height / 2 - 50);
    final radius = screenSize.width * 0.35;

    return Stack(
      children: [
        // Dark overlay with hole using ClipPath
        ClipPath(
          clipper: CircleHoleClipper(center: center, radius: radius),
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.black.withOpacity(0.6),
          ),
        ),

        // Circle border and progress indicator
        CustomPaint(
          size: screenSize,
          painter: CircleBorderPainter(
            center: center,
            radius: radius,
            progress: progress,
            isVerifying: isVerifying,
          ),
        ),
      ],
    );
  }
}

class CircleHoleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleHoleClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final holePath = Path();
    holePath.addOval(Rect.fromCircle(center: center, radius: radius));

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CircleBorderPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final double progress;
  final bool isVerifying;

  CircleBorderPainter({
    required this.center,
    required this.radius,
    required this.progress,
    required this.isVerifying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw circle border
    final borderPaint = Paint()
      ..color = isVerifying ? AppColors.primary500 : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius, borderPaint);

    // Draw progress arc during verification
    if (isVerifying && progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary500
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.14159 * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -3.14159 / 2, // Start from top
        sweepAngle,
        false,
        progressPaint,
      );
    }

    // Draw corner guides when not verifying
    if (!isVerifying) {
      final guidePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final guideLength = 20.0;
      final positions = [
        center + Offset(-radius * 0.7, -radius * 0.7), // Top-left
        center + Offset(radius * 0.7, -radius * 0.7),  // Top-right
        center + Offset(-radius * 0.7, radius * 0.7),  // Bottom-left
        center + Offset(radius * 0.7, radius * 0.7),   // Bottom-right
      ];

      for (final pos in positions) {
        // Horizontal lines
        canvas.drawLine(
          pos + const Offset(-10, 0),
          pos + Offset(guideLength - 10, 0),
          guidePaint,
        );
        // Vertical lines
        canvas.drawLine(
          pos + const Offset(0, -10),
          pos + Offset(0, guideLength - 10),
          guidePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CircleBorderPainter &&
        (oldDelegate.progress != progress || oldDelegate.isVerifying != isVerifying);
  }
}