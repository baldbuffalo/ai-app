import SwiftUI

struct ContentView: View {
    @StateObject private var bot = ClaudeAutomator()
    @State private var input = ""
    @State private var showWeb = true

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                TextField("Ask Claude...", text: $input)
                    .textFieldStyle(.roundedBorder)
                Button("Send") { bot.send(input); input = "" }
                Button(showWeb ? "Hide" : "Login") { showWeb.toggle() }
            }
            .padding(.horizontal)

            Text(bot.status).font(.caption).foregroundColor(.secondary)

            if showWeb {
                WebViewContainer(webView: bot.webView)
            } else {
                ScrollView {
                    Text(bot.response)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                Button("Read reply") { bot.readLatest() }
            }
        }
    }
}
