//
//  Item.swift
//  QRLists
//
//  Created by Jorge Collins Gómez on 29/06/22.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
