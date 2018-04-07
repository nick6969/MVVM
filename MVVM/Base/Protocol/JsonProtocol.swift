//
//  JsonProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

typealias JsonModel = Codable & JsonProtocol

protocol MultipleContentProtocol: JsonModel {
    associatedtype SubModel: JsonModel
    var subModels: [SubModel] {get set}
}

protocol JsonProtocol {
    static func decodeJSON(data: Data?) throws -> Self
    func encodeToJSON() throws -> Data
}

extension JsonProtocol where Self: Codable {

    static func decodeJSON(data: Data?) throws -> Self {
        guard let data = data else { throw JSONConvertError.noDataError }
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            throw error
        }
    }

    func encodeToJSON() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw error
        }
    }
}

extension Data {
    func decodeToModel<T: JsonModel>(type: T.Type) throws -> T {
        do {
            return try T.decodeJSON(data: self)
        } catch {
            throw error
        }
    }

    func decodeToModelArray<T: JsonModel>(type: T.Type) throws -> [T] {
        do {
            return try JSONDecoder().decode([T].self, from: self)
        } catch {
            throw error
        }
    }
}

extension Array where Element: JsonModel {
    func encodeToJSON() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw error
        }
    }
}

extension Data {

    @nonobjc var string: String? {
        return String(data: self, encoding: .utf8)
    }

}
