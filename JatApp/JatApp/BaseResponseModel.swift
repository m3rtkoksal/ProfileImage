//
//  BaseResponseModel.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

// RESPONSE
struct BaseResponseModel<GenericModel: Codable>: Codable {
    var responseData: GenericModel?
    var methodId: Int?
    var hasError: Bool
    var displayErrorPopups: Bool
    
    init() {
        self.responseData = nil
        self.hasError = false
        self.displayErrorPopups = true
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataString = try? container.decodeIfPresent(String.self, forKey: .responseData)
        if let dataString = dataString, !dataString.isEmpty {
            let responseData = Data(dataString.utf8)
            self.responseData =  try? JSONDecoder().decode(GenericModel.self, from: responseData)
        }
        self.displayErrorPopups = try container.decodeIfPresent(Bool.self, forKey: .displayErrorPopups) ?? true
        self.hasError = try container.decodeIfPresent(Bool.self, forKey: .hasError) ?? false
    }
}


struct EncryptedInitBaseResponseModel: Decodable {
    var encryptedData: Data
}

struct EncryptedBaseResponseModel: Decodable {
    var encryptedData: Data
}
// REQUEST
struct BaseRequestModel: Codable {
    var requestData: String
    var methodId: Int
    var displayErrorPopups: Bool
}

struct BaseServiceRequestModel: Codable{
    var encryptedData: String
    var sessionId: String
}

struct EmptyRequestModel: Codable {}

struct BaseSuccessResponseModel: Codable {
    let success: Bool
}
