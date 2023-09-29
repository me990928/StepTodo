//
//  TodoGraf.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/29.
//

import SwiftUI
import SwiftData

struct TodoGraf: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var todoGrafViewModel = TodoGrafViewModel()
    
    @State var totalScore:Float = 0.0
    @State var res:CGFloat = 0.0
    
    var body: some View {
        VStack{
            
            Text(String(totalScore))
            
            List {
                
                VStack(alignment: .leading){
                    HStack{
                        Text("ALL TODO")
                        Spacer()
                        Text("\(String(Int(round(totalScore * 100))))%")
                    }
                    
                    GeometryReader { proxy in
                        VStack{
                            Rectangle().fill(.gray).frame(width: proxy.size.width, height: 10).cornerRadius(4)
                                .overlay(alignment: .leading) {
                                    Rectangle().fill(.green).frame(width: self.res, height: 10)
                                }.cornerRadius(4)
                        }.onAppear(){
                            res = CGFloat(totalScore) * proxy.size.width
                        }
                    }
                }
                
                ForEach((0..<items.count).reversed(), id: \.self) { index in
                    VStack(alignment: .leading){
                        HStack{
                            Text(items[index].title)
                            Spacer()
                            Text(todoGrafViewModel.getPercentage(data: items[index].step))
                        }
                        ProgressBar(stepIndex: index)
                    }
                }
            }
        }.onAppear(){
            print(items)
            totalScore = todoGrafViewModel.getTotalScore(items: items)
        }
    }
}

#Preview {
    TodoGraf()
}
