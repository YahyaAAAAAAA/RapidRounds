import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/global_colors.dart';

class NameContainer extends StatelessWidget {
  const NameContainer({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: nameController,
              style: TextStyle(
                color: GColors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Name',
                //note: hides maxLength counter
                counterText: "",

                hintStyle: TextStyle(
                  color: GColors.white,
                  fontSize: 17,
                ),
                fillColor: GColors.black,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GColors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GColors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
