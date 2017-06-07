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
    init(items: [Student]) {
        self.items = items
    }
}

extension StudentSection: SectionModelType {
    init(original: StudentSection, items: [Student]) {
        self = original
        self.items = items
    }
}

struct Student: HandyJSON {
    var name: String? = ""
    var age: Int? = 0
}


