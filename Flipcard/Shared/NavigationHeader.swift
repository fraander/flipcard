//
//  NavigationHeader.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct NavigationHeader: View {
	let newCardAction: () -> Void
	
	@Binding var view: Int
	let viewChoices = ["rectangle.grid.1x2", "rectangle.grid.2x2", "rectangle.stack"]
	
	@State var newCardViewShowing = false

    var body: some View {
		HStack {
			Picker("View", selection: $view) {
				ForEach(0..<viewChoices.count) { index in
					Image(systemName: "\(viewChoices[index])")
						.tag(index)
				}
			}
			.pickerStyle(.segmented)
			.frame(maxWidth: 120)
			
			Spacer()
			
			Button {
				newCardViewShowing = true
			} label: {
				Label("New Card", systemImage: "plus")
					.tint(.orange)
			}
			
		}
		.sheet(isPresented: $newCardViewShowing, onDismiss: {
			newCardAction()
		}){
			NewCardView(newCardViewShowing: $newCardViewShowing)
				.frame(minWidth: 300)
		}
		.padding(.horizontal)
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
		NavigationHeader(newCardAction: {print("pressed")}, view: .constant(0))
    }
}
