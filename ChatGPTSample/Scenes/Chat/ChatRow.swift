//
//  ChatRow.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 02/06/23.
//

import SwiftUI

struct ChatRow: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
                Text(message.content)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            } else {
                Text(message.content)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                Spacer()
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatRow(message: Message(role: "user", content: "Hello"))
            ChatRow(message: Message(role: "assistant", content: "Hello"))
        }
    }
}
