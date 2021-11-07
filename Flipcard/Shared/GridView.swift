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
	
	@State var numColumns = 2;
	
    var body: some View {
		GeometryReader { geo in
			VStack {
				NavigationHeader(newCardAction: {}, view: $view)
				
				ScrollView(.vertical) {
					LazyVGrid(columns: Array.init(repeating: GridItem(), count: numColumns)) {
						ForEach(allCards) { card in
							GridCardView(card: card)
						}
					}
				}
				.padding(.horizontal)
			}
			.task {
				#if os(macOS)
				numColumns = Int(geo.size.width / 300)
				#elseif os(iOS)
				numColumns = Int(geo.size.width / 150)
				#endif
			}
			.onChange(of: geo.size.width) { _ in
#if os(macOS)
				numColumns = Int(geo.size.width / 300)
#elseif os(iOS)
				numColumns = Int(geo.size.width / 150)
#endif
			}
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
					.foregroundColor(.black)
					.lineLimit(100)
				
				Divider()
				
				Text(card._definition)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.font(.subheadline)
					.foregroundColor(.black.opacity(0.5))
					.lineLimit(100)
			}
			.padding()
		}
		.padding(10)
#if os(macOS)
		.frame(width: 300/*, height: 150*/)
#endif
	}
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
		GridView(view: .constant(1))
    }
}
