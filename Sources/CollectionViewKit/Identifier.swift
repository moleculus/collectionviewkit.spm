import Foundation
import UIKit

public protocol Identifier {
    var identifier: String? { get set }
}

public extension Identifier {
    var identifier: String? {
        get {
            return identifier ?? UUID().uuidString
        }
        set {
            identifier = newValue
        }
    }
    
    func identified(by identifier: String) -> Self {
        var new = self
        new.identifier = identifier
        return new
    }
}

