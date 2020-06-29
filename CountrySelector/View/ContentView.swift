//
//  ContentView.swift
//  CountrySelector
//
//  Created by Ari Supriatna on 26/06/20.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedCountry", store: UserDefaults(suiteName: "com.arisupriatna.CountrySelector"))
    var selectedCountry: Data = Data()
    
    init() {
        guard let _ = try? JSONDecoder().decode(Country.self, from: selectedCountry) else {
            storeData(with: countries[0])
            return
        }
    }
    
    private func selectCountry(_ country: Country) {
        print(country)
        storeData(with: country)
    }
    
    private func storeData(with country: Country) {
        guard let encodedData = try? JSONEncoder().encode(country) else {
            return
        }
        
        selectedCountry = encodedData
    }
    
    var body: some View {
        HStack {
            ForEach(countries) { country in
                CountryView(country: country)
                    .onTapGesture {
                        self.selectCountry(country)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
