
import SwiftUI

@main
struct SampleView: App {
    @StateObject private var viewModel: SampleViewModel = .init()
    
    init() {
        PythonLib.setup()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    Text("Tap the button to get the beatcuts from sample audio file")
        
                    Button(action: {
                        Task {
                            await viewModel.getBeatcuts()
                        }
                    }, label: {
                        Text("Tap for fetching beats")
                    })
                    
                    Text(viewModel.errorMessage ?? "")
                    
                    Text(viewModel.beatcuts.compactMap { String($0) }.joined(separator: ","))
                        .lineLimit(3)
                }
            
                if viewModel.isLoading {
                    Color.black
                        .opacity(0.2)
                        .ignoresSafeArea()

                    ProgressView()
                }
            }
            .frame(
                minWidth: 1130,
                maxWidth: .infinity,
                minHeight: 632,
                maxHeight: .infinity,
                alignment: .center
            )
        }
    }
}
