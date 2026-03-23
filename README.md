# 🏆 E-commerci: Vitrine de Camisas streetwear

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

Este projeto consiste em uma plataforma de e-commerce simplificada, desenvolvida como projeto pessoal e universitário. O sistema funciona como uma vitrine digital para camisas streetwear, permitindo a visualização do catálogo e a solicitação de pedidos via integração com WhatsApp.

## 📋 Estudo de Caso
O projeto nasceu da necessidade de automatizar a exposição de estoque e o fluxo de pedidos de uma loja de roupas streetwear que operava de forma manual. 

**Principais objetivos:**
* Centralizar a visualização de produtos através de uma vitrine digital.
* Facilitar a gestão de estoque por parte do administrador.
* Profissionalizar o atendimento ao cliente e o processo de validação.

## 🚀 Tecnologias Utilizadas
* **Mobile/Web:** Flutter (Foco em responsividade mobile-first).
* **Backend:** Java com Spring Boot.
* **Banco de Dados:** PostgreSQL.
* **Design:** Figma.

## ⚙️ Funcionalidades (MVP)
* **Vitrine Digital:** Listagem de produtos em grade responsiva com 2 cards por linha no mobile.
* **Filtros Avançados:** Busca otimizada por marca e tamanho.
* **Fluxo de Venda:** Redirecionamento automático para fechamento manual no WhatsApp.
* **Painel Administrativo:** Interface restrita para cadastro de produtos, controle de estoque e visualização de solicitações.

## 🗄️ Modelagem de Dados
A estrutura do banco de dados foi projetada para garantir a persistência e a futura geração de relatórios de vendas:

| Tabela | Campos Principais | Descrição |
| :--- | :--- | :--- |
| **Produtos** | ID, Nome, Marca, Preço Base, URL_Imagem | Cadastro principal das camisas. |
| **Estoque** | ID, Produto_ID, Tamanho, Quantidade | Controle de disponibilidade por grade. |
| **Pedidos** | ID, id_Cliente, Data, Valor_Total | Registro das intenções de compra. |
| **Itens_Pedido**| ID_Pedido, ID_Produto, Quantidade | Detalhamento dos produtos solicitados. |
| **Cliente** | ID, Nome, Email, Numero_whats | Dados cadastrais para contato. |

## 📁 Estrutura do Repositório
* `/backend`: API desenvolvida em Java Spring Boot.
* `/frontend`: Aplicação client-side em Flutter.
* `/docs`: Documentação de requisitos, diagramas e protótipos.

## 🎨 Protótipo
O design da interface foi validado via Figma, focando na experiência do usuário em dispositivos móveis.
> [Link para o protótipo no Figma]
