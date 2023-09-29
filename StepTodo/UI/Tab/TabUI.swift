//
//  TabUI.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import SwiftUI

struct TabUI: View {
    
    
    init(){
        //TabViewの背景色の設定（青色）
        UITabBar.appearance().backgroundColor =
        UIColor(Color("toolebarBack"))
    }
    
    var body: some View {
        TabView{
            Todo()
                .tabItem {
                Image(systemName: "doc.text")
                }
            TodoGraf().tabItem { Image(systemName: "gauge.high") }
            Image(systemName: "gear").tabItem { Image(systemName: "gear") }
        }
    }
}

#Preview {
    TabUI()
}
