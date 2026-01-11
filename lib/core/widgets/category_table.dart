import 'package:flutter/material.dart';
import '../../data/services/category/category_list_api.dart';
import '../../pages/Categories/screens/edit_categories.dart';
import '../../data/services/category/category_delete_api.dart';

class CategoriesTable extends StatefulWidget {
  CategoriesTable({super.key});

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<CategoriesTable> {
  final CategoryListApi _api = CategoryListApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _api.getUserCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Failed to load categories:\n${snapshot.error}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        final List<dynamic> items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(
            child: Text(
              'No categories found for this user.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER (not scrollable)
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: const [
                  Expanded(
                    flex: 4,
                    child: Text('Name', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text('Slug', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // 🟢 WRAPPED BODY (scrollable + rounded bg + border)
            // 🟢 WRAPPED BODY (scrollable + rounded bg + border)
            SizedBox(
              height: 540, // 👈 your custom height
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        Container(height: 1, color: const Color(0xFF333333)),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final attrs = item['attributes'] ?? item;

                      final name = attrs['name']?.toString() ?? '-';
                      final slug = attrs['slug']?.toString() ?? '-';
                      final docId = item['documentId']?.toString();

                      return Padding(
                        padding: const EdgeInsets.only(left: 24, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                slug,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: PopupMenuButton<String>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: const Color(0xFF272727),
                                  onSelected: (value) async {
                                    if (value == 'edit') {
                                      final updated =
                                          await Navigator.push<bool?>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditCategories(docId: docId),
                                            ),
                                          );

                                      if (updated == true) {
                                        if (mounted) setState(() {});
                                      }
                                    } else if (value == 'delete') {
                                      if (docId == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Cannot delete: missing id',
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor: const Color(
                                            0xFF1B1B1B,
                                          ), // dialog background
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          title: const Text(
                                            'Delete category',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ), // title color
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this category? This action cannot be undone.',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ), // content color
                                          ),
                                          actionsPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(false),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white70,
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(true),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .red, // button background
                                                foregroundColor: Colors
                                                    .white, // button text color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        try {
                                          await CategoryDeleteApi()
                                              .deleteCategory(docId!);
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Category deleted'),
                                            ),
                                          );
                                          setState(() {});
                                        } catch (e) {
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                e.toString().replaceFirst(
                                                  'Exception: ',
                                                  '',
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
