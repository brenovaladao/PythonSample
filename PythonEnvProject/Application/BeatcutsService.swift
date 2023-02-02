//
//  BeatcutsService.swift
//  Bluefilm-MacOS
//
//  Created by Breno Valadão on 19/01/23.
//

import Foundation
import Python
import PythonKit

struct BeatcutsService {
    func getBeatcutsCompletion(for path: String) async throws -> [Double] {
        
        let result = PythonLib.beatcuts.get_timestamps_from_audio(path)
            
        guard Int(result) == nil else {
            throw BeatcutsServiceError()
        }
            
        return result.compactMap(Double.init)
    }
}

struct BeatcutsServiceError: Error {}
