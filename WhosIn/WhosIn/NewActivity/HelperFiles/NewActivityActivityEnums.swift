//
//  ActivityEnums.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import Foundation

enum ActivityType: String, CaseIterable {
    case active = "Active"
    case casual = "Casual"
    case social = "Social"
    case travel = "Travel"
    case productive = "Productive"
    case virtual = "Virtual"
    
    var icon: String {
        switch self {
        case .active: return "figure.run"
        case .casual: return "sofa"
        case .social: return "person.3"
        case .travel: return "airplane"
        case .productive: return "checkmark.circle"
        case .virtual: return "phone"
        }
    }
}

enum CostOption: String, CaseIterable {
    case free = "Free"
    case low = "$"
    case medium = "$$"
    case high = "$$$"
    case custom = "#"
}

enum WhenOption: String, CaseIterable {
    case today = "today"
    case soon = "soon"
    case whenever = "whenever"
    case specific = "specific"
}

enum WhereOption: String, CaseIterable {
    case closeBy = "close by"
    case far = "far"
    case undecided = "undecided"
    case specific = "specific"
}
