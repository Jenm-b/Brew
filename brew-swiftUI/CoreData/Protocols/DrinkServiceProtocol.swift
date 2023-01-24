//
//  DrinkServiceProtocol.swift
//  brew-core
//
//  Created by Jennifer Munro-Brown on 07/04/2022.
//

import Combine

protocol DrinkService {
    var drinksPublisher: AnyPublisher<[Drink], Never> { get }

    func fetch()
    func save(object: Drink) async throws
    func delete(object: Drink) async throws
    func delete(objects: [Drink]) async throws
    func deleteAll() async throws
}
