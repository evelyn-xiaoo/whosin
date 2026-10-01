//
//  ActivityCard.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 2/23/26.
//

import SwiftUI

struct ActivityCard: View {
    let title: String
    let emoji: String
    let location: String
    let cost: String
    let peopleCount: String
    let date: String
    let activityType: String
    let note: String
    let userName: String
    let userHandle: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Main content area
            VStack(alignment: .center, spacing: 20) {
                // Title with emoji
                HStack(alignment: .bottom ,spacing: 10) {
                    Text(emoji)
                        .font(.system(size: 30))
                    
                    Text(title)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.black)
                        
                }
                
                // Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 5)
                
                // Location
                HStack(spacing: 12) {
                    Image(systemName: "mappin")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                    Text(location)
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                }
                
                // Cost and People Count
                HStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.gray)
                        Text(cost)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 175, alignment: .leading)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 25))
                            .foregroundStyle(.gray)
                        Text(peopleCount)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 175, alignment: .leading)
                }
                
                // Date and Type
                HStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.system(size: 28))
                            .foregroundStyle(.gray)
                        Text(date)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 175, alignment: .leading)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "tag")
                            .font(.system(size: 28))
                            .foregroundStyle(.gray)
                        Text(activityType)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 175, alignment: .leading)

                }
                
                // Note section
                if !note.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Note:")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.gray)
                        
                        Text(note)
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            )
                    }
                }
            }
            .padding(10)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            
            // User section at bottom
            HStack(spacing: 15) {
                HStack(spacing: 10) {
                    // Profile image placeholder
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(userName)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("@\(userHandle)")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Action for interested button
                }) {
                    Text("Interested!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Capsule())
                }
            }
            .padding(20)
            .background(Color("Main"))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.4), lineWidth: 3)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
        .padding()
    }
}

#Preview {
    ActivityCard(
        title: "Drive to Boston",
        emoji: "🚗",
        location: "between Philly & Bos | Boston",
        cost: "free",
        peopleCount: "1-3 people",
        date: "Jan 24-Jan 31",
        activityType: "travel",
        note: "driving to boston from philly, i can pick u up otw :)",
        userName: "Evelyn Xiao",
        userHandle: "evelynxiao"
    )
}
