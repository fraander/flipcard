//
//  GridView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct GridView: View {
	@Binding var view: Int
	
	@FetchRequest(
		entity: CD_Card.entity(),
		sortDescriptors: [
			//			NSSortDescriptor(keyPath: \CD_Card._term, ascending: true),
			//			NSSortDescriptor(keyPath: \CD_Card._definition, ascending: true),
			//			NSSortDescriptor(keyPath: \CD_Card.objectID, ascending: true)
		]
	) var allCards: FetchedResults<CD_Card>
	
	var columns: [[CD_Card]] {
		var output = [[CD_Card](), [CD_Card]()]
		
		for index in (0..<allCards.count) {
			if index % 2 == 0 {
				output[0].append(allCards[index])
			} else {
				output[1].append(allCards[index])
			}
		}
		
		return output
	}
	
    var body: some View {
		VStack {
			NavigationHeader(newCardAction: {}, view: $view)
			
			ScrollView(.vertical) {
				HStack {
					VStack {
						ForEach(columns[0]) { card in
							GridCardView(card: card)
								.frame(maxWidth: .infinity, maxHeight: .infinity)
						}
					}
					
					VStack {
						ForEach(columns[1]) { card in
							GridCardView(card: card)
								.frame(maxWidth: .infinity, maxHeight: .infinity)
						}
					}
				}
			}
			.padding(.horizontal)
		}
    }
}

struct GridCardView: View {
	@ObservedObject var card: CD_Card
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20.0)
				.fill(.white)
				.shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 3)
			
			VStack {
				Text(card._term)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.font(.headline)
				
				Divider()
				
				Text(card._definition)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			.padding()
		}
		.padding(10)
	}
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
		GridView(view: .constant(1))
    }
}
