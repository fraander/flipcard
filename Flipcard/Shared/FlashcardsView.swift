//
//  FlashcardsView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct FlashcardsView: View {
	
	@State var cards: [CD_Card] = []
	@State var starred: [CD_Card] = []
	
	@State var stackInitialSize = 0

	@Binding var view: Int
	
    var body: some View {
		ZStack {
			VStack {
				Spacer()
				
				if cards.count == 0 {
					if starred.count != 0 {
						Button("\(Image(systemName: "star.fill"))Study \(starred.count) starred") {
							cards = starred
							CoreDataHelper.clearStarred()
							stackInitialSize = cards.count
							
						}
						.buttonStyle(.borderedProminent)
						.tint(.yellow)
						.frame(minWidth: 100)
						.frame(height: 20)
						.padding(.bottom)
					} else {
						Text("You got them all! 🥳")
							.font(.caption)
							.padding(.bottom)
					}
				}
				
				Button {
					resetStacks()
				} label: {
					Text(cards.count != 0 ? "\((stackInitialSize - cards.count + 1))/\(stackInitialSize)" : "Reset")
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				.frame(minWidth: 100)
				.frame(height: 20)
				
				if cards.count == 0 {
					Spacer()
				}
			}
			
			ZStack {
				ForEach(0..<cards.count, id: \.self) { index in
					CardView(card: cards[index], cards: $cards)
						.offset(x: 0, y: CGFloat(index * -10))
				}
			}
			.onChange(of: cards.count) { newValue in
				starred = CoreDataHelper.getStarred().shuffled()
			}
			.task {
				withAnimation {
					resetStacks()
				}
			}
			.padding()
			
			NavigationHeader(newCardAction: {resetStacks()}, view: $view)
				.frame(maxHeight: .infinity, alignment: .top)
		}
    }
	
	func resetStacks() {
		cards = CoreDataHelper.getCards().shuffled()
		starred = CoreDataHelper.getStarred().shuffled()
		
		CoreDataHelper.clearStarred()
		
		stackInitialSize = cards.count
	}
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
		FlashcardsView(view: .constant(0))
    }
}
