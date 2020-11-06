//
//  NetworkingAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 24/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public final class NetworkingAssembly: Assembly {

    public static let headersCreationStepName = "headersCreationStepName"

    public func assemble(container: Container) {

        container.register(HeadersConfig.self) { r in
            r.resolve(GenericConfiguration.self)!
        }

        container.register(BaseUrlConfig.self) { r in
            r.resolve(GenericConfiguration.self)!
        }

        container.register(NetworkClientConfig.self) { r in
            r.resolve(GenericConfiguration.self)!
        }

        container.register(RequestCreationStep.self, name: NetworkingAssembly.headersCreationStepName) { r in
            let config = r.resolve(HeadersConfig.self)!
            return HeadersRequestCreationStep(config: config)
        }

        container.register(RequestCreationStep.self) { (r: Resolver, creationSteps: [RequestCreationStep]) in
            return RequestCreationStepComposite(creationSteps: creationSteps)
        }

        container.register(BusinessErrorParser.self) { r in
            let primitiveTypeExtractor = r.resolve(PrimitiveTypeExtractor.self)!
            return BusinessErrorParserImpl(primitiveTypeExtractor: primitiveTypeExtractor)
        }

        container.register(PrimitiveTypeExtractor.self) { r in
            FoundationPrimitiveTypeExtractor()
        }

        container.register(UrlEncoder.self) { _ in
            UrlEncoderImpl()
        }

        container.register(RequestFactory.self) { r in
            let urlEncoder = r.resolve(UrlEncoder.self)!
            return URLRequestFactory(urlEncoder: urlEncoder)
        }

        container.register(ResponseProcessor.self) { _ in
            HTTPURLResponseProcessor()
        }

        container.register(CertificatesTrustHandler.self) { _ in
            AllowAllCertificatesTrustHandler()
        }

        container.register(NetworkConnectionErrorParser.self) { _ in
            NetworkConnectionErrorParserImpl()
        }

        container.register(URLSessionConfiguration.self) { _ in
            URLSessionConfiguration.default
        }

        container.register(HttpNetworkClient.self) { r in
            let requestFactory = r.resolve(RequestFactory.self)!            
            let responseProcessor = r.resolve(ResponseProcessor.self)!
            let networkConfig = r.resolve(NetworkClientConfig.self)!
            let certificatesTrustHandler = r.resolve(CertificatesTrustHandler.self)!
            let networkConnectionErrorParser = r.resolve(NetworkConnectionErrorParser.self)!
            let sessionConfiguration = r.resolve(URLSessionConfiguration.self)!

            return SyncNetworkClient(requestFactory: requestFactory, responseProcessor: responseProcessor, networkConfig: networkConfig, certificatesTrustHandler: certificatesTrustHandler, networkConnectionErrorParser: networkConnectionErrorParser, sessionConfiguration: sessionConfiguration)
        }
    }
}
