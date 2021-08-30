//
//  BindingExtention.swift
//  BindingExtention
//
//  Created by Anthony on 30/08/21.
//

import Foundation
import SwiftUI

extension Binding {
    init<ObjectType: AnyObject>(
        to path: ReferenceWritableKeyPath<ObjectType, Value>,
        on object: ObjectType
    ) {
        self.init(
            get: { object[keyPath: path] },
            set: { object[keyPath: path] = $0 }
        )
    }
}
