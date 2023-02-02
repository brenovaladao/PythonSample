//
//  SampleViewModel.swift
//  PythonEnvProject
//
//  Created by Breno Valadão on 02/02/23.
//

import SwiftUI

@MainActor
final class SampleViewModel: ObservableObject {
    @Published private(set) var beatcuts: [Double] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading: Bool = false

    private let service: BeatcutsService = .init()
    private let musicPath = Bundle.main.path(forResource: "test_example", ofType: "m4a")!

    func getBeatcuts() async {
        errorMessage = nil
        isLoading = true
        
        do {
            beatcuts = try await service.getBeatcutsCompletion(for: musicPath)
        } catch {
            errorMessage = "Error getting beat cuts"
        }
            
        isLoading = false
    }
}
