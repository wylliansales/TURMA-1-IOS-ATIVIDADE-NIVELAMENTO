//
//  Produto.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import Foundation

struct Produto: Identifiable, Hashable {
    let id = UUID()
    let nome: String
    let preco: Double
}
