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
		#if os(iOS)
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
				#if os(iOS)
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}
					.tint(.orange)
				}
				#endif
			}
			.navigationTitle("Edit Card")
			.task {
				if let c = editViewCard {
					
					term = c._term
					definition = c._definition
				}
			}
		}
		#else
		VStack {
			TextField("Term", text: $term)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					updateCard()
					dismiss()
				}
				.onExitCommand {
					dismiss()
				}
			TextField("Definition", text: $definition)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					updateCard()
					dismiss()
				}
				.onExitCommand {
					dismiss()
				}
			
			HStack {
				
				Button("Cancel") {
					dismiss()
				}
				.tint(.orange)
				.keyboardShortcut(.cancelAction)
				
				Button {
					updateCard()
					dismiss()
				} label: {
					Text("Update Card")
						.font(.headline)
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				.keyboardShortcut(.defaultAction)
			}
		}
		.padding()
		.task {
			if let c = editViewCard {
				
				term = c._term
				definition = c._definition
			}
		}
#endif
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
