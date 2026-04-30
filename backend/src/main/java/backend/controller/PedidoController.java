package backend.controller;

import backend.model.Pedido;
import backend.repository.PedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/pedidos")
@CrossOrigin(origins = "*") // Para o Flutter conseguir aceder
public class PedidoController {

    @Autowired
    private PedidoRepository repository;

    @PostMapping
    public Pedido realizarPedido(@RequestBody Pedido pedido) {
        // Vincula cada item ao pedido principal antes de salvar
        if (pedido.getItens() != null) {
            pedido.getItens().forEach(item -> item.setPedido(pedido));
        }
        return repository.save(pedido);
    }
}