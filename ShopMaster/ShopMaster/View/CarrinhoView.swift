//
//  CarrinhoView.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import SwiftUI

struct CarrinhoView: View {
    
    @EnvironmentObject var viewModel: LojaViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.carrinho.isEmpty {
                    Spacer()
                    
                    Text("Carrinho vazio")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.carrinho) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.produto.nome)
                                        .font(.headline)
                                    
                                    Text("Quantidade: \(item.quantidade)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("R$ \(item.produto.preco * Double(item.quantidade), specifier: "%.2f")")
                                    .font(.subheadline)
                                
                                Button {
                                    viewModel.removerProduto(item: item)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("R$ \(viewModel.total, specifier: "%.2f")")
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .navigationTitle("Carrinho")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CarrinhoView()
        .environmentObject(LojaViewModel())
}
