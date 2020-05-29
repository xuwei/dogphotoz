//
//  ServiceEnums.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

let SuccessHTTPStatusCode: Int = 200

enum DogAPIError: Error {
    case invalidParams
    case genericError
}

extension DogAPIError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .invalidParams:
            return "Invalid request parameters"
        case .genericError:
            return "Error has occurred, please try again later"
        }
    }
}
