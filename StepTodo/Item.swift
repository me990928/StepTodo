//
//  Item.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import Foundation
import SwiftData

struct stepDetail: Codable,Hashable {
    var id: UUID
    var title: String
    var sub: String
    var flag: Bool
}

@Model
final class Item {
    var id: String
    var timestamp: Date
    var title: String
    var sub: String
    var step: [stepDetail]
    
    init(id: String, timestamp: Date, title: String, sub: String, step: [stepDetail]) {
        self.id = UUID().uuidString
        self.timestamp = timestamp
        self.title = title
        self.sub = sub
        self.step = step
    }
}
