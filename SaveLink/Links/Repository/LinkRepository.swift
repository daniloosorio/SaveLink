//
//  LinkRepository.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import Foundation

final class LinkRepository {
    private let linkDatasource: LinkDatasource
    
    init(linkDatasource: LinkDatasource = LinkDatasource()) {
        self.linkDatasource = linkDatasource
    }
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        linkDatasource.getAllLinks(completionBlock: completionBlock)
    }
}
