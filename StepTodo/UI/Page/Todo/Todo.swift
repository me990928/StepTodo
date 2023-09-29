//
//  Todo.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import SwiftUI
import SwiftData

struct Todo: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var inputSheet:Bool = false
    
    var body: some View {
        NavigationSplitView{
            
            List {
                ForEach((0..<items.count).reversed(), id: \.self){index in
                    
                    NavigationLink {
                        VStack{
                            HStack{
                                Spacer()
                            }
//                            ForEach(item.step, id: \.self){ sub in
//                                Text(sub.title)
//                            }
                            TodoDetail(index: index, title: items[index].title, sub: items[index].sub, steps: items[index].step).cornerRadius(10).padding().foregroundStyle(.black)
                            Spacer()
                        }.background(Color("back"))
                    } label: {
                        Text(items[index].title).foregroundStyle(.black)
                    }.listRowSeparatorTint(Color("rowSepa"))
                        .listRowBackground(Color("listBack"))
                    
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("back"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        inputSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }  detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $inputSheet, content: {
            //            ScrollView{
            //                InputSheet()
            //            }
            InputSheet(inputSheet: $inputSheet).interactiveDismissDisabled()
        })
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
}

#Preview {
    Todo()
}
