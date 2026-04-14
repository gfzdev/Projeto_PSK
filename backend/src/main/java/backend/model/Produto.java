package backend.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "produtos")
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private double preco;
    private String caminhoImagem;
    private String tag; // Ex: ESSENTIALS, URBAN

    // Construtor vazio (Obrigatório para o Spring Boot e base de dados)
    public Produto() {
    }

    // Construtor com os campos
    public Produto(String nome, double preco, String caminhoImagem, String tag) {
        this.nome = nome;
        this.preco = preco;
        this.caminhoImagem = caminhoImagem;
        this.tag = tag;
    }

    // Getters e Setters (Para permitir que o Flutter e a Base de Dados leiam/alterem as informações)
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public String getCaminhoImagem() {
        return caminhoImagem;
    }

    public void setCaminhoImagem(String caminhoImagem) {
        this.caminhoImagem = caminhoImagem;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
