//
//  WhereSection.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import SwiftUI

struct WhereSection: View {
    @Binding var selectedWhere: WhereOption
    @Binding var specificPlace: String
    @Binding var specificCity: String
    
    @FocusState private var isPlaceFocused: Bool
    @FocusState private var isCityFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Where?")
                .font(.headline)
                .foregroundStyle(.white)
            
            HStack(spacing: 8) {
                ForEach(WhereOption.allCases, id: \.self) { option in
                    Button(action: {
                        selectedWhere = option
                    }) {
                        OptionButton(
                            text: option.rawValue,
                            isSelected: selectedWhere == option,
                            horizontalPadding: 5
                        )
                    }
                }
            }
            
            if selectedWhere == .specific {
                VStack(spacing: 12) {
                    TextField("Place name or address", text: $specificPlace)
                        .focused($isPlaceFocused)
                        .foregroundStyle(isPlaceFocused ? .black : .white)
                        .padding(8)
                        .background(isPlaceFocused ? Color.white : Color("Main"))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    TextField("City", text: $specificCity)
                        .focused($isCityFocused)
                        .foregroundStyle(isCityFocused ? .black : .white)
                        .padding(8)
                        .background(isCityFocused ? Color.white : Color("Main"))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
            }
        }
    }
}
