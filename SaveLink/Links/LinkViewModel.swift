//
//  LinkViewmodel.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import Foundation

@Observable
final class LinkViewModel {
    var links: [LinkModel] = []
    var messageError: String?
    private let linkRepository: LinkRepository
    
    init (linkRepository: LinkRepository = LinkRepository()) {
        self.linkRepository = linkRepository
    }
    
    func getAllLinks() {
        linkRepository.getAllLinks { [weak self] result in
            switch result {
            case .success(let linksModels):
                self?.links = linksModels
                
            case.failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}
