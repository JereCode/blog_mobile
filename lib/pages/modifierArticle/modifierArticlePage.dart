import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/ModifierArticle.dart';
import 'package:blog_mobile/Business/models/Tag.dart';
import 'package:blog_mobile/pages/login/loginCtrl.dart';
import 'package:blog_mobile/pages/modifierArticle/modifierArticleCtrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiselect/multiselect.dart';

class ModifierArticlePage extends ConsumerStatefulWidget {
  final int articleId;
  const ModifierArticlePage({super.key,required this.articleId});

  @override
  ConsumerState<ModifierArticlePage> createState() => _ModifyArticleScreenState();
}

class _ModifyArticleScreenState extends ConsumerState<ModifierArticlePage> {
  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  var _imageUrlController = TextEditingController();
  var _categoryController = TextEditingController();
  var _tagController = TextEditingController();

  List<Category> selectedCategories = [];
  List<Tag> selectedTags = [];
  Article? _article;

  List<Category> _optionsCategorie = [];
  List<Tag> _optionsTag = [];
  List<int> _selectedOptionsCategorie = [];
  List<int> _selectedOptionsTag = [];

  // Couleurs du thème
  final Color primaryColor = const Color(0xFFE53935); // Rouge pas trop vif
  final Color backgroundColor = Colors.white;
  final Color textColor = const Color(0xFF424242);
  final Color lightRedColor = const Color(0xFFFFCDD2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      var ctrl = ref.read(modifierArticleCtrlProvider.notifier);
      var loginState = ref.read(loginCtrlProvider);
      // TODO: recuperer le user connecté et prendre le token
      var token = "1|fnUcyBqy31wBTpidLIQcuLydKRhsiOnCVKsZNFci9ce3b35a";
      var article = await ctrl.recupererArticleParId(11, token);
      await ctrl.recupererTags();
      if(article != null){
        var categoriesText = (article.category??[]).map((e) => e.name).toList().join(";");
        var tagsText = (article.tags??[]).map((e) => e.name).toList().join(";");
        _titleController = TextEditingController(text: article.title ??"");
        _contentController = TextEditingController(text: article.content?? "");
        _imageUrlController = TextEditingController(text: article.photo??"");
        _categoryController = TextEditingController(text: categoriesText);
        _tagController = TextEditingController(text: tagsText);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(modifierArticleCtrlProvider);
    _optionsCategorie = state.categories?? [];
    _optionsTag = state.tags?? [];
    _article = state.article;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: primaryColor,
        title: Text(
          'Modifier l\'article',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Titre
            _buildSectionTitle('Titre'),
            const SizedBox(height: 8),
            _buildTextField(_titleController),

            const SizedBox(height: 20),
            _buildSectionTitle('URL de l\'image'),
            const SizedBox(height: 8),
            _buildTextField(_imageUrlController),

            const SizedBox(height: 20),
            _buildSectionTitle('Contenu'),
            const SizedBox(height: 8),
            _buildTextField(_contentController, maxLines: 8),

            const SizedBox(height: 20),
            _buildSectionTitle('Catégorie'),
            const SizedBox(height: 8),
            _buildSelectField(_categoryController, () => _showMultiSelectDialogCategorie(context)),

            const SizedBox(height: 20),
            _buildSectionTitle('Tag'),
            const SizedBox(height: 8),
            _buildSelectField(_tagController, () => _showMultiSelectDialogTag(context)),

            const SizedBox(height: 30),
            // Boutons d'action
            _buildActionButtons(state),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSelectField(TextEditingController controller, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: TextField(
        controller: controller,
        readOnly: true,
        enabled: false,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          suffixIcon: Icon(Icons.arrow_drop_down, color: primaryColor),
        ),
      ),
    );
  }

  Widget _buildActionButtons(state) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isLoading ? null : _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: state.isLoading
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Chargement...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            )
                : Text(
              'Enregistrer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 14),
        TextButton.icon(
          onPressed: _deleteArticle,
          icon: Icon(Icons.delete_outline, color: primaryColor.withOpacity(0.9)),
          label: Text(
            'Supprimer l\'article',
            style: TextStyle(
              color: primaryColor.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _saveChanges() async {
    String title = _titleController.text;
    String photo = _imageUrlController.text;
    String content = _contentController.text;

    // Utiliser uniquement les IDs des catégories et des tags
    var categories = _selectedOptionsCategorie;  // Liste des IDs des catégories sélectionnées
    var tags = _selectedOptionsTag;              // Liste des IDs des tags sélectionnés

    // Validation
    if (title.isEmpty ||
        photo.isEmpty ||
        content.isEmpty ||
        categories.isEmpty ||
        tags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
        ),
      );
      return;
    }

    int articleId = widget.articleId;
    var token = "1|J5atvH7P7IP4qzeYc86Ycq5mL6P3bloZ3PgkDvD8d06e09d1";

    var data = ModifierArticle(
      title: title,
      photo: photo,
      content: content,
      categories: categories,  // Passer uniquement les IDs ici
      tags: tags,              // Passer uniquement les IDs ici
    );

    var ctrl = ref.read(modifierArticleCtrlProvider.notifier);
    var article = await ctrl.modifierArticle(11, data, token);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modifications enregistrées avec succès'),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
      ),
    );
  }

