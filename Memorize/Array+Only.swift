//
//  Array+Only.swift
//  Memorize
//
//  Created by Gabriel on 26/03/23.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
