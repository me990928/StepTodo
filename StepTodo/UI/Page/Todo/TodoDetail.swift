//
//  TodoDetail.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import SwiftUI
import SwiftData

struct TodoDetail: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var index: Int
    
    @State var title: String
    @State var sub: String
    @State var steps: [stepDetail]
    @State var changeFlag: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Title").font(.title)
                Spacer()
            }
            HStack{
                Text(self.title)
                Spacer()
            }.padding(.leading)
            HStack{
                Text("Sub").font(.title)
                Spacer()
            }.padding(.top)
            HStack{
                Text(self.sub)
                Spacer()
            }.padding(.leading)
            HStack{
                Text("Step").font(.title)
                Spacer()
            }.padding(.top)
            ForEach(0..<self.steps.count, id: \.self){ step in
                HStack{
                    VStack{
                        HStack{
//                            Text(self.steps[step].title)
//                            Spacer()
                            Button {
                                self.steps[step].flag.toggle()
                            } label: {
                                HStack{
                                    Text(self.steps[step].title)
                                    Spacer()
                                    Image(systemName: self.steps[step].flag ? "checkmark.circle.fill" : "circle").foregroundStyle(Color.accentColor)
                                }
                            }

                        }
                        HStack{
                            VStack{
//                                Text(self.steps[step].sub)
                                TextField("Sub", text: $steps[step].sub).font(.caption)
                                Divider()
                            }
                            Spacer()
                        }.padding(.leading)
                        
                    }
                    Spacer()
                }.padding(.leading)
            }
        }.padding().background(Color("listBack"))
            .onChange(of: steps, { oldValue, newValue in
                print("change!!")
                changeFlag = true
                
                if self.changeFlag {
                    print("update")
                    modelContext.delete(items[index])
                    
                    var data: [stepDetail] = []
                    
                    steps.forEach { stepDetails in
                        data.append(stepDetail(id: stepDetails.id, title: stepDetails.title, sub: stepDetails.sub, flag: stepDetails.flag))
                    }
                    
                    let newItem = Item(id: items[index].id, timestamp: items[index].timestamp, title: items[index].title, sub: items[index].sub, step: data)
                    modelContext.insert(newItem)
                    
                    self.index = items.count - 1
                }
                
            })
    }
}

//#Preview {
//    TodoDetail()
//}
