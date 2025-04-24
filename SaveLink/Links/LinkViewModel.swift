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
    
    func createNewLink(fromURL url: String){
        linkRepository.createNewLink(withURL: url, completionBlock: { [weak self] result in
            switch result {
            case .success(let link):
                print(" new link created: \(link.title)")
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        })
    }
    
    func updateIsFavorited(link:LinkModel){
        let updateLink = LinkModel(id: link.id,
                                   url: link.url,
                                   title: link.title,
                                   isFavorite: link.isFavorite ? false : true,
                                   isCompleted: link.isCompleted)
        linkRepository.update(link: updateLink)
    }
    
    func updateIsCompleted(link:LinkModel){
        let updateLink = LinkModel(id: link.id,
                                   url: link.url,
                                   title: link.title,
                                   isFavorite: link.isFavorite,
                                   isCompleted: link.isCompleted ? false : true)
        linkRepository.update(link: updateLink)
    }
    
    func delete(link:LinkModel){
        linkRepository.delete(link: link)
    }
}
