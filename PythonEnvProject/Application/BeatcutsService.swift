//
//  BeatcutsService.swift
//  Bluefilm-MacOS
//
//  Created by Breno Valadão on 19/01/23.
//

import Combine
import Foundation
import Python
import PythonKit

struct BeatcutsService {
    
    private let beatcutsQueue = DispatchQueue(label: "beatcuts.bg.queue", qos: .background)
    
    func getBeatcutsCompletion(for path: String, completion: @escaping (Result<[Double], Swift.Error>) -> Void) {
        // It crashes if I try to run it `async`, with `sync` it works but blocks UI
        beatcutsQueue.sync {
            
            let beatcuts = Python.import("Beatcuts")
            
            let result = beatcuts.get_timestamps_from_audio(path)
            
            if let error = BeatcutsServiceError(value: Int(result)) {
                return completion(.failure(error))
            }
            
            return completion(.success(result.compactMap(Double.init)))
        }
    }
}

enum BeatcutsServiceError: Int, Error {
    case unknown = 1000
    case invalidPath = 1001
    case fileNotFound = 1002
    case corrupted = 1003
    case invalidData = 1004

    init?(value: Int?) {
        guard let value else {
            return nil
        }

        switch value {
        case 1000: self = .unknown
        case 1001: self = .invalidPath
        case 1002: self = .fileNotFound
        case 1003: self = .corrupted
        default: self = .unknown
        }
    }
}
