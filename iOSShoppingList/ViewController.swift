//
//  ViewController.swift
//  Shopping List
//
//  Created by António Rocha on 05/11/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var allShoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Botão para lançar alerta para adicionar Shopping Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(askForItem))
        
        //Botão para limpar a lista
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartList))
        
        title = "Shopping List"
    }
    
    //Quantas linhas tem a tabela?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allShoppingItems.count
    }
    
    //Criar a linha da tabela e indicar o que lá aparece
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Shopping Item", for: indexPath)
        cell.textLabel?.text = allShoppingItems[indexPath.row]
        return cell
    }

    //Limpar  lista e dar reload à view
    @objc func restartList() {
        allShoppingItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    @objc func askForItem() {
        //Lançar alert a pedir Item.
        let ac = UIAlertController(title: "Enter a new Shopping Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        //Criar um botão dentro do Alert Controller para adicionar ao Array
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            if item != "" {
                self?.submit(item)
            } else {
                self?.showErrorMessage(errorTitle: "Text Field is Empty", errorMessage: "Fill the text box to add an item to the list.")
            }
        }
        //Adicionar a Action ao AC
        ac.addAction(submitAction)
        //Mostrar o AC
        present(ac, animated: true)
    }
    
    //Adicionar o item ao Array
    func submit(_ item: String) {
        //Adiciona na posição 0 do array
        allShoppingItems.insert(item.lowercased(), at: 0)

        //Insere a linha onde vai aparecer o item
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default)
//        {
//            [weak self] action in
//            self?.askForItem()
//        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
}

