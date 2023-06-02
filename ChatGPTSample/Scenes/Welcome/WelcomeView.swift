
import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: ChatView()) {
                Text("Welcome to chatbot")
            }
        }.environmentObject(ChatVM(service: ConcreteOpenAIService()))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        return WelcomeView()
    }
}

