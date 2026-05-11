//
//  ItemCarrinho.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import Foundation

struct ItemCarrinho: Identifiable {
    let id = UUID()
    let produto: Produto
    var quantidade: Int
}
