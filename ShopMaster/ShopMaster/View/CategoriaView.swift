//
//  CategoriaView.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import SwiftUI

struct CategoriaView: View {
    
    @EnvironmentObject var viewModel: LojaViewModel
    let indiceCategoria: Int
    
    @State private var mostrarAlerta = false
    @State private var produtoAdicionado = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categorias[indiceCategoria].produtos) { produto in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(produto.nome)
                                .font(.headline)
                            
                            Text("R$ \(produto.preco, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.adicionarProduto(produto: produto)
                            produtoAdicionado = produto.nome
                            mostrarAlerta = true
                        } label: {
                            Text("Adicionar")
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle(viewModel.categorias[indiceCategoria].nome)
            .navigationBarTitleDisplayMode(.inline)
            .alert("Produto adicionado", isPresented: $mostrarAlerta) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("\(produtoAdicionado) foi adicionado no carrinho.")
            }
        }
    }
}

#Preview {
    CategoriaView(indiceCategoria: 0)
        .environmentObject(LojaViewModel())
}
