//
//  ScopeController.swift   
//  FMC
//
//  Created by Ondrej Fabian on 02/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public enum ScopeControllerError: Error {
    case scopeAlreadyStarted
    case discardingAbsentScope
    case parentScopeAbsent
    case invalidStartData
}

public enum ScopeEvent: Equatable {
    case started(Scope)
    case discarded(Scope)

    public static func ==(lhs: ScopeEvent, rhs: ScopeEvent) -> Bool {
        switch (lhs, rhs) {
        case (let .started(lhsScope), let .started(rhsScope)):
            return lhsScope == rhsScope
        case (.discarded(let lhsScope), .discarded(let rhsScope)):
            return lhsScope == rhsScope
        default:
            return false
        }
    }
}

public protocol ScopeController: BaseController {
    func start(scope: Scope, with data: Any, parent: Scope) throws
    func discard(scope: Scope) throws
    func rootScope() -> Scope
    func getChildScopes(of scope: Scope) -> [Scope]
    func getScopeEvent() -> ScopeEvent?
}

public class ScopeControllerImpl: BaseControllerImpl, ScopeController {

    private let startedScopes: Tree<Scope>

    private let scopeService: ScopeService

    private var scopeEvent: ScopeEvent? = nil

    public init(applicationScope: ApplicationScope, scopeService: ScopeService) {
        self.startedScopes = Tree<Scope>(rootNode: Node<Scope>(value: applicationScope))
        self.scopeService = scopeService
    }

    public func start(scope: Scope, with data: Any, parent: Scope) throws {
        guard getNode(with: scope) == nil else {
            logWarning("ScopeControllerError.\(ScopeControllerError.scopeAlreadyStarted) \(scope.description)", domain: .scope)
            throw ScopeControllerError.scopeAlreadyStarted
        }
        guard let parentNode = getNode(with: parent) else {
            logWarning("ScopeControllerError.\(ScopeControllerError.parentScopeAbsent) \(parent.description)", domain: .scope)
            throw ScopeControllerError.parentScopeAbsent
        }
        guard parentNode.value === parent else {
            logWarning("ScopeControllerError.\(ScopeControllerError.parentScopeAbsent) \(parent.description)", domain: .scope)
            throw ScopeControllerError.parentScopeAbsent
        }
        try scopeService.start(scope: scope, with: data, parent: parent)
        parentNode.addChild(Node(value: scope))
        start(scope: scope)
    }

    public func start(scope: Scope) {
        logIntervalStart("\(scope)", domain: .scope, object: scope)
        notify(about: .started(scope))
    }

    public func discard(scope: Scope) throws {
        guard let node = startedScopes.getNode(with: scope) else {
            logWarning("ScopeControllerError.\(ScopeControllerError.discardingAbsentScope) \(scope.description)", domain: .scope)
            throw ScopeControllerError.discardingAbsentScope
        }
        node.getNodeWithChildrenRecursive().forEach(remove)
    }

    private func remove(scopeNode: Node<Scope>) {
        scopeNode.parent?.removeChild(scopeNode)
        finish(scope: scopeNode.value)
        scopeService.discard(scope: scopeNode.value)
    }

    public func rootScope() -> Scope {
        return startedScopes.rootNode.value
    }

    public func getChildScopes(of scope: Scope) -> [Scope] {
        guard let node = getNode(with: scope) else { return [] }
        return node.children.map { $0.value }
    }

    public func getScopeEvent() -> ScopeEvent? {
        return scopeEvent
    }

    private func getNode(with scope: Scope) -> Node<Scope>? {
        return startedScopes.getAllNodes().first(where: { $0.value == scope })
    }

    private func finish(scope: Scope) {
        switch scope.finishEvent() {
        case .notification:
            notify(about: .discarded(scope))
        case .completion(let completion):
            completion()
        }
        logIntervalEnd("\(scope)", object: scope)
    }

    private func notify(about event: ScopeEvent) {
        scopeEvent = event
        notifyListenersAboutUpdate()
        scopeEvent = nil
    }
}
