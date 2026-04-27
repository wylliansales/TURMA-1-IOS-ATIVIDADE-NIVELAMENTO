//
//  ContentView.swift
//  Jogos de Perguntas
//
//  Created by Sales, Wyllian Fonseca on 23/04/26.
//

import SwiftUI

struct AlternativaToggleView: View {
    let texto: String
    let index: Int
    @Binding var alternativaSelecionada: Int?

    var body: some View {
        Toggle(
            isOn: Binding(
                get: { alternativaSelecionada == index },
                set: { selecionado in
                    if selecionado {
                        alternativaSelecionada = index
                    }
                }
            )
        ) {
            Text(texto)
                .font(.body)
        }
        .toggleStyle(.switch)
    }
}

struct InicioView: View {
    
    @State var temas: [Tema]
    @Binding var temaSelecionado: Int?
    @State var selecionado: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Jogos de Perguntas")
                .font(.title)
            
            Text("Selecione o tema das Perguntas")
            
            Picker("", selection: $selecionado) {
                ForEach(temas.indices, id: \.self) { index in
                    Text(temas[index].nome)
                        .tag(Optional(index))
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            
            Button("Iniciar Jogo") {
                temaSelecionado = selecionado
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(.green)
            .foregroundStyle(.white)
        }
    }
}

struct ContentView: View {
    
    @State private var jogoData: JogoData?
    @State private var temaIndex: Int? = nil
    @State private var perguntaIndex = 0
    
    @State private var jogoFinalizado = false
    @State private var alternativaSelecionada: Int? = nil
    @State private var totalAcertos: Int = 0
    
    @State private var descricao: String = ""
    @State private var resultadoFinal: String = ""
    
    
    var body: some View {
        VStack(spacing: 24) {
            if temaIndex == nil {
                
                if let jogoData = jogoData {
                    
                    
                    InicioView(
                        temas: jogoData.temas,
                        temaSelecionado: $temaIndex
                    )
                } else {
                    ProgressView("Carregando dados...")
                }
                
                
            } else {
                if let jogoData = jogoData, !jogoFinalizado, temaIndex != nil {
                    
                    let tema = jogoData.temas[temaIndex ?? 0]
                    let pergunta = tema.perguntas[perguntaIndex]
                    
                    Text("Tema do jogo: \(tema.nome)")
                        .font(.title2)
                        .bold()
                    
                    Text(pergunta.tituloPergunta)
                        .font(.headline)
                    
                    ForEach(pergunta.altenativas.indices, id: \.self) { index in
                        AlternativaToggleView(
                            texto: pergunta.altenativas[index],
                            index: index,
                            alternativaSelecionada: $alternativaSelecionada
                        )
                    }
                    
                    Text(descricao)
                    
                    Spacer()
                    
                    Button(descricao == "" ? "Ver resposta" : "Proxima pergunta") {
                        
                        if descricao.isEmpty {
                            if let alternativaSelecionada = alternativaSelecionada {
                                if pergunta.respostaCorreta == alternativaSelecionada {
                                    descricao = "Parabéns, resposta correta!"
                                } else {
                                    descricao = "Resposta Errada, a resposta correta é: \(pergunta.altenativas[pergunta.respostaCorreta])"
                                }
                            }
                            
                        } else {
                            descricao = ""
                            avancarPergunta()
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.green)
                    .foregroundStyle(.white)
                    .disabled(alternativaSelecionada == nil)
                    
                } else if jogoFinalizado {
                    Text(resultadoFinal)
                        .font(.largeTitle)
                        .bold()
                    
                    Button("Jogar Novamente") {
                        temaIndex = nil
                        totalAcertos = 0
                        jogoFinalizado = false
                        perguntaIndex = 0
                        alternativaSelecionada = nil
                    }
                    
                } else {
                    ProgressView("Carregando dados...")
                }
                
            }
        }.padding()
            .onAppear {
                carregarJSON()
            }
    }
    
    private func avancarPergunta() {
        if let jogoData = jogoData,
           let temaIndex = temaIndex {
            
            let perguntas = jogoData.temas[temaIndex].perguntas;
            let totalPerguntas = perguntas.count
            
            if perguntas[perguntaIndex].respostaCorreta == alternativaSelecionada {
                totalAcertos += 1
            }
            
            alternativaSelecionada = nil
            
            if perguntaIndex + 1 < totalPerguntas {
                perguntaIndex += 1
            } else {
                resultadoFinal = "Jogo Finalizado! \(totalAcertos) Acertos e \(totalPerguntas - totalAcertos) erros"
                jogoFinalizado = true
                
            }
        }
    }
    
    private func carregarJSON() {
        guard let url = Bundle.main.url(forResource: "jogoData", withExtension: "json") else {
            print("Arquivo jogoData.json não encontrato")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            self.jogoData = try JSONDecoder().decode(JogoData.self, from: data)

        } catch {
            print("Erro ao carregar JSON:", error)
        }
    }
}

#Preview {
    ContentView()
}

struct JogoData: Codable {
    let temas: [Tema]
}

struct Tema: Codable {
    let nome: String
    let perguntas: [Pergunta]
}

struct Pergunta: Codable {
    let tituloPergunta: String
    let altenativas: [String]
    let respostaCorreta: Int
}
