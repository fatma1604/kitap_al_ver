import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/service/categry.dart';
import 'package:kitap_al_ver/service/forımHelper.dart';
import 'package:kitap_al_ver/utils/color.dart';

class Information extends StatefulWidget {
  final CategoryModel category;

  const Information({Key? key, required this.category}) : super(key: key);

  @override
  State<Information> createState() => _MenuPageState();
}

class _MenuPageState extends State<Information> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String>? _postImages;
  String? selectedClass,
      selectedType,
      selectedSubject,
      selectedDurum,
      selectedHistory,
      _title,
      _additionalInfo;
  List<String> menuItems = [];
  List<String> _like = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  Future<void> fetchMenuItems() async {
    try {
      setState(() {
        menuItems = widget.category.classes;
      });
    } catch (e) {
      print("Error fetching menu items: $e");
    }
  }

  Future<void> navigateToGallery() async {
    FormHelpers.navigateToGallery(context, (images) {
      setState(() {
        _postImages = images;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.darttBg : AppColor.lightBg,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitleField(),
              const SizedBox(height: 20),
              _buildDropdownField(AppText.classSelect, selectedClass, menuItems,
                  (value) => setState(() => selectedClass = value)),
              const SizedBox(height: 20),
              _buildDropdownField(
                  AppText.typeSelect,
                  selectedType,
                  widget.category.types,
                  (value) => setState(() => selectedType = value)),
              const SizedBox(height: 20),
              _buildDropdownField(
                  AppText.subjectSelect,
                  selectedSubject,
                  widget.category.subjects,
                  (value) => setState(() => selectedSubject = value)),
              const SizedBox(height: 20),
              _buildDropdownField(
                  AppText.statusSelect,
                  selectedDurum,
                  widget.category.durum,
                  (value) => setState(() => selectedDurum = value)),
              const SizedBox(height: 20),
              _buildDropdownField(
                  AppText.historySelect,
                  selectedHistory,
                  widget.category.history,
                  (value) => setState(() => selectedHistory = value)),
              const SizedBox(height: 20),
              _buildAdditionalInfoField(),
              SizedBox(height: 32.h),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor: isDarkMode ? AppColor.darttBg : AppColor.lightBg,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pushNamed(context, '/liquidTab'),
      ),
      centerTitle: true,
      title: const Text(AppText.addInformation,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      actions: [
        IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: navigateToGallery,
        ),
      ],
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: AppText.title,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: AppColor.icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? AppText.fieldRequired : null,
      onChanged: (value) => setState(() => _title = value),
    );
  }

  DropdownButtonFormField<String> _buildDropdownField(String label,
      String? value, List<String> items, ValueChanged<String?>? onChanged) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: AppColor.icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
      ),
      value: value,
      items: items
          .map((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      style: TextStyle(color: isDarkMode ? AppColor.textDark : AppColor.icon),
      dropdownColor: isDarkMode ? AppColor.screendart1 : AppColor.screenlight2,
    );
  }

  TextFormField _buildAdditionalInfoField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: AppText.information,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: AppColor.icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
      ),
      maxLines: 3,
      onChanged: (value) => setState(() => _additionalInfo = value),
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonlight,
        foregroundColor: AppColor.black,
      ),
      onPressed: () {
        FormHelpers.submitForm(
          context: context,
          formKey: _formKey,
          title: _title ?? '',
          selectedClass: selectedClass,
          selectedUsageStatus: selectedDurum,
          selectedType: selectedType,
          selectedSubject: selectedSubject,
          additionalInfo: _additionalInfo ?? '',
          description: '',
          postImages: _postImages,
          like: _like,
          auth: FirebaseAuth.instance,
          firestore: _firestore,
          category: widget.category.categoryname,
        );
      },
      child: const Text("Resimleri At"),
    );
  }
}
