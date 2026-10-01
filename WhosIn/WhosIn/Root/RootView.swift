//
//  RootView.swift
//      handles navigation and presentation
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import Foundation
import SwiftUI

struct RootView: View {
    enum Tab {
        case feed
        case newActivity
        case profile
    }
    
    @State private var selectedTab: Tab = .feed
    @State private var showingNewActivity = false

    var body: some View {
        TabView(selection: $selectedTab) {
            ViewOthersActivities()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
                .tag(Tab.feed)
            
            // Placeholder tab that triggers the sheet
            Color.clear
                .tabItem {
                    Label("New", systemImage: "plus.circle.fill")
                }
                .tag(Tab.newActivity)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(Tab.profile)
            
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == .newActivity {
                showingNewActivity = true
                // Delay resetting the tab so the sheet animation starts first
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    selectedTab = oldValue
                }
            }
        }
        .sheet(isPresented: $showingNewActivity) {
            NewActivity()
        }
    }
}

#Preview {
    RootView()
}
