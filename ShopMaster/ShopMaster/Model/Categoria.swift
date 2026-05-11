//
//  Categoria.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import Foundation

struct Categoria: Identifiable {
    let id = UUID()
    let nome: String
    let produtos: [Produto]
}
