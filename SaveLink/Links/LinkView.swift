//
//  LinkView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 22/04/25.
//

import SwiftUI

struct LinkView: View {
    @State var linkViewModel: LinkViewModel
    var body: some View {
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
                }
            }
        }.task {
            linkViewModel.getAllLinks()
        }
    }
}

#Preview {
    LinkView(linkViewModel: LinkViewModel())
}
