//
//  Student.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import Foundation
import HandyJSON
import RxDataSources


struct StudentSection {
    var items: [Student]
//    init(items: [Student]) {
//        self.items = items
//    }
}

extension StudentSection: SectionModelType {
    init(original: StudentSection, items: [Student]) {
        self = original
        self.items = items
    }
}


//extension StudentSection: AnimatableSectionModelType {
//    typealias Item = Student
//    
//    init(original: StudentSection, items: [Student]) {
//        self = original
//        self.items = items
//    }
//    
//    typealias Identity = String
//    var identity: String { return "" }
//}
//
struct Student: HandyJSON {
    var name: String? = ""
    var age: Int? = 0
}
//
//extension Student: IdentifiableType {
//    typealias Identity = String
//    var identity: String { return name ?? "" }
//}
//
//extension Student: Equatable {
//    public static func ==(lhs: Student, rhs: Student) -> Bool {
//        return lhs.name == rhs.name
//    }
//}



