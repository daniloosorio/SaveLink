//
//  LinkDatasource.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import Foundation
import FirebaseFirestore


struct LinkModel: Decodable,Identifiable,Encodable {
    @DocumentID var id: String?
    let url: String
    let title: String
    let isFavorite: Bool
    let isCompleted: Bool
}

final class LinkDatasource {
    private let database = Firestore.firestore()
    private let colletion = "links"
    
    func getAllLinks(completionBlock:@escaping (Result<[LinkModel],Error>) -> Void){
        database.collection(colletion)
            .addSnapshotListener { query, error in
                if let error = error {
                    print("error getting all links \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({$0}) else {
                    completionBlock(.success([]))
                    return
                }
                let links = documents.map { try? $0.data(as: LinkModel.self)}
                    .compactMap({$0})
                completionBlock(.success(links))
            }
    }
    
    func createNew(link:LinkModel, completionBlock: @escaping (Result<LinkModel,Error>) -> Void){
        do {
            _ = try database.collection(colletion).addDocument(from: link)
            completionBlock(.success(link))
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    func updateLink(link:LinkModel){
        guard let documentId = link.id else { return }
        do {
            _ = try database.collection(colletion).document(documentId).setData(from: link)
        }catch {
            print("Error updating link in our databse")
        }
    }
    
    func delete(link:LinkModel){
        guard let documentId = link.id else { return }
        database.collection(colletion).document(documentId).delete()
    }
    
}
