import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CuTextField extends StatelessWidget {
  TextEditingController? controller;
  String title;
  Widget? suffixIcon;
  String? Function(String?)? validator;

  CuTextField({super.key, this.controller,required this.title , this.suffixIcon , this.validator,});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: GoogleFonts.quicksand(
        fontSize: 15,
      ),
      decoration:  InputDecoration(
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: title,
        hintStyle: GoogleFonts.quicksand(
          fontSize: 12,
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
                color: Colors.black45,
              )
          ),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w900
                ),
              ),
              Spacer(),
              Icon(icon , color: Colors.black45,size: 20,),
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
          color: Colors.black45,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),

      child: DropdownButton(
        iconSize: 30,
        underline: SizedBox(),
        isExpanded: true,
        value: _selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        items: widget.item!.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
               style: GoogleFonts.quicksand(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w900
            ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CuText extends StatelessWidget {
  String title;
  double? fontSize;
  CuText(this.title, {this.fontSize = 16,super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.quicksand(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}



