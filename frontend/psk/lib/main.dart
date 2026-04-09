import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PSKApp());
}

// 1. MODELO DE DADOS DO CARRINHO
class ItemCarrinho {
  final String nome;
  final double preco;
  final String caminhoImagem;
  int quantidade;

  ItemCarrinho({
    required this.nome,
    required this.preco,
    required this.caminhoImagem,
    this.quantidade = 1,
  });
}

// Lista global simples para armazenar os itens do carrinho no nosso MVP
List<ItemCarrinho> carrinhoGlobal = [];

class PSKApp extends StatelessWidget {
  const PSKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSK Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF333333),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const VitrineScreen(),
    );
  }
}

// 2. TELA DA VITRINE (Agora é StatefulWidget para atualizar o ícone do carrinho)
class VitrineScreen extends StatefulWidget {
  const VitrineScreen({super.key});

  @override
  State<VitrineScreen> createState() => _VitrineScreenState();
}

class _VitrineScreenState extends State<VitrineScreen> {
  void adicionarAoCarrinho(String nome, double preco, String caminhoImagem) {
    setState(() {
      // Verifica se o item já existe no carrinho
      var itemExistente = carrinhoGlobal
          .where((item) => item.nome == nome)
          .firstOrNull;
      if (itemExistente != null) {
        itemExistente.quantidade++;
      } else {
        carrinhoGlobal.add(
          ItemCarrinho(nome: nome, preco: preco, caminhoImagem: caminhoImagem),
        );
      }
    });

    // Mostra um aviso rápido na tela
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$nome adicionado ao carrinho!'),
        backgroundColor: const Color(0xFFFF6B00),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PSK',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          // ÍCONE DO CARRINHO COM BADGE (Contador)
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarrinhoScreen(),
                    ),
                  ).then(
                    (_) => setState(() {}),
                  ); // Atualiza a vitrine ao voltar do carrinho
                },
              ),
              if (carrinhoGlobal.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B00),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${carrinhoGlobal.length}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lançamentos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int numeroDeColunas = constraints.maxWidth >= 900
                      ? 4
                      : (constraints.maxWidth >= 600 ? 3 : 2);
                  double proporcao = constraints.maxWidth >= 900 ? 0.65 : 0.55;

                  return GridView.count(
                    crossAxisCount: numeroDeColunas,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: proporcao,
                    children: [
                      _construirCardProduto(
                        "Camiseta Oversized Preta",
                        149.90,
                        "PSKSTORY/camisa1.jpeg",
                        "URBAN",
                      ),
                      _construirCardProduto(
                        "Tee Urban Style",
                        129.90,
                        "PSKSTORY/camisa2.jpeg",
                        "URBAN",
                      ),
                      _construirCardProduto(
                        "Camiseta Básica Branca",
                        99.90,
                        "PSKSTORY/camisa3.jpeg",
                        "URBAN",
                      ),
                      _construirCardProduto(
                        "Tee Street Vibes",
                        139.90,
                        "PSKSTORY/camisa4.jpeg",
                        "URBAN",
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirCardProduto(
    String nome,
    double preco,
    String caminhoImagem,
    String tag,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    caminhoImagem,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B00),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B00),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () =>
                        adicionarAoCarrinho(nome, preco, caminhoImagem),
                    child: const Text(
                      'ADICIONAR',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. TELA DO CARRINHO (Baseada no seu Design do Figma)
class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  double get valorTotal {
    return carrinhoGlobal.fold(
      0,
      (total, item) => total + (item.preco * item.quantidade),
    );
  }

  void finalizarPedido() async {
    if (_nomeController.text.isEmpty || _telefoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha nome e telefone!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String numeroLoja = "5511999999999"; // Coloque o número real aqui

    // Monta o resumo dos itens
    String resumoItens = "";
    for (var item in carrinhoGlobal) {
      resumoItens +=
          "▪ ${item.quantidade}x ${item.nome} (R\$ ${item.preco.toStringAsFixed(2)})\n";
    }

    final String mensagem =
        '''
🛒 *NOVO PEDIDO PSK* 🛒

*Dados do Cliente:*
👤 Nome: ${_nomeController.text}
📧 Email: ${_emailController.text.isNotEmpty ? _emailController.text : 'Não informado'}
📱 Tel: ${_telefoneController.text}

*Itens do Pedido:*
$resumoItens
💰 *TOTAL: R\$ ${valorTotal.toStringAsFixed(2)}*

Como podemos prosseguir com o pagamento?
''';

    final String url =
        "https://wa.me/$numeroLoja?text=${Uri.encodeComponent(mensagem)}";
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      // Opcional: Limpar o carrinho após enviar
      // setState(() { carrinhoGlobal.clear(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CARRINHO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: carrinhoGlobal.isEmpty
          ? const Center(
              child: Text(
                'Seu carrinho está vazio.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ), // Limita a largura no PC para ficar bonito
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LISTA DE ITENS
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: carrinhoGlobal.length,
                        itemBuilder: (context, index) {
                          final item = carrinhoGlobal[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF242424),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item.caminhoImagem,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.nome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                        style: const TextStyle(
                                          color: Color(0xFFFF6B00),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (item.quantidade > 1) {
                                                  item.quantidade--;
                                                } else {
                                                  carrinhoGlobal.removeAt(
                                                    index,
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            '${item.quantidade}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                item.quantidade++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      carrinhoGlobal.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // TOTAL
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF242424),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R\$ ${valorTotal.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF6B00),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // FORMULÁRIO DE DADOS
                      const Text(
                        'DADOS PARA ENTREGA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          hintText: 'Seu nome completo',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'seu@email.com',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _telefoneController,
                        decoration: const InputDecoration(
                          hintText: '(11) 99999-9999',
                        ),
                      ),
                      const SizedBox(height: 24),

                      // BOTÃO FINALIZAR
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B00),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.chat),
                          label: const Text(
                            'FINALIZAR NO WHATSAPP',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: finalizarPedido,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
