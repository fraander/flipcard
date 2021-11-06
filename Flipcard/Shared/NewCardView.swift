//
//  NewCardView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct NewCardView: View {
	@Binding var newCardViewShowing: Bool
	@State var term = ""
	@State var definition = ""
	
	var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				
				Divider()
				
				Spacer()
					.frame(height: 20)
				
				Text("Term")
					.font(.caption)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
				TextField("Term", text: $term)
					.textFieldStyle(.roundedBorder)
				
				Spacer()
					.frame(height: 20)
				
				Text("Definition")
					.font(.caption)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
				TextField("Definition", text: $definition)
					.textFieldStyle(.roundedBorder)
				
				Spacer()
				
				Button {
					addCard()
					dismiss()
				} label: {
					Text("Add Card")
						.font(.headline)
						.frame(maxWidth: .infinity, minHeight: 40)
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				
			}
			.padding()
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}
					.tint(.orange)
				}
			}
			.navigationTitle("Add Card")
		}
	}
	
	func addCard() {
		CoreDataHelper.addCard(term: term, definition: definition)
	}
	
	func dismiss() {
		newCardViewShowing = false
	}
}

struct NewCardView_Previews: PreviewProvider {
	static var previews: some View {
		NewCardView(newCardViewShowing: .constant(true))
			.preferredColorScheme(.light)
		
		NewCardView(newCardViewShowing: .constant(true))
			.preferredColorScheme(.dark)
	}
}
