//
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol BusinessErrorParser {
    func parseError(status: Status, headers: ResponseHeaders?, body: DeserializedBody?) throws -> BusinessError
}
