//
//  Parks.swift
//  USParksExplorer
//
//  Created by Devin Ercolano on 12/31/22.
//

import Foundation
import SwiftUI

struct Parks: Codable {
    var total: String
    var data: [Park]
}

struct Park: Codable, Identifiable {
    var id: String
    var fullName: String
    var description: String
    var latLong: String
    let images: [Images]
}

struct Images: Codable, Identifiable {
    let url: String?
    let id: String?
}
