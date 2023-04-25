//
//  ContentView.swift
//  WeSplit
//
//  Created by CHIARELLO Berardino - ADECCO on 20/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    //A particular wrapper to handle keyboard state
    @FocusState private var amountIsFocused: Bool
    
    var currentCurrency : FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    let tipPercentages = [0, 10 , 15 , 20 , 25 , 30]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var amountPlusTip: Double {
        let tipSelection = Double(tipPercentage)
        return (checkAmount / 100 * tipSelection) + checkAmount
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: currentCurrency)
                    .keyboardType(.decimalPad)
                    //change the state of the variable if the Textfield is selected
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                    
                    Section{
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                
                Section {
                    Text(amountPlusTip, format: currentCurrency)
                        .foregroundColor(tipPercentage == 0 ? Color.red : Color.primary)
                } header: {
                    Text("Total plus tip")
                }
                
                 
                Section  {
                    Text(totalPerPerson, format: currentCurrency)
                        .foregroundColor(tipPercentage == 0 ? Color.red : Color.primary)
                } header: {
                    Text("Amount per person")
                        
                }
            }
            .navigationTitle("WeSplit")
            //Add a toolbar to the keyboard with a button that trigger amountIsFocused and hide the keyboard
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
