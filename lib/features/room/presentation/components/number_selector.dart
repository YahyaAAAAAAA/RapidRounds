import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class NumberSelector extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberSelector({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    setState(() {
      if (_currentValue < widget.maxValue) {
        _currentValue++;
        widget.onChanged(_currentValue);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_currentValue > widget.minValue) {
        _currentValue--;
        widget.onChanged(_currentValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove,
            size: 15,
            color: GColors.black,
          ),
          onPressed: _decrement,
        ),
        Text(
          '$_currentValue',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Barr',
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            size: 15,
            color: GColors.black,
          ),
          onPressed: _increment,
        ),
      ],
    );
  }
}
