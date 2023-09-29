//
//  ProgressBar.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/29.
//

import SwiftUI
import SwiftData

struct ProgressBar: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var stepIndex: Int
    @State var todoVal: Int = 0
    @State var stepTotal: Int = 0
    @State var res: CGFloat = 0
    @State var display: String = "0"
    
    @State var GeoWid: CGFloat = 0
    
    var todoGrafViewModel = TodoGrafViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            VStack{
                Rectangle().fill(.gray).frame(width: proxy.size.width, height: 10).cornerRadius(4)
                    .overlay(alignment: .leading) {
                        Rectangle().fill(.green).frame(width: self.res, height: 10)
                    }.cornerRadius(4)
            }.onAppear(){
                GeoWid = proxy.size.width
                stepTotal = items[stepIndex].step.count
                todoVal = todoGrafViewModel.getTotalTrue(data: items[stepIndex].step)
                
                withAnimation{
                    self.res = CGFloat(Float(todoVal) / Float(stepTotal)) * GeoWid
                    if self.res > GeoWid {
                        res = GeoWid
                    }
                }
            }
        }
    }
}
