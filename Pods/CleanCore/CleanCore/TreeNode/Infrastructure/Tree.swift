//
//  Tree.swift
//  Cleancore
//
//  Created by Ondrej Fabian on 18/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public class Tree<Type> where Type: Equatable {

    public let rootNode: Node<Type>

    public init(rootNode: Node<Type>) {
        self.rootNode = rootNode
    }

    public func getAllNodes() -> [Node<Type>] {
        return rootNode.getNodeWithChildrenRecursive()
    }

    public func getNode(with value: Type) -> Node<Type>? {
        return getAllNodes().first(where: { $0.value == value })
    }

    public func contains(_ value: Type) -> Bool {
        return getNode(with: value) != nil
    }
}

public class Node<Type>: Equatable where Type: Equatable {

    public let value: Type
    public private(set) weak var parent: Node<Type>?
    public private(set) var children: [Node<Type>]

    public init(value: Type) {
        self.value = value
        self.parent = nil
        self.children = []
    }

    public func addChild(_ child: Node<Type>) {
        child.parent = self
        children.append(child)
    }

    public func removeChild(_ child: Node<Type>) {
        child.parent = nil
        children = children.filter { $0 != child }
    }

    public static func == (lhs: Node<Type>, rhs: Node<Type>) -> Bool {
        return lhs.value == rhs.value
    }

    public func getNodeWithChildrenRecursive() -> [Node<Type>] {
        return [self] + children.flatMap { $0.getNodeWithChildrenRecursive() }
    }
}
