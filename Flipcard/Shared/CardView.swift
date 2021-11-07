//
//  CardView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct CardBackground: View {
	@ObservedObject var card: CD_Card
	@Binding var dragAnimator: CGSize
	let dragThreshold: CGFloat
	
	var body: some View {
		RoundedRectangle(cornerRadius: 20.0)
			.fill(.white)
		#if os(iOS)
			.frame(height: 260)
		#elseif os(macOS)
			.frame(width: 300, height: 180)
		#endif
			.shadow(color: dragAnimator.width < -dragThreshold + 50 ? .yellow : dragAnimator.width > dragThreshold - 50 ? .green : .black.opacity(0.5), radius: dragAnimator.width < -dragThreshold + 50 && dragAnimator.width > dragThreshold - 50 ? 20 : 5, x: 0, y: 3)
	}
}

struct CardView: View {
	@ObservedObject var card: CD_Card
	@Binding var cards: [CD_Card]

	@State var showTerm = true
	var flipAnimator: Double {
		showTerm ? 0.0 : 180
	}
	
	@State var dragAnimator: CGSize = .zero
	let dragThreshold: CGFloat = 250
	
    var body: some View {
		VStack {
			VStack {
				if flipAnimator < 90 {
					ZStack {
						CardBackground(card: card, dragAnimator: $dragAnimator, dragThreshold: dragThreshold)
						
						Text(card._term)
							.foregroundColor(.black)
					}
				} else {
					ZStack {
						
						CardBackground(card: card, dragAnimator: $dragAnimator, dragThreshold: dragThreshold)
						
						Text(card._definition)
							.foregroundColor(.black)
					}
					.rotation3DEffect(Angle(degrees: -flipAnimator), axis: (x: 0, y: 1, z: 0))
				}
			}
			.rotation3DEffect(Angle(degrees: flipAnimator), axis: (x: 0, y: 1, z: 0))
			.onTapGesture {
				if card == cards.last {
					withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
						showTerm.toggle()
					}
				}
			}
		}
		.offset(x: dragAnimator.width, y: (dragAnimator.height * 0.2))
		.gesture(
			DragGesture()
				.onChanged { drag in
					withAnimation(.spring()) {
						if card == cards.last {
							dragAnimator = drag.translation
						}
					}
				}
				.onEnded { drag in
					withAnimation(.spring()) {
						if drag.translation.width > dragThreshold {
							if cards.count > 0 {
								cards.removeLast()
							}
							#if os(iOS)
							dragAnimator.width += UIScreen.screenWidth
							#endif
						} else if drag.translation.width < -dragThreshold {
							CoreDataHelper.starCard(card: card)
							if cards.count > 0 {
								cards.removeLast()
							}
							
							#if os(iOS)
							dragAnimator.width -= UIScreen.screenWidth
							#endif
						} else {
							dragAnimator = .zero
						}
					}
						
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						// Put your code which should be executed with a delay here
						dragAnimator = .zero
					}
					
				}
		)
    }
}

#if os(iOS)
extension UIScreen {
	static let screenWidth = UIScreen.main.bounds.size.width
	static let screenHeight = UIScreen.main.bounds.size.height
	static let screenSize = UIScreen.main.bounds.size
}
#endif

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//		CardView()
//			.padding()
//    }
//}
