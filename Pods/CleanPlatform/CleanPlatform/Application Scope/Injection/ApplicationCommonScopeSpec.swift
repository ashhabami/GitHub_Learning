//
//  ApplicationCommonScopeSpec.swift
//  FMC
//
//  Created by Libor Huspenina on 20/04/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Swinject

open class ApplicationCommonScopeSpec: ScopeSpec {
    open func assemblies() -> [Assembly] {
        return [
            LocalizerAssembly(),
            LoggerAssembly(),
            SynchronizerAssembly(),
            ActivityIndicatorAssembly(),
            ErrorCommonAssembly(),
            GenerateIdServiceAssembly(),
            GenericConfigurationAssembly(),
            InvokerAssembly(),
            LocalStorageFactoryAssembly(),
            NetworkingAssembly(),
            ResponseBodyDeserializationStrategyAssembly(),
            SerializerAssembly(),
            TimerAssembly(),
            DebouncerAssembly(),
            TimestampAssembly(),
            DateTimeAssembly()
        ]
    }

    public func start(_ data: Any) -> Assembly {
        return EmptyAssembly()
    }
}
