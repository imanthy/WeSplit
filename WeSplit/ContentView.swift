//
//  ContentView.swift
//  WeSplit
//
//  Created by Anthy Chen on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var peopleCount: Double {
        Double(numberOfPeople + 2) // counting from 2
    }
    var tipSelection: Double {
        Double(tipPercentage)
    }
    var grandTotal: Double {
        checkAmount * (1 + tipSelection/100)
    }
    var totalPerPerson: Double {
        grandTotal / peopleCount
    }
    
//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.preferredFont(forTextStyle: .title2), .foregroundColor : UIColor(named: "TextColor_General")!]
//    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip (%)", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Tips:")
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Grand total:")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title2)
                } header: {
                    Text("Amount per person:")
                        .fontWeight(.black)
                }
            }
//            .scrollContentBackground(.hidden)
//            .background(Color("BackgroungColor"))
            .navigationTitle(
                Text("QuickSplit")
            )
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        .kerning(0.5)
        .foregroundColor(Color("TextColor_General"))
        .bold()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
