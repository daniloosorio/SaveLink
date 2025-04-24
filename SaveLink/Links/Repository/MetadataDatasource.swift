//
//  MetadataDatasource.swift
//  SaveLink
//
//  Created by Danilo Osorio on 23/04/25.
//

import Foundation
import LinkPresentation

enum CustomMetadataError:Error {
    case badURL
}

final class MetadataDatasource {
    private var metadataProvider : LPMetadataProvider?
    
    func getMetadata(fromURL url: String, completionBlock: @escaping (Result<LinkModel,Error>)->Void){
        guard let url = URL(string: url) else {
            completionBlock(.failure(CustomMetadataError.badURL))
            return
        }
        metadataProvider = LPMetadataProvider()
        metadataProvider?.startFetchingMetadata(for: url,completionHandler: {metadata, error in
            if let error = error {
                print("Error getting metadata \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let linkModel = LinkModel(url: url.absoluteString,
                                      title: metadata?.title ?? "No Title",
                                      isFavorite:false,
                                      isCompleted:false )
            completionBlock(.success(linkModel))
            
        })
        
    }
}
