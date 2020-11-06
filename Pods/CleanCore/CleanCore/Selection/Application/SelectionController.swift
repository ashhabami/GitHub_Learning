//
//  SelectionController.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 12/07/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

open class SelectionControllerImpl<Entity>: BaseControllerImpl {

    var entity: Entity?

    open func set(_ newEntity: Entity) {
        self.entity = newEntity
        notifyListenersAboutUpdate()
    }

    open func get() -> Entity? {
        return entity
    }

    open func clear() {
        entity = nil
        notifyListenersAboutUpdate()
    }
}
