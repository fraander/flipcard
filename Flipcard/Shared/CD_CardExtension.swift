//
//  CD_CardExtension.swift
//  Flipcard
//
//  Created by Frank on 11/5/21.
//

import Foundation

extension CD_Card {
	var _term: String {
		return term ?? ""
	}
	
	var _definition: String {
		return definition ?? ""
	}
	
	var _starred: Bool {
		return starred
	}
}
