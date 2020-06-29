//
//  Country.swift
//  CountrySelector
//
//  Created by Ari Supriatna on 26/06/20.
//

import SwiftUI

struct Country: Codable, Identifiable {
    var id = UUID()
    let name: String
    let flag: String
    let continent: String
}

let countries = [
    Country(name: "Indonesia", flag: "🇲🇨", continent: "Asia"),
    Country(name: "USA", flag: "🇺🇸", continent: "North America"),
    Country(name: "United Kingdom", flag: "🇬🇧", continent: "Europe"),
    Country(name: "France", flag: "🇫🇷", continent: "Europe"),
    Country(name: "China", flag: "🇨🇳", continent: "Asia"),
    Country(name: "India", flag: "🇮🇳", continent: "Asia"),
    Country(name: "Australia", flag: "🇦🇺", continent: "Australia")
]
