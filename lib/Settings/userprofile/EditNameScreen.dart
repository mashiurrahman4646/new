import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appearance/ThemeController.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    // Initialize with current user data (would normally come from state management)
    _firstNameController.text = 'John';
    _lastNameController.text = 'Doe';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: themeController.isDarkModeActive ? Color(0xFF121212) : Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'edit_name'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Profile Icon
              Center(
                child: Container(
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.25,
                  decoration: BoxDecoration(
                    color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: screenWidth * 0.15,
                    color: const Color(0xFF2196F3),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Instruction Text
              Center(
                child: Text(
                  'name_appearance_info'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // First Name Field
              Text(
                'first_name'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'first_name_required'.tr;
                  }
                  return null;
                },
                style: TextStyle(
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'enter_first_name'.tr,
                  hintStyle: TextStyle(
                    color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Last Name Field
              Text(
                'last_name'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'last_name_required'.tr;
                  }
                  return null;
                },
                style: TextStyle(
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'enter_last_name'.tr,
                  hintStyle: TextStyle(
                    color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'save_changes'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Save the changes (would normally update state management)
      String newFullName = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';

      Get.back();
      Get.snackbar(
        'success'.tr,
        '${'name_updated_to'.tr} $newFullName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}