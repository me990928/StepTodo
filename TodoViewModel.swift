//
//  TodoViewModel.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import Foundation
import SwiftUI

class TodoViewModel {
    
    // stepテキストを格納
    func setStepDetail(input: [String])->[stepDetail]{
        
        var data: [stepDetail] = []
        
        for item in input {
            data.append(stepDetail(id: UUID(), title: item, sub: "", flag: false))
        }
        
        data.removeFirst()
        
        print(data)
        
        return data
    }
}
