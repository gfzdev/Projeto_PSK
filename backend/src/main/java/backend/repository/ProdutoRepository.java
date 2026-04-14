package backend.repository;

import backend.model.Produto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProdutoRepository extends JpaRepository<Produto, Long> {
    
    // O Spring Boot já nos dá métodos gratuitos aqui dentro, como:
    // save() -> para guardar um produto
    // findAll() -> para listar todos os produtos
    // findById() -> para encontrar um produto específico
    // deleteById() -> para apagar um produto
    
}