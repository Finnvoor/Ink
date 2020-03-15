//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import Foundation
import SwiftUI

internal protocol ViewConvertible {
    func view() -> MarkdownViewWrapper
}
