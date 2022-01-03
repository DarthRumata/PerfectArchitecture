//
//  EntityStorage.swift
//  CommonLogic
//
//  Created by Stanislav Kirichok on 30.12.2021.
//

import Combine

public protocol EntityType {
    associatedtype ValueType
    associatedtype IdType: Equatable
    
    var id: IdType { get }
    var value: ValueType { get }
    
    func update(with entity: Self)
}

public class EntityStorage<Entity: EntityType> {
    public var values: AnyPublisher<[Entity.ValueType], Never> {
        $entities.map { $0.map { $0.value } }.eraseToAnyPublisher()
    }
    
    @Published private var entities = [Entity]()
    
    public func get(byId id: Entity.IdType) -> Entity.ValueType? {
        return entities.first(where: { $0.id == id })?.value
    }
    
    public func getAll() -> [Entity.ValueType] {
        return entities.map { $0.value }
    }
    
    public func upsert(entity: Entity) {
        guard let storedEntity = entities.first(where: { $0.id == entity.id } ) else {
            entities.append(entity)
            return
        }
        
        storedEntity.update(with: entity)
    }
    
    public func replaceAll(with newEntities: [Entity]) {
        entities = newEntities
    }
}
