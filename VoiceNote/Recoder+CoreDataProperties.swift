//
//  Recoder+CoreDataProperties.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import Foundation
import CoreData


extension Recoder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recoder> {
        return NSFetchRequest<Recoder>(entityName: "Recoder");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
//    @NSManaged public var isPlaying: Bool

}
