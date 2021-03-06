//
// ProfileMdl.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class ProfileMdl: JSONEncodable {

    public var id: String?
    public var username: String?
    public var password: String?
    public var email: String?
    public var prices: [PriceMdl]?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["id"] = self.id
        nillableDictionary["username"] = self.username
        nillableDictionary["password"] = self.password
        nillableDictionary["email"] = self.email
        nillableDictionary["prices"] = self.prices?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
