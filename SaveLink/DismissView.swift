//
//  DismissView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Spacer()
            Button("Cerrar") {
                dismiss()
            }
            .tint(.primary)
            .padding(.trailing,12)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    DismissView()
}
