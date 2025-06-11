import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/capitalize.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _focusPrice = FocusNode();
  final _focusDescription = FocusNode();
  final _focusImage = FocusNode();
  final _imageController = TextEditingController();
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void initState() {
    super.initState();
    _focusImage.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;
        _formData['price'] = product.price;
        _imageController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusPrice.dispose();
    _focusDescription.dispose();
    _focusImage.dispose();
    _focusImage.removeListener(_updateImage);
  }

  void _updateImage() {
    if (_isValidImageUrl(_imageController.text)) {
      setState(() {});
    }
  }

  bool _isValidImageUrl(String url) {
    final bool uri = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    final List<String> validPaths = ['.png', '.jpg', '.jpeg', '.webp'];
    final bool filaPath = validPaths.any(
      (path) => url.toLowerCase().endsWith(path),
    );
    return uri && filaPath;
  }

  Future<void> _submitForm() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Produto salvo com sucesso!")),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      final errorMessage = e.toString().split(': ').length > 1
          ? e.toString().split(': ').sublist(1).join(': ')
          : e.toString();
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.warning_amber_sharp, size: 36.0),
          iconColor: Colors.amber,
          title: const Text("Erro ao salvar produto"),
          content: Text('[ERROR]: $errorMessage'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Produto"),
        actions: [
          IconButton(onPressed: _submitForm, icon: Icon(Icons.save_sharp)),
        ],
      ),
      body: _isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        initialValue: _formData['title'] ?? '',
                        decoration: InputDecoration(labelText: "Nome"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(
                          context,
                        ).requestFocus(_focusDescription),
                        onSaved: (title) => _formData['title'] = (title ?? '')
                            .capitalizeSingle(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome é obrigatório!';
                          }
                          if (value.trim().length < 3) {
                            return 'Nome deve ter pelo menos 3 caracteres!';
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        initialValue: _formData['description'] ?? '',
                        decoration: InputDecoration(labelText: "Descrição"),
                        focusNode: _focusDescription,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(_focusImage),
                        onSaved: (description) => _formData['description'] =
                            (description ?? '').trim(),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Image URL"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            focusNode: _focusImage,
                            controller: _imageController,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = (imageUrl ?? '').trim(),
                            onFieldSubmitted: (value) => FocusScope.of(
                              context,
                            ).requestFocus(_focusPrice),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'URL da imagem é obrigatória!';
                              }
                              if (!_isValidImageUrl(value)) {
                                return 'URL da imagem inválida!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1.0,
                            ),
                          ),
                          child: _imageController.text.isEmpty
                              ? CustomPaint(painter: XPainter())
                              : FittedBox(
                                  child: Image.network(
                                    _imageController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        initialValue: _formData['price'] ?? '',
                        decoration: InputDecoration(labelText: "Preço"),
                        textInputAction: TextInputAction.done,
                        focusNode: _focusPrice,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onSaved: (price) {
                          _formData['price'] =
                              Decimal.tryParse(
                                price?.trim().replaceAll(',', '.') ?? '0.0',
                              )?.toStringAsFixed(2) ??
                              '0.0';
                        },
                        onFieldSubmitted: (_) => _submitForm(),
                        validator: (value) {
                          final cleanedValue =
                              value?.trim().replaceAll(',', '.') ?? '';

                          if (cleanedValue.isEmpty) {
                            return 'Preço é obrigatório!';
                          }

                          final Decimal? parsedValue = Decimal.tryParse(
                            cleanedValue,
                          );

                          if (parsedValue == null ||
                              parsedValue < Decimal.parse('0.01')) {
                            return 'Preço deve ser maior ou igual a R\$ 0,01!';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class XPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
