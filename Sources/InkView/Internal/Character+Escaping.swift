/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal extension Character {
    var escaped: String? {
        switch self {
        case ">": return "&gt;"
        case "<": return "&lt;"
        case "&": return "&amp;"
        default: return nil
        }
    }
}

internal extension String {
    var unescaped: String {
        return self
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&amp;", with: "&")
    }
}
