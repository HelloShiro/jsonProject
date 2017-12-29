//
//  CountryData.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/23.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

class CountryCategory: NSObject {
    
}

class Country {
    var id: Int = 0
    var name: String = ""
    var url: String = ""
    var memo: String = ""
    
}

class Prefecture {
    var country: Country?
    var image: String = ""
    var hiragana: String = ""
    var prefectureName: String?
}

extension PageOne {
    func setupData() {
        
    }
}
