//
//  ViewController.swift
//  View
//
//  Created by Harbros47 on 12.01.21.
//

import UIKit

private enum Constants {
    static let valueSize: CGFloat = 8
    static let colors: [UIColor] = [
        .systemGray,
        .yellow,
        .blue,
        .green,
        .brown
    ]
}

class ViewController: UIViewController {
    
    private var blackRect = CGRect()
    private var redRect = CGRect()
    private var blackCheckers: [UIView] = []
    private var checkers: [UIView] = []
    private var viewBlackRect = UIView()
    private var points: [CGPoint] = []
    private var viewBgWhite = UIView()
    private var sizeBoard = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sizeBoard = CGSize(width: min(self.view.bounds.size.width, self.view.bounds.size.height),
                           height: min(self.view.bounds.size.width, self.view.bounds.size.height))
        
        viewBgWhite = board(
            rectView: CGRect(
                x: (self.view.bounds.size.width - sizeBoard.width) / 2,
                y: (self.view.bounds.size.height - sizeBoard.height) / 2,
                width: sizeBoard.width,
                height: sizeBoard.height
            ),
            color: UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1), alpha: 1
            ),
            view: self.view
        )
        fieldСreation()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let color = Constants.colors.randomElement() ?? .red
        blackCheckers.forEach { $0.backgroundColor = color }
        checkers.forEach { points.append($0.frame.origin) }
        points.shuffle()
        for value in checkers {
            let random = points.first ?? .zero
            value.frame.origin = random
            if !points.isEmpty {
                points.removeFirst()
            }
            viewBgWhite.addSubview(value)
        }
    }
    
    private func fieldСreation () {
        blackRect =  CGRect(
            x: 0 ,
            y: 0,
            width: viewBgWhite.frame.size.width  / Constants.valueSize,
            height: viewBgWhite.frame.size.height / Constants.valueSize
        )
        
        for colum in 0..<8 {
            for _ in 0..<4 {
                
                viewBlackRect = UIView(frame: blackRect)
                viewBlackRect.backgroundColor = .black
                
                blackRect.origin.x += (viewBgWhite.frame.size.width / Constants.valueSize) * 2
                blackCheckers.append(viewBlackRect)
                redRect =  CGRect(
                    x: viewBlackRect.frame.origin.x + viewBlackRect.frame.size.width / (Constants.valueSize / 2),
                    y: viewBlackRect.frame.origin.y + viewBlackRect.frame.size.height / (Constants.valueSize / 2),
                    width: viewBgWhite.frame.size.width  / (Constants.valueSize * 2),
                    height: viewBgWhite.frame.size.height / (Constants.valueSize * 2)
                )
                viewBgWhite.addSubview(viewBlackRect)
                
                if colum < 3 {
                    print(createCheckers(frame: redRect, color: .red))
                    checkers.append(createCheckers(frame: redRect, color: .red))
                }
                if colum > 4 {
                    print(createCheckers(frame: redRect, color: .white))
                    checkers.append(createCheckers(frame: redRect, color: .white))
                }
            }
            
            if colum % 2 == 0 {
                blackRect.origin.x = viewBgWhite.frame.size.width / Constants.valueSize
                
            } else {
                blackRect.origin.x = 0
            }
            blackRect.origin.y += viewBgWhite.frame.size.height / Constants.valueSize
        }
    }
    
    private func createCheckers(frame: CGRect, color: UIColor) -> UIView {
        let smallSquad = UIView(frame: frame )
        smallSquad.backgroundColor = color
        viewBgWhite.addSubview(smallSquad)
        return smallSquad
    }
    
    private func board(rectView: CGRect, color: UIColor, view: UIView) -> UIView {
        let localView = UIView(frame: rectView)
        localView.backgroundColor = color
        view.addSubview(localView)
        localView.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]
        return localView
    }
}
