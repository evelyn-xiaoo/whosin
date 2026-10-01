//
//  WhenSection.swift
//  WhosIn
//
//  Created by Evelyn Xiao on 1/27/26.
//

import SwiftUI

struct WhenSection: View {
    @Binding var selectedDate: WhenOption
    @Binding var showSpecificDatePicker: Bool
    @Binding var specificDate: Date
    @Binding var isDateRange: Bool
    @Binding var endDate: Date
    @Binding var includeTime: Bool
    @Binding var startTime: Date
    @Binding var endTime: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("When?")
                .font(.headline)
                .foregroundStyle(.white)
            
            whenOptionsButtons
            
            if selectedDate == .specific && showSpecificDatePicker {
                datePickerContent
            }
            
            if selectedDate == .specific && !showSpecificDatePicker {
                dateSummaryButton
            }
        }
    }
    
    private var whenOptionsButtons: some View {
        HStack(spacing: 10) {
            ForEach(WhenOption.allCases, id: \.self) { option in
                Button(action: {
                    handleWhenOptionTap(option)
                }) {
                    OptionButton(
                        text: option.rawValue,
                        isSelected: selectedDate == option
                    )
                }
            }
        }
    }
    
    private func handleWhenOptionTap(_ option: WhenOption) {
        if option == .specific {
            withAnimation {
                if selectedDate == .specific {
                    showSpecificDatePicker.toggle()
                } else {
                    selectedDate = .specific
                    showSpecificDatePicker = true
                }
            }
        } else {
            selectedDate = option
            showSpecificDatePicker = false
        }
    }
    
    private var datePickerContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Toggle between single date and date range
            Toggle(isOn: $isDateRange) {
                Text("Date range")
                    .foregroundStyle(.white)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onChange(of: isDateRange) { oldValue, newValue in
                // Reset time toggle when switching to range
                if newValue {
                    includeTime = false
                }
            }
            
            if isDateRange {
                // Date range pickers
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Start Date")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        DatePicker("",
                                  selection: $specificDate,
                                  displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("End Date")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        DatePicker("",
                                  selection: $endDate,
                                  in: specificDate...,
                                  displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            } else {
                // Single date picker
                DatePicker("Select Date",
                          selection: $specificDate,
                          displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Time toggle only available for single dates
                Toggle(isOn: $includeTime) {
                    Text("Include time range")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                if includeTime {
                    timeRangePickers
                }
            }
            
            // Done button
            Button(action: {
                withAnimation {
                    showSpecificDatePicker = false
                }
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .transition(.opacity.combined(with: .scale))
    }
    
    private var timeRangePickers: some View {
        VStack(spacing: 12) {
            DatePicker("Start Time",
                      selection: $startTime,
                      displayedComponents: .hourAndMinute)
                .padding()
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            DatePicker("End Time",
                      selection: $endTime,
                      displayedComponents: .hourAndMinute)
                .padding()
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var dateSummaryButton: some View {
        Button(action: {
            withAnimation {
                showSpecificDatePicker = true
            }
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Selected:")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                    Text(formattedDateString())
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                Spacer()
                Image(systemName: "pencil")
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .transition(.opacity)
    }
    
    private func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if isDateRange {
            return "\(dateFormatter.string(from: specificDate)) - \(dateFormatter.string(from: endDate))"
        }
        
        var result = dateFormatter.string(from: specificDate)
        
        if includeTime {
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            result += " from \(timeFormatter.string(from: startTime)) to \(timeFormatter.string(from: endTime))"
        }
        
        return result
    }
}
