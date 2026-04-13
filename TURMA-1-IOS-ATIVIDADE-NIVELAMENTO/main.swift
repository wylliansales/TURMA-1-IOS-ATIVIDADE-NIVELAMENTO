//
//  main.swift
//  AtividadeNivelamento
//
//  Created by Sales, Wyllian Fonseca on 09/04/26.
//

import Foundation

protocol Entidade {
    var id: Int? { get }
    var nome: String { get }
    var idade: Int { get }
    var telefone: String { get }
    var email: String { get }
}

struct Contato: Entidade {
    private(set) var id: Int?
    private(set) var nome: String
    private(set) var idade: Int
    private(set) var telefone: String
    private(set) var email: String
    
    init(id: Int?, nome: String, idade: Int, telefone: String, email: String) {
        self.id = id
        self.nome = nome
        self.idade = idade
        self.telefone = telefone
        self.email = email
    }
}

protocol AcoesCrud {
    mutating func cadastrar(_ contato: Contato) throws
    func listar() -> [Contato]
    mutating func atualizar(id: Int, contato: Contato) throws
    mutating func remover(id: Int)
}

enum CrudErro: Error {
    case nomeDuplicado
    case contatoNaoEncontrato
}

struct ContatoService: AcoesCrud {
    private var contatos: [Contato] = []
    
    mutating func cadastrar(_ contato: Contato) throws {
        guard !contatos.contains (where: {
            $0.nome.caseInsensitiveCompare(contato.nome) == .orderedSame
        }) else {
            throw CrudErro.nomeDuplicado
        }
        
        let newContato = Contato(id: (contatos.last?.id ?? 0) + 1, nome: contato.nome, idade: contato.idade, telefone: contato.telefone, email: contato.email)
        contatos.append(newContato);
    }
    
    func listar() -> [Contato] {
        return contatos
    }
    
    mutating func atualizar(id: Int, contato: Contato) throws {
        guard let index = contatos.firstIndex(where: { $0.id == id }) else {
            throw CrudErro.contatoNaoEncontrato
        }
        let newContato = Contato(id: (contatos.last?.id ?? 0) + 1, nome: contato.nome, idade: contato.idade, telefone: contato.telefone, email: contato.email)
        
        contatos[index] = newContato
    }
    
    mutating func remover(id: Int) {
        contatos.removeAll {$0.id == id }
    }
}

var opcao: Int? = 0
var contatoService = ContatoService()
repeat {
    print("Qual ação deseja realizar?")
    print(" 1 - Cadastrar\n 2 - listar\n 3 - atualizar\n 4 - remover\n 5 - Sair")
    opcao = Int(readLine() ?? "0")
    
    switch opcao {
    case 1:
        guard let contato = lerContato() else {
           print("Contato digitado é inválido")
           continue
        }
        do {
            try contatoService.cadastrar(contato)
        } catch {
            print("Erro ao cadastro usuário:", error)
        }
        
    case 2:
        print("----------Meus contatos-----------")
        print(contatoService.listar())
        print("----------------------------------")
    case 3:
        print("Digite o id do contato a ser atualizado")
        guard let idx: Int = Int(readLine() ?? "0") else {
            print("Id Digitado é inválido")
            continue
        }
        guard let contato = lerContato() else {
           print("Contato digitado é inválido")
            continue
        }
        do {
            try contatoService.atualizar(id: idx, contato: contato)
        } catch {
            print("Erro ao ao atualizar contato:", error)
        }
        
    case 4:
        print("Digite o id do contato a ser excluido")
        guard let id: Int = Int(readLine() ?? "0") else {
            print("Id de contato inválido")
            continue
        }
        contatoService.remover(id: id)
    case 5:
        print("Saindo......")
        break
    default:
        print("Ação inválida")
    }
    
} while opcao != 5

// FUNÇÃO CRIADA PARA LER OS DADOS INFORMADOS
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
    
    print("Digite o telefone")
    guard let telefone: String = readLine() else {
        print("Idade digitada é inválida")
        return nil
    }
    
    print("Digite o e-mail")
    guard let email: String = readLine() else {
        print("Idade digitada é inválida")
        return nil
    }
    
    return Contato(id: nil, nome: nome, idade: idade, telefone: telefone, email: email)
}