  void _deleteArticle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer l\'article'),
        content: Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Article supprimé avec succès'),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                ),
              );
            },
            child: Text(
              'Supprimer',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showMultiSelectDialogCategorie(BuildContext context) async {
    // Sauvegarder l'état initial des catégories sélectionnées
    List<int> tempSelectedOptions = List.from(_selectedOptionsCategorie);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Sélectionner les catégories",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _optionsCategorie.map((option) {
                      return CheckboxListTile(
                        value: _selectedOptionsCategorie.contains(option.id),
                        title: Text(
                          option.name ?? "",
                          style: TextStyle(color: textColor),
                        ),
                        activeColor: primaryColor,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          setState(() {
                            if (isChecked ?? false) {
                              // Ajoute l'ID à la liste des options sélectionnées
                              _selectedOptionsCategorie.add(option.id ?? 0);
                            } else {
                              // Retire l'ID de la liste des options sélectionnées
                              _selectedOptionsCategorie.remove(option.id ?? 0);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Annuler",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Mettre à jour le champ texte avec les catégories sélectionnées
                    List<String> selectedCategoryNames = _optionsCategorie
                        .where((category) => _selectedOptionsCategorie.contains(category.id))
                        .map((category) => category.name ?? "")
                        .toList();

                    _categoryController.text = selectedCategoryNames.join("; ");

                    // Assurez-vous que la liste des catégories sélectionnées soit mise à jour dans le state
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Confirmer",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMultiSelectDialogTag(BuildContext context) async {
    List<int> tempSelectedOptions = List.from(_selectedOptionsTag);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Sélectionner les tags",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _optionsTag.map((option) {
                      return CheckboxListTile(
                        value: _selectedOptionsTag.contains(option.id),
                        title: Text(
                          option.name ?? "",
                          style: TextStyle(color: textColor),
                        ),
                        activeColor: primaryColor,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          setState(() {
                            if (isChecked ?? false) {
                              _selectedOptionsTag.add(option.id ?? 0);
                            } else {
                              _selectedOptionsTag.remove(option.id ?? 0);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Annuler",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Mettre à jour le champ texte avec les tags sélectionnés
                    List<String> selectedTagNames = _optionsTag
                        .where((tag) => _selectedOptionsTag.contains(tag.id))
                        .map((tag) => tag.name ?? "")
                        .toList();

                    _tagController.text = selectedTagNames.join("; ");

                    // Assurez-vous que la liste des tags sélectionnés soit mise à jour dans le state
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Confirmer",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}