//
//  LinkRepository.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import Foundation

final class LinkRepository {
    private let linkDatasource: LinkDatasource
    private let metadataDatasource: MetadataDatasource
    
    init(linkDatasource: LinkDatasource = LinkDatasource(),
         metadataDatasource:MetadataDatasource = MetadataDatasource()) {
        
        self.linkDatasource = linkDatasource
        self.metadataDatasource = metadataDatasource
    }
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        linkDatasource.getAllLinks(completionBlock: completionBlock)
    }
    
    func createNewLink(withURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void){
        //metadataDatasource.getMetadata(fromURL: url, completionBlock: completionBlock)
        metadataDatasource.getMetadata(fromURL: url, completionBlock: { [weak self] result in
            switch result {
            case .success(let LinkModel):
                self?.linkDatasource.createNew(link: LinkModel, completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
            
        })
    }
    
    func update(link: LinkModel){
        linkDatasource.updateLink(link: link)
    }
    
    func delete(link: LinkModel){
        linkDatasource.delete(link: link)
    }
}
