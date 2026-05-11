//
//  LojaViewModel.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import Foundation
import Combine

class LojaViewModel: ObservableObject {
    
    // Dados mockados
        let categorias: [Categoria] = [
            Categoria(
                nome: "Eletrônicos",
                produtos: [
                    Produto(nome: "iPhone", preco: 4500),
                    Produto(nome: "Fone Bluetooth", preco: 300)
                ]
            ),
            Categoria(
                nome: "Roupas",
                produtos: [
                    Produto(nome: "Camiseta", preco: 80),
                    Produto(nome: "Calça Jeans", preco: 200)
                ]
            ),
            Categoria(
                nome: "Alimentos",
                produtos: [
                    Produto(nome: "Arroz", preco: 25),
                    Produto(nome: "Feijão", preco: 12)
                ]
            )
        ]

    @Published var carrinho: [ItemCarrinho] = []
    
    func adicionarProduto(produto: Produto) {
        if let index = carrinho.firstIndex(where: { $0.produto == produto}) {
            carrinho[index].quantidade += 1
        } else {
            carrinho.append(ItemCarrinho(produto: produto, quantidade: 1))
        }
    }
    
    func removerProduto(item: ItemCarrinho) {
        carrinho.removeAll { $0.id == item.id}
    }
    
    var total: Double {
        carrinho.reduce(0) { $0 + ($1.produto.preco * Double($1.quantidade)) }
    }
}
