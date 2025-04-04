import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/pages/modifierArticle/modifierArticleCtrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiselect/multiselect.dart';

class ModifierArticlePage extends ConsumerStatefulWidget {
  const ModifierArticlePage({super.key});

  @override
  ConsumerState<ModifierArticlePage> createState() => _ModifyArticleScreenState();
}

class _ModifyArticleScreenState extends ConsumerState<ModifierArticlePage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _imageUrlController = TextEditingController();

  int? _selectedCategory;
  List<Category> selectedCategories=[];
  Article? _article;

  List<Category> _options = [];
  List<int> _selectedOptions = [];

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state= ref.watch(modifierArticleCtrlProvider);
    _options = state.categories?? [];
    _article = state.article;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Modifier l\'article'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Titre
            const Text(
              'Titre',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: _article?.title??""),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'URL de l\'image',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: _article?.photo??""),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Section Auteur
            const Text(
              'Auteur',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: _article?.auteur??""),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            // Section Categorie
            const SizedBox(height: 8),
            const Text(
              'Catégorie',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            TextField(
              readOnly: true,
              onTap: () => _showMultiSelectDialog(context),
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Titre exemple',
              ),
            ),
            const SizedBox(height: 24),

            // Séparateur
            const Divider(thickness: 1),
            const SizedBox(height: 24),

            // Bouton Enregistrer
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(state.isLoading==true) return;
                  _saveChanges();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child:  Text(state.isLoading==true?"Chargement....":'Enregistrer'),
              ),
            ),
            const SizedBox(height: 16),

            // Bouton Supprimer
            Center(
              child: TextButton(
                onPressed: () {
                  _deleteArticle();
                },
                child: const Text(
                  'Supprimer l\'article',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_titleController.text.isEmpty ||
        _imageUrlController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Modifications enregistrées avec succès')),
    );

    print('Nouveaux valeurs:');
    print('Titre: ${_titleController.text}');
    print('Image URL: ${_imageUrlController.text}');
    print('Auteur: ${_authorController.text}');
    print('Catégorie: $_selectedCategory');
  }

  void _deleteArticle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'article'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Article supprimé avec succès')),
              );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showMultiSelectDialog(BuildContext context) async {
    List<int> tempSelectedOptions = List.from(_selectedOptions);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Select Options"),
              content: SingleChildScrollView(
                child: Column(
                  children: _options.map((option) {
                    return CheckboxListTile(
                      value: _selectedOptions.contains(option.id),
                      title: Text(option.name??""),
                      onChanged: (isChecked) {
                        setState(() {
                          if (isChecked ?? false) {
                            _selectedOptions.add(option.id??0);
                          } else {
                            _selectedOptions.remove(option.id??0);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptions = tempSelectedOptions;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}