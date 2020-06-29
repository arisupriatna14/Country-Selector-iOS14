//
//  CountryView.swift
//  CountrySelector
//
//  Created by Ari Supriatna on 26/06/20.
//

import SwiftUI

struct CountryView: View {
    var country: Country
    
    var body: some View {
        Text(country.flag)
            .font(.largeTitle)
            .background(Color.gray)
            .clipShape(Circle())
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: countries[0])
    }
}
