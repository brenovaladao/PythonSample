
import SwiftUI

@main
struct PythonEnvProject: App {
    @StateObject private var viewModel: SampleVM = .init()
    
    init() {
        PythonLib.setup()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    Text("Tap the button to get the beatcuts from sample audion file")
                    
                    Button(action: {
                        viewModel.getBeatcuts()
                    }, label: {
                        Text("Tap me!")
                    })
                    
                    Text(viewModel.error ?? "")
                    
                    Text(viewModel.beatcuts.compactMap { String($0) }.joined(separator: ","))
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

@MainActor
class SampleVM: ObservableObject {
    @Published private(set) var beatcuts: [Double] = []
    @Published private(set) var error: String?
    @Published private(set) var isLoading: Bool = false

    private let service: BeatcutsService = .init()
    
    func getBeatcuts() {
        error = nil
        
        guard let path = Bundle.main.path(forResource: "test_example", ofType: "m4a") else {
            error = "file not found"
            return
        }
        
        isLoading = true
        
        service.getBeatcutsCompletion(for: path) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(beatcuts):
                    self?.beatcuts = beatcuts
                case let.failure(error):
                    self?.error = error.localizedDescription
                }
                self?.isLoading = false
            }
        }
    }
}
