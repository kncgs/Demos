//
//  StoreManager.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import CoreData

class StoreManager: NSObject {
    
    static let `default` = StoreManager()
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VoiceNote")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            print("CoreData: Inited \(storeDescription)")
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// MARK: insert, delete, search
extension StoreManager {
    func allData() -> [RecorderModel] {
        var datas: [RecorderModel] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recoder")//: NSFetchRequest<Recoder> = Recoder.fetchRequest()
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                let name = result.value(forKey: "name") as! String
                let model = RecorderModel()
                model.name = name
                datas.append(model)
            }
            return datas
        } catch {
            fatalError("get data failed")
        }
    }
    
    func insert(model: RecorderModel) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Recoder", in: context)
        let recoder = NSManagedObject(entity: entity!, insertInto: context)
        recoder.setValue(model.name, forKey: "id")
        recoder.setValue(model.name, forKey: "name")
        do {
            try context.save()
        } catch {
            fatalError("save data failed")
        }
    }
    
    func delete(model: RecorderModel) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recoder")//: NSFetchRequest<Recoder> = Recoder.fetchRequest()
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            guard results.count > 0 else {
                print("no found this data")
                return
            }
            context.delete(results.first as! NSManagedObject)
            deleteLocalData(name: model.name!)
            do {
                try context.save()
            } catch {
                fatalError("save data failed when delete an object")
            }
        } catch {
            fatalError("delete data failed")
        }
    }
    func deleteLocalData(name: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let dest = urls[0].appendingPathComponent(name)
        
        if !fileManager.fileExists(atPath: dest.absoluteString) {
            do {
                try fileManager.removeItem(at: dest)
            } catch {
                print("delete local record failed")
            }
        }
    }

}
