//
//  TypeSection.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import SwiftUI

struct TypeSection: View {
    @Binding var selectedType: ActivityType
    @State private var showingExamples = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("What type of activity is this?")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Button(action: {
                    showingExamples = true
                }) {
                    Image(systemName: "info.circle")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }
            
            Menu {
                ForEach(ActivityType.allCases, id: \.self) { type in
                    Button(action: {
                        selectedType = type
                    }) {
                        Label(type.rawValue, systemImage: type.icon)
                    }
                }
            } label: {
                HStack {
                    Label(selectedType.rawValue, systemImage: selectedType.icon)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color("Main"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 1)
                )
            }
        }
        .alert("Examples", isPresented: $showingExamples) {
            Button("OK") {
                showingExamples = false
            }
        } message: {
            Text(activityExamplesText)
        }
    }
    
    private var activityExamplesText: String {
        """
        🏃🏻‍♀️ Active:
            gym, hiking, fitness class
        
        🧘🏻‍♀️ Casual (home-based): 
            doomscroll, yap sesh, listen to music 
        
        🗣️ Social (public spaces): 
            dinner, movies, shopping 
        
        ✈️ Travel: 
            beach trip, weekend trip, vacations
        
        📖 Productive: 
            studying, errands, appointments
        
        💻 Virtual: 
            facetime, phone call, gaming
        """
    }
}
