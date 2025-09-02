import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import '../../colors/app_colors.dart';
import 'SignupfaceVerificationScreen_controller.dart';

class SignupVerificationScreen extends StatefulWidget {
  @override
  _SignupVerificationScreenState createState() => _SignupVerificationScreenState();
}

class _SignupVerificationScreenState extends State<SignupVerificationScreen>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  List<CameraDescription> _cameras = [];

  late AnimationController _animationController;
  late Animation<double> _animation;

  final SignupVerificationController controller = Get.put(SignupVerificationController());

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
        'camera_error'.tr,
        'camera_permission_error'.tr,
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
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Get.toNamed('/faceConfirmation');
          }
        });
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
        title: Text(
          'face_verification'.tr,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<SignupVerificationController>(
        builder: (controller) => Stack(
          children: [
            // Camera Preview
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
                      isVerifying: controller.isVerifying.value,
                    );
                  },
                ),
              ),

            // Top Instructions
            if (!controller.isVerifying.value && !controller.isVerificationComplete.value)
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
                  child: Text(
                    'face_position_instruction'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                    if (controller.isVerifying.value)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primary500.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'verifying_keep_face'.tr,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    if (!controller.isVerifying.value && !controller.isVerificationComplete.value)
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.face, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'authenticate_face_id'.tr,
                                style: const TextStyle(
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

                    if (!controller.isVerifying.value)
                      TextButton(
                        onPressed: () => Get.offNamedUntil('/register', (route) => false),
                        child: Text(
                          'back_to_signup'.tr,
                          style: const TextStyle(
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

            // Verification Complete Overlay
            if (controller.isVerificationComplete.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 50),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'verification_done'.tr,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'face_auth_success'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
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
        ClipPath(
          clipper: CircleHoleClipper(center: center, radius: radius),
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
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
    final borderPaint = Paint()
      ..color = isVerifying ? AppColors.primary500 : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius, borderPaint);

    if (isVerifying && progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary500
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.14159 * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -3.14159 / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CircleBorderPainter &&
          (oldDelegate.progress != progress || oldDelegate.isVerifying != isVerifying);
}
