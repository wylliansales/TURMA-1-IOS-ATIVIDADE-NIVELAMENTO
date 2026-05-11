//
//  ContentView.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CategoriaView(indiceCategoria: 1)
                .tabItem {
                    Label("Roupas", systemImage: "tshirt")
                }
            CategoriaView(indiceCategoria: 2)
                .tabItem {
                    Label("Alimentos", systemImage: "cart")
                }
            CategoriaView(indiceCategoria: 0)
                .tabItem {
                    Label("Eletrônicos", systemImage: "iphone")
                }
            CarrinhoView()
                .tabItem {
                    Label("Carrinho", systemImage: "cart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LojaViewModel())
}
