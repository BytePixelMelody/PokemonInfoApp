//
//  DetailPresenter.swift
//  PokemonInfo
//  
//  Created by Vyacheslav on 11.10.2023
//

import UIKit
import OSLog

protocol DetailPresenterProtocol: AnyObject {
    
    // view calls
    func viewDidLoaded()
    
    // interactor calls
    @MainActor func loadedPokemonDetails(pokemonDetails: PokemonDetails) async
    @MainActor func loadedPokemonImageData(imageData: Data) async
}

final class DetailPresenter {
    
    // MARK: Types
    
    enum Errors: LocalizedError {
        case noDataLoaded
        case noImageLoaded

        var errorDescription: String? {
            switch self {
            case .noDataLoaded:
                return "Data loading failed"
            case .noImageLoaded:
                return "Image loading failed"
            }
        }
    }
    
    // MARK: Public Properties
    
    weak var view: DetailViewProtocol?
    
    // MARK: Private Properties
    
    private let router: DetailRouterProtocol
    private let interactor: DetailInteractorProtocol
    private let networkMonitorService: NetworkMonitorServiceProtocol
    private let alertService: AlertServiceProtocol
    private let logger = Logger(subsystem: #file, category: "Error logger")
    
    // MARK: Initialisers

    init(
        router: DetailRouterProtocol,
        interactor: DetailInteractorProtocol,
        networkMonitorService: NetworkMonitorServiceProtocol,
        alertService: AlertServiceProtocol
    ) {
        self.router = router
        self.interactor = interactor
        self.networkMonitorService = networkMonitorService
        self.alertService = alertService
    }
    
}

// MARK: - DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
    
    // MARK: Public Methods
    // view calls

    func viewDidLoaded() {
        Task {
            do {
                // TODO: check internet here and throw
                try await interactor.getPokemonDetails()
            } catch {
                logger.error("\(error.localizedDescription, privacy: .public)")
                // TODO: catch errors here
            }
        }
    }
    
    // interactor calls

    @MainActor
    func loadedPokemonDetails(pokemonDetails: PokemonDetails) async {
        view?.showDetails(
            name: pokemonDetails.name,
            type: pokemonDetails.type,
            weightKg: pokemonDetails.weightKg,
            height: pokemonDetails.height
        )
    }
    
    @MainActor
    func loadedPokemonImageData(imageData: Data) async {
        let image = UIImage(data: imageData)
        view?.showDetailsImage(image: image)
    }
    
}
