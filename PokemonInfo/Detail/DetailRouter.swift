//
//  DetailRouter.swift
//  PokemonInfo
//
//  Created by Vyacheslav on 11.10.2023
//

protocol DetailRouterProtocol {
    
}

class DetailRouter {
    
    // MARK: Public Properties
    
    weak var viewController: DetailViewProtocol?
    
}

// MARK: - DetailRouterProtocol

extension DetailRouter: DetailRouterProtocol {
    
}