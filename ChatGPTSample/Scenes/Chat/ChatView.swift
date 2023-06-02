//
//  ChatView.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 01/06/23.
//

import SwiftUI
import Combine

struct ChatView: View {
    @EnvironmentObject var vm: ChatVM
    @State var messageInput: String = ""
    
    var body: some View {
        VStack {
            ForEach(vm.messages, id: \.content) { message in
                ChatRow(message: message)
            }
        }
        Spacer()
        HStack {
            TextField("Type a message...", text: $messageInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
            Button(action: {
                vm.sendMessage(messageInput)
                messageInput = ""
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .disabled(messageInput.isEmpty)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .navigationTitle("Chat")
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
