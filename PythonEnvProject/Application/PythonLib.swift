//
//  PythonLib.swift
//  Bluefilm-MacOS
//
//  Created by Breno Valadão on 17/01/23.
//

import Foundation
import Python
import PythonKit

public enum PythonLib {
    public static func setup() {
        let bundle = Bundle.main

        guard
            let stdLibPath = bundle.path(forResource: "python-stdlib", ofType: nil),
            let libDynloadPath = bundle.path(forResource: "python-stdlib/lib-dynload", ofType: nil)
        else { return }

        let resources = bundle.bundlePath.appending("/Contents/Resources/")

        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath):\(resources)", 1)

        Py_Initialize()
        
        PythonLibrary.useVersion(3, 9)
    }
}
