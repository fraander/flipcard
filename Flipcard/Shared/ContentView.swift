//
//  ContentView.swift
//  Shared
//
//  Created by Frank on 11/5/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
	@Environment(\.managedObjectContext) private var viewContext
	
	@State var view = 2
		
	var body: some View {
		ZStack {
			if view == 0 {
				ListView(view: $view)
			}
			
			if view == 1 {
				GridView(view: $view)
			}
			
			if view == 2 {
				FlashcardsView(view: $view)
			}
		}		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
