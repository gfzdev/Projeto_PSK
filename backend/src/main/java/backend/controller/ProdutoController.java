package backend.controller;

import backend.model.Produto;
import backend.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/produtos")
@CrossOrigin(origins = "*") // Permite que o teu Flutter converse com a API sem bloqueios de segurança
public class ProdutoController {

    @Autowired
    private ProdutoRepository repository;

    // Método para LISTAR todos os produtos (O que o Flutter vai chamar na Vitrine)
    @GetMapping
    public List<Produto> listarTodos() {
        return repository.findAll();
    }

    // Método para CRIAR um novo produto (Útil para adicionares camisas ao banco de dados)
    @PostMapping
    public Produto criarProduto(@RequestBody Produto produto) {
        return repository.save(produto);
    }
}