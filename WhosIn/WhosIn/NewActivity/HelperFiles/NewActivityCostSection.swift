//
//  CostSection.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import SwiftUI

struct CostSection: View {
    @Binding var selectedCost: CostOption
    @Binding var customCost: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What is the relative cost?")
                .font(.headline)
                .foregroundStyle(.white)
            
            HStack(spacing: 12) {
                ForEach(CostOption.allCases, id: \.self) { option in
                    Button(action: {
                        selectedCost = option
                    }) {
                        OptionButton(
                            text: option.rawValue,
                            isSelected: selectedCost == option,
                            horizontalPadding: 16
                        )
                    }
                }
            }
            
            if selectedCost == .custom {
                CustomCostField(customCost: $customCost)
            }
        }
    }
}

struct CustomCostField: View {
    @Binding var customCost: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Text("$")
                .foregroundStyle(isFocused ? .black : .white)
                .padding(.leading, 8)
            TextField("0.00", text: $customCost)
                .focused($isFocused)
                .foregroundStyle(isFocused ? .black : .white)
                .keyboardType(.decimalPad)
                .onChange(of: customCost) { oldValue, newValue in
                    formatCustomCost(newValue)
                }
                .padding(.trailing, 8)
        }
        .frame(height: 36)
        .background(isFocused ? Color.white : Color("Main"))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.white, lineWidth: 1)
        )
    }
    
    private func formatCustomCost(_ newValue: String) {
        customCost = newValue.replacingOccurrences(of: "$", with: "")
        let filtered = customCost.filter { $0.isNumber || $0 == "." }
        let components = filtered.components(separatedBy: ".")
        
        if components.count > 2 {
            customCost = components[0] + "." + components[1]
        } else {
            customCost = filtered
        }
        
        if let decimalIndex = customCost.firstIndex(of: ".") {
            let afterDecimal = customCost[customCost.index(after: decimalIndex)...]
            if afterDecimal.count > 2 {
                let endIndex = customCost.index(decimalIndex, offsetBy: 3)
                customCost = String(customCost[..<endIndex])
            }
        }
    }
}
