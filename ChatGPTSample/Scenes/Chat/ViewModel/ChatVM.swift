//
//  ChatVM.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 02/06/23.
//

import Foundation
import Combine

final class ChatVM: ObservableObject {
    @Published var messages: [Message] = []
    
    private var disposables = Set<AnyCancellable>()
    
    var openAIService: OpenAIService
    
    init(service: OpenAIService) {
        self.openAIService = service
    }
    
    func sendMessage(_ content: String) {
        messages.append(Message(role: "user", content: content))
        self.openAIService.sendMessage("user", content: content)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            } receiveValue: { [weak self] result  in
                guard let self, let choice = result.value.choices.first else { return }
                self.messages.append(choice.message)
            }.store(in: &self.disposables)
    }

}
