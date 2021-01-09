//
//  ContentView.swift
//  TestBindingSwiftUI
//
//  Created by Duy Hiển on 09/01/2021.
//

import SwiftUI

/*
 Cảm giác đây như 1 bug của Apple (SwiftUI ver 2.0)
 Ở Home có 1 biến @State text, khi chuyển sang màn ViewOne, thay đổi biến đấy, quay về Home, chuyển tiếp sang ViewTwo
- TH1: ViewTwo ko dùng @Binding. Nếu ở Home, ko chỗ nào dùng biến này để hiển thị thì khi sang ViewTwo, sẽ lấy giá trị mặc định của text, chứ ko update chính xác value đã change (khi ở ViewOne).
 ** Trick: Add 1 Text với nội dung là text, lúc đó khi sang ViewTwo sẽ hiển thị đc chính xác value
 - TH2: ViewTwo dùng @Binding. text update chính xác
 */
struct ContentView: View {
    @State private var text = "Hello, world!"
    @State private var isShowViewOne = false
    @State private var isShowViewTwo = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tap to show View One")
                    .padding()
                    .onTapGesture {
                        self.isShowViewOne.toggle()
                    }
                    .sheet(isPresented: $isShowViewOne) {
                        ViewOne(text: $text)
                    }
                
                Text("Tap to show View Two")
                    .padding()
                    .onTapGesture {
                        isShowViewTwo.toggle()
                    }
                    .sheet(isPresented: $isShowViewTwo) {
                        ViewTwo(text: text)
                    }
                
//                 Text(text)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewOne: View {
    @Binding var text: String
    
    var body: some View {
        Button(action: {
            text = "Change Text Hello World!"
        }) {
            Text("Change text")
        }
    }
}

struct ViewTwo: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}
