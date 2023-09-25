import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CuTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? initialValue;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CuTextField({
    Key? key,
    this.controller,
    this.title,
    this.suffixIcon,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      controller: controller,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: title,
        hintStyle: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class CuTime extends StatelessWidget {
  String title;
  IconData icon;
  double? width;
  double? height;
  Function()? onTap;
  CuTime(this.title,this.icon, {super.key, this.width,this.height,this.onTap});
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onTap,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light? Colors.black45 : Colors.white70,
              )
          ),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14),
              ),
              const Spacer(),
              Icon(icon,size: 20,),
            ],
          ),
        ),
      );
  }
}

class CuDrop extends StatefulWidget {
  final String? title;
  List<String>? item ;
  CuDrop({super.key, this.title,required this.item});

  @override
  _CuDropState createState() => _CuDropState();
}

class _CuDropState extends State<CuDrop> {
  String? _selectedValue; // To keep track of the selected value
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light? Colors.black45 : Colors.white70,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        focusColor: Colors.transparent,
        iconSize: 30,
        underline: const SizedBox(),
        isExpanded: true,
        value: _selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        items: [
          // Add "None" as the initial value
          DropdownMenuItem(
            value: "None",
            child: Text(
              "None",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14),
            ),
          ),
          // Use spread operator to include items from widget.item
          ...widget.item!.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}




