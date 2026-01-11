import 'package:flutter/material.dart';

class CreateCategoryWidgetA extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController descriptionCtrl;
  final VoidCallback onCreatePress;
  final bool isLoading;
  final String? errorMessage;

  const CreateCategoryWidgetA({
    super.key,
    required this.nameCtrl,
    required this.descriptionCtrl,
    required this.onCreatePress,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<CreateCategoryWidgetA> createState() => _CreateCategoryWidgetAState();
}

class _CreateCategoryWidgetAState extends State<CreateCategoryWidgetA> {
  bool _slugManuallyEdited = false;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = widget.nameCtrl;
    _descriptionCtrl = widget.descriptionCtrl;
    _nameCtrl.addListener(_onNameChanged);
    _descriptionCtrl.addListener(_onSlugChanged);
    if (_nameCtrl.text.isNotEmpty && _descriptionCtrl.text.isEmpty) {
      _descriptionCtrl.text = _generateSlug(_nameCtrl.text);
    }
  }

  @override
  void dispose() {
    _nameCtrl.removeListener(_onNameChanged);
    _descriptionCtrl.removeListener(_onSlugChanged);
    super.dispose();
  }

  String _generateSlug(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');
  }

  void _onNameChanged() {
    if (!_slugManuallyEdited) {
      final slug = _generateSlug(_nameCtrl.text);
      if (_descriptionCtrl.text != slug) {
        _descriptionCtrl.text = slug;
      }
    }
  }

  void _onSlugChanged() {
    final expected = _generateSlug(_nameCtrl.text);
    _slugManuallyEdited = _descriptionCtrl.text != expected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 60),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            controller: _nameCtrl,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: inputDecoration("Name"),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            controller: _descriptionCtrl,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: inputDecoration("Slug"),
          ),
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
        const SizedBox(height: 40),
        SizedBox(
          height: 50,
          width: 350,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onCreatePress,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE82925),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              widget.isLoading ? "Saving..." : "Save",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF272727),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF535353), width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}