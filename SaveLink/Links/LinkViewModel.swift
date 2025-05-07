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
    //${BUILD_DIR%Build/*}SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run -gsp ${PROJECT_DIR}/SaveLink/GoogleService-Info.plist;
    //$(DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARD/${TARGET_NAME}
    //${SRCROOT}/${BUILD_PRODUCTS_DIR}/${INFOPLIST_PATH}
    func createNewLink(fromURL url: String){
        let numbers = [0]
        let _ = numbers[1]
        Tracker.trackerCreateLinkEvent(url: url)
        linkRepository.createNewLink(withURL: url, completionBlock: { [weak self] result in
            switch result {
            case .success(let link):
                print(" new link created: \(link.title)")
                Tracker.trackerSaveLinkEvent()
            case .failure(let error):
                self?.messageError = error.localizedDescription
                Tracker.trackErrorSaveLinkEvent(error: error.localizedDescription)
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
