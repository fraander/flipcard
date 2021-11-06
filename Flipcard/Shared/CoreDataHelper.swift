//
//  SwiftUIView.swift
//  Flipcard
//
//  Created by Frank on 11/5/21.
//

import CoreData
import SwiftUI

struct CoreDataHelper {
	static private var viewContext = PersistenceController.shared.container.viewContext
	
	/// Only performs a save if there are changes to commit.
	/// - Returns: `true` if a save was needed. Otherwise, `false`.
	@discardableResult public static func saveContext() throws -> Bool {
		guard CoreDataHelper.viewContext.hasChanges else { return false }
		enactSave()
		return true
	}
	
	static func enactSave() {
		DispatchQueue.main.async {
			
			do {
				try viewContext.save()
			} catch {
				let error = error as NSError
				fatalError("Unresolved Error: \(error)")
			}
			
		}
		
	}
	
	static func addCard(term: String, definition: String) {
		withAnimation {
			let newCard = CD_Card(context: viewContext)
			newCard.term = term
			newCard.definition = definition
			newCard.starred = false
			
			do {
				try viewContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
	
	static func updateCard(term: String, definition: String, card: CD_Card) {
		card.term = term
		card.definition = definition
		
		do {
			try viewContext.save()
		} catch {
			// Replace this implementation with code to handle the error appropriately.
			// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}
	
	static func deleteItems(offsets: IndexSet, cards: FetchedResults<CD_Card>) {
		withAnimation {
			offsets.map { cards[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
	
	static func getCards() -> [CD_Card] {
		let fetchRequest : NSFetchRequest<CD_Card> = CD_Card.fetchRequest()
//		fetchRequest.predicate = NSPredicate(format: "title == %@", name)
		let fetchedResults = try? viewContext.fetch(fetchRequest)
		
		if let f = fetchedResults {
			return f
		} else {
			return []
		}
	}
	
	static func getStarred() -> [CD_Card] {
		let fetchRequest : NSFetchRequest<CD_Card> = CD_Card.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "starred == true")
		let fetchedResults = try? viewContext.fetch(fetchRequest)
		
		if let f = fetchedResults {
			return f
		} else {
			return []
		}
	}
	
	static func toggleStar(card: CD_Card) {
		card.starred.toggle()
		
		let _ = try? saveContext()
	}

	
	static func starCard(card: CD_Card) {
		card.starred = true
		
		let _ = try? saveContext()
	}
	
	static func clearStarred() {
		let fetchRequest : NSFetchRequest<CD_Card> = CD_Card.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "starred == true")
		let fetchedResults = try? viewContext.fetch(fetchRequest)
		
		for c in fetchedResults ?? [] {
			c.starred = false
		}
		
		let _ = try? saveContext()
	}
}
