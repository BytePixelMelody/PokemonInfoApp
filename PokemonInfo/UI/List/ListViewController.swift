//
//  ViewController.swift
//  PokemonInfo
//
//  Created by Vyacheslav on 10.10.2023.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func showCount(count: String)
}

final class ListViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet var countLabel: UILabel!
    
    // MARK: Public Properties
    
    var presenter: ListPresenterProtocol?
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await presenter?.viewDidLoaded()
        }
    }
    
    // MARK: IBAction
    
    @IBAction func didTapInfoButton(_ sender: UIButton) {
        presenter?.didTapDetails()
    }
     
}

// MARK: - ListViewProtocol

extension ListViewController: ListViewProtocol {
    
    // MARK: Public Methods
    
    func showCount(count: String) {
        countLabel.text = count
    }

}