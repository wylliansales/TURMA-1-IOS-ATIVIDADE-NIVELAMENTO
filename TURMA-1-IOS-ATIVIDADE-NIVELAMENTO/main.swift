//
//  main.swift
//  AtividadeNivelamento
//
//  Created by Sales, Wyllian Fonseca on 09/04/26.
//

import Foundation

struct Contato {
    private var nome: String
    private var idade: Int
    private var telefone: String
    private var email: String
    
    init(nome: String, idade: Int, telefone: String, email: String) {
        self.nome = nome
        self.idade = idade
        self.telefone = telefone
        self.email = email
    }
}

protocol ContatosCrud {
    mutating func cadastrar() -> Void
    func listar() -> Void
    func atualizar() -> Void
    func remover() -> Void
}

struct ContatoService: ContatosCrud {
    private var contatos: [Contato] = []
    
    mutating func cadastrar() {
        if let contato = lerContato() {
            contatos.append(contato)
        }
    }
    
    func listar(){
        print(contatos)
    }
    
    func atualizar() {
        <#code#>
    }
    
    func remover() {
        <#code#>
    }
    
    func lerContato() -> Contato? {
        print("Digite o nome")
        guard let nome: String = readLine() else {
            print("Nome de contato inválido")
            return nil
        }
        
        print("Digite a idade")
        guard let idade: Int = Int(readLine() ?? "") else {
            print("Idade digitada é inválida")
            return nil
        }
        
        print("Digite o e-mail")
        guard let email: String = readLine() else {
            print("Idade digitada é inválida")
            return nil
        }
        
        print("Digite o e-mail")
        guard let telefone: String = readLine() else {
            print("Idade digitada é inválida")
            return nil
        }
        
        guard let email: String = readLine() else {
            print("Idade digitada é inválida")
            return nil
        }
        
        return Contato(nome: nome, idade: idade, telefone: telefone, email: email)
    }
}

var opcao: Int? = 0
var contatoService: ContatoService()
repeat {
    print("----------Meus contatos-----------")
    print(contatoService.listar())
    print("----------------------------------")
    print("Qual ação deseja realizar?")
    print("1 - Cadastrar\n 2 - listar\n 3 - atualizar\n 4 - remover\n 5 - Sair")
    
    opcao = Int(readLine() ?? "0")
    
    switch opcao {
    case 1:
        contatoService.cadastrar()
    case 2:
        contatoService.listar()
    case 3:
        contatoService.atualizar()
    case 4:
        contatoService.remover()
    case 5:
    default:
        print("Ação inválida")
    }
    
} while opcao != 5





print("Olá, informe um nome.")
var nome: String? = readLine()

print("Bom dia \(nome ?? "Sem nome")")


