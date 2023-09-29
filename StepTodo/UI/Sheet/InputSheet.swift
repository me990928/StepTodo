//
//  InputSheet.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import SwiftUI
import SwiftData


struct ProgressViews: View {
    
    @State var text: String
    
    var body: some View {
        VStack{
            ZStack{
                Spacer().frame(maxWidth: .infinity, maxHeight: .infinity).background(.ultraThinMaterial).cornerRadius(20)
                ProgressView(self.text)
            }
        }
    }
}

struct InputSheet: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var title:String = ""
    @State var sub:String = ""
    @State var stepNum: Int = 0
    @State var stepText: [String] = ["none"]
    
    @State var setStepText: [stepDetail] = []
    
    @State var isLoading: Bool = false
    
    var todoViewModel = TodoViewModel()
    
    
    @Binding var inputSheet:Bool
    
    var body: some View {
        
        ScrollViewReader{ proxy in
            ScrollView{
                ZStack{
                    if self.isLoading{
                        ProgressViews(text: "Loading..." )
                    }
                    VStack(alignment: .leading){
                        
                        Group{
                            HStack{
                                Spacer()
                                Button("Close"){
                                    self.inputSheet.toggle()
                                }
                            }
                        }
                        
                        Group{
                            HStack{
                                Text("Title")
                                Spacer()
                            }.padding(.top)
                            TextField("Title", text: $title)
                            Divider().padding(.bottom)
                        }
                        Group{
                            HStack{
                                Text("Sub")
                                Spacer()
                            }
                            TextField("Title", text: $sub)
                            Divider().padding(.bottom)
                        }
                        Group{
                            HStack{
                                Text("Step \(String(self.stepNum))").padding(.trailing, 20)
                                HStack{
                                    Button(action: {
                                        stepNum += 1
                                        stepText.append("")
                                        withAnimation {
                                            proxy.scrollTo(0)
                                        }
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                    .padding(.trailing, 20)
                                    Button(action: {
                                        if (stepNum > 0) {
                                            stepNum -= 1
                                            stepText.removeLast()
                                        }
                                    }, label: {
                                        Image(systemName: "minus").foregroundColor(stepNum > 0 ? Color.accentColor : Color.gray)
                                    })
                                }
                            }.padding(.bottom)
                            
                            if(stepNum > 0){                    VStack{
                                ForEach(0..<self.stepNum, id: \.self){c in
                                    TextField("Step \(c + 1)", text: $stepText[c + 1])
                                    Divider().padding(.bottom)
                                }
                            }.padding(.bottom)
                            }
                        }// group end
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                
                                if(!title.isEmpty){
                                    isLoading = true
                                    // 入力してあれば
                                    act { completed in
                                        if (completed){
                                            // クロージャで登録後に消す
                                            print("hin")
                                            self.title = ""
                                            self.sub = ""
                                            self.stepText = ["none"]
                                            self.stepNum = 0
                                            self.isLoading = false
                                            
                                            self.inputSheet.toggle()
                                        }
                                    }
                                }else{
                                    // 入力していない
                                    print("hun")
                                }
                            }, label: {
                                Text("Submit")
                                    .foregroundColor(Color.white)
                                    .padding(.all)
                                    .background(!title.isEmpty
                                                ? Color("AccentColor") : Color.gray)
                                    .cornerRadius(10)
                            })
                            Spacer()
                        }.padding().id(0)
                        
                        Spacer()
                    }.padding().onAppear(){
                        self.title = ""
                        self.sub = ""
                        self.stepText = ["none"]
                        self.setStepText = []
                    }
            }
        }
        }
    }
    
    
    // テスト関数
    func act(complete: @escaping (Bool)->Void){
        
        self.setStepText = self.todoViewModel.setStepDetail(input: stepText)
        
        let newItem = Item(id: UUID().uuidString, timestamp: Date(), title: self.title, sub: self.sub, step: self.setStepText)
        modelContext.insert(newItem)
        
        complete(true)
    }
}

