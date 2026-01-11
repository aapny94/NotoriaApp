import 'package:flutter/material.dart';
import '../../../core/widgets/bg_design_3.dart';
import '../../../core/widgets/editCategory_widget.dart';
import '../../../data/services/category/category_create_api.dart';
import '../../../data/services/category/category_update_api.dart';
import '../../../data/services/category/category_get_api.dart';

class EditCategories extends StatefulWidget {
  final String? docId;
  EditCategories({super.key, this.docId});

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategoryIfNeeded();
  }

  Future<void> _loadCategoryIfNeeded() async {
    if (widget.docId == null) return;
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    try {
      final data = await CategoryGetApi().getCategory(widget.docId!);
      if (data != null) {
        final attrs = data['attributes'] ?? data;
        nameCtrl.text = attrs['name']?.toString() ?? '';
        descCtrl.text = attrs['slug']?.toString() ?? '';
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load category: ${e.toString()}';
      });
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    setState(() {
      errorMessage = null;
    });

    final name = nameCtrl.text.trim();
    final slug = descCtrl.text.trim();

    if (name.isEmpty || slug.isEmpty) {
      setState(() {
        errorMessage = 'Name and slug are required';
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      if (widget.docId != null) {
        final api = CategoryUpdateApi();
        await api.updateCategory(docId: widget.docId!, name: name, slug: slug);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Category updated')));
        Navigator.of(context).pop(true);
      } else {
        final api = CategoryCreateApi();
        await api.createCategory(name: name, slug: slug);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Category created')));
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: Stack(
        children: [
          Positioned.fill(child: BgDesign3()),
          // Your main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                  ),
                ),
                CreateCategoryWidgetA(
                  nameCtrl: nameCtrl,
                  descriptionCtrl: descCtrl,
                  isLoading: isLoading,
                  errorMessage: errorMessage,
                  onCreatePress: _handleCreate,
                ),
                // Add your form fields and buttons here
              ],
            ),
          ),
          // Custom small back button
          Positioned(
            top: 68,
            left: 30,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE82925),
                  borderRadius: BorderRadius.circular(45),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
