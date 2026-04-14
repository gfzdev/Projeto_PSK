import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // Chave para validar o formulário
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para capturar o que for digitado
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  
  bool _carregando = false;

  // Função que envia os dados para o Java
  Future<void> _salvarProduto() async {
    if (!_formKey.currentState!.validate()) return; // Só avança se tudo estiver preenchido

    setState(() {
      _carregando = true;
    });

    // ATENÇÃO: Muda para 10.0.2.2 se estiveres no emulador Android
    final url = Uri.parse('http://localhost:8080/api/produtos'); 

    try {
      final resposta = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        // Converte os dados da tela num JSON que o Java entende
        body: json.encode({
          'nome': _nomeController.text,
          'preco': double.parse(_precoController.text.replaceAll(',', '.')),
          'caminhoImagem': _imagemController.text,
          'tag': _tagController.text,
        }),
      );

      if (resposta.statusCode == 200 || resposta.statusCode == 201) {
        // Mostra uma mensagem de sucesso verde
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto cadastrado com sucesso!'), backgroundColor: Colors.green),
          );
        }
        // Limpa os campos para o próximo cadastro
        _nomeController.clear();
        _precoController.clear();
        _imagemController.clear();
        _tagController.clear();
      } else {
        throw Exception('Erro ao salvar no servidor (Código: ${resposta.statusCode})');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fundo principal
      appBar: AppBar(
        title: const Text('Cadastrar Produto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFF6B00)), // Seta de voltar laranja
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _construirCampoTexto(label: 'Nome do Produto (Ex: Corta Vento)', controller: _nomeController),
              const SizedBox(height: 16),
              _construirCampoTexto(label: 'Preço (Ex: 249.90)', controller: _precoController, ehNumero: true),
              const SizedBox(height: 16),
              _construirCampoTexto(label: 'Caminho da Imagem (Ex: PSKSTORY/casaco.jpeg)', controller: _imagemController),
              const SizedBox(height: 16),
              _construirCampoTexto(label: 'Tag (Ex: INVERNO)', controller: _tagController),
              const SizedBox(height: 32),
              
              // Botão Salvar
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B00),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _carregando ? null : _salvarProduto,
                  child: _carregando
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'CADASTRAR',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizável para deixar os inputs bonitos e parecidos com o card
  Widget _construirCampoTexto({required String label, required TextEditingController controller, bool ehNumero = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: ehNumero ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFF6B00)),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color(0xFF242424),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}