//
//  EditView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct EditView: View {
	@Binding var editViewCard: CD_Card?
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
					updateCard()
					dismiss()
				} label: {
					Text("Update Card")
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
			.navigationTitle("Edit Card")
			.task {
				if let c = editViewCard {
					
					term = c._term
					definition = c._definition
				}
			}
		}
	}
	
	func updateCard() {
		if let c = editViewCard {
			CoreDataHelper.updateCard(term: term, definition: definition, card: c)			
		}
	}
	
	func dismiss() {
		editViewCard = nil
	}
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//		EditView(editViewCard: <#Binding<CD_Card?>#>)
//    }
//}
