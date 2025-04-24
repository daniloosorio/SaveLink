//
//  LinkView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import SwiftUI

struct LinkView: View {
    @State var linkViewModel: LinkViewModel
    @State var text: String = ""
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay(content: {RoundedRectangle(cornerRadius: 20)
                        .stroke(.green,lineWidth: 2)
                })
                .padding(.horizontal,12)
                .cornerRadius(3)
            Button(action: {
                linkViewModel.createNewLink(fromURL: text)
            },label: {
                Label("Crear Link", systemImage: "link")
            })
            .tint(.green)
            .controlSize(.regular)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            
            if(linkViewModel.messageError != nil){
                Text(linkViewModel.messageError!).bold().foregroundColor(.red)
            }
            List {
                ForEach(linkViewModel.links){links in
                    VStack{
                        Text(links.title)
                            .bold()
                            .lineLimit(4)
                            .padding(.bottom,8)
                        Text(links.url)
                            .foregroundColor(.gray)
                            .font(.caption)
                        HStack {
                            Spacer()
                            if links.isCompleted {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width: 10,height: 10)
                            }
                            if links.isFavorite {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundColor(.yellow)
                                    .frame(width: 10,height: 10)
                            }
                        }
                    }.swipeActions(edge: .trailing, content: {
                        Button(action:{
                            linkViewModel.updateIsFavorited(link: links)
                        },label:{
                            Label("Favorite", systemImage: "star.fill")
                        })
                        .tint(.yellow)
                        
                        Button(action:{
                            linkViewModel.updateIsCompleted(link: links)
                        },label:{
                            Label("Completado", systemImage: "checkmark.circle.fill")
                        })
                        .tint(.blue)
                    })
                    .swipeActions(edge: .leading, content: {
                        Button(action:{
                            linkViewModel.delete(link: links)
                        },label: {
                            Label("Borrar",systemImage: "trash.fill")
                        })
                        .tint(.red)
                    })
                }
            }.task {
                linkViewModel.getAllLinks()
            }
        }
    }
}

#Preview {
    LinkView(linkViewModel: LinkViewModel())
}
