//
//  TodoGrafViewModel.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/29.
//

import Foundation

class TodoGrafViewModel{
    
    var total:Float = 0.0
    var all:Float = 0.0
    
    func getTotalScore(items: [Item])->Float{
        
        total = 0.0
        all = 0.0
        
        var res:Float = 0.0
        
        items.forEach { Item in
            Item.step.forEach { stepDetail in
                print(stepDetail)
                if stepDetail.flag {
                    total += 1.0
                }
                all += 1.0
            }
        }
        
        res = total / all
        
        return res
        
    }
    
    func getTotalTrue(data: [stepDetail])->Int{
        
        var count: Int = 0
        
        data.forEach { stepDetail in
            if stepDetail.flag {
                count += 1
            }
        }
        
        return count
    }
    
    func getPercentage(data: [stepDetail])->String{
        
        let count = self.getTotalTrue(data: data)
        
        let percent:Float = round(Float(count) / Float(data.count) * 100)
        
        return "\(String(percent))%"
    }
    
}
