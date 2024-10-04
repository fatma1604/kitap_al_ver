import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/categry.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/service/for%C4%B1mHelper.dart';
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
              SizedBox(height: 20),
              _buildDropdownField("Sınıf Seçin", selectedClass, menuItems,
                  (value) => setState(() => selectedClass = value)),
              SizedBox(height: 20),
              _buildDropdownField(
                  "Tür Seçin",
                  selectedType,
                  widget.category.types,
                  (value) => setState(() => selectedType = value)),
              SizedBox(height: 20),
              _buildDropdownField(
                  "Konu Başlığı Seçin",
                  selectedSubject,
                  widget.category.subjects,
                  (value) => setState(() => selectedSubject = value)),
              SizedBox(height: 20),
              _buildDropdownField(
                  "Durum Seçin",
                  selectedDurum,
                  widget.category.durum,
                  (value) => setState(() => selectedDurum = value)),
              SizedBox(height: 20),
              _buildDropdownField(
                  "Geçmiş Seçin",
                  selectedHistory,
                  widget.category.history,
                  (value) => setState(() => selectedHistory = value)),
              SizedBox(height: 20),
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
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LiquidTabBar())),
      ),
      centerTitle: true,
      title: const Text('Bilgi Ekleme',
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
      decoration: const InputDecoration(
          labelText: 'İlan Başlığı', border: OutlineInputBorder()),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Bu alan zorunludur' : null,
      onChanged: (value) => setState(() => _title = value),
    );
  }

  DropdownButtonFormField<String> _buildDropdownField(String label,
      String? value, List<String> items, ValueChanged<String?>? onChanged) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color:isDarkMode? AppColor.screendart1:AppColor.screenlight1 ), // Change this to your desired color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:isDarkMode? AppColor.black:AppColor.white), // Change this to your desired color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:isDarkMode? AppColor.black:AppColor.white), // Change this to your desired color
        ),
      ),
      value: value,
      items: items
          .map((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      style: TextStyle(
          color:isDarkMode? AppColor.yazidart:AppColor.yazilight), // Change this to your desired text color
      dropdownColor:isDarkMode? AppColor
          .screendart1:AppColor.screenlight1, // Change this to your desired dropdown background color
    );
  }

  TextFormField _buildAdditionalInfoField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Ek Bilgi', border: OutlineInputBorder()),
      maxLines: 3,
      onChanged: (value) => setState(() => _additionalInfo = value),
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
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
          description: '', // Add logic to get description
          postImages: _postImages,
          like: _like,
          auth: FirebaseAuth.instance,
          firestore: _firestore,
        );
      },
      child: Text("Kaydet"),
    );
  }
}
