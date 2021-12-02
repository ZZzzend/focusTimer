//
//  State.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

indirect enum State {
    
    //MARK: Состояния, которые определяют, таймер, цвет и текст кнопок
    
    case initial,
         workTimerIsActive,
         pauseTimer
    
    //MARK: текст и цвет кнопок, в зависим. от состояния
    
    var workAndPauseButtonTitle: String {
        switch self {
        case .initial:
            return "Начать работу"
        case .workTimerIsActive:
            return "Пауза"
        case .pauseTimer:
            return "Возобновить"
        }
    }
    
    var workAndPauseButtonColor: UIColor {
        switch self {
        case .initial:
            return UIColor(named: "AppGreen")!
        case .workTimerIsActive:
            return UIColor(named: "AppBlue")!
        case .pauseTimer:
            return UIColor(named: "AppGreen")!
        }
    }
    
    var breakAndStopButtonTitle: String {
        switch self {
        case .initial:
            return "Перерыв"
        case .workTimerIsActive:
            return "Остановить"
        case .pauseTimer:
            return "Остановить"
        }
    }
    
    var breakAndStopButtonColor: UIColor {
        switch self {
        case .initial:
            return UIColor(named: "AppBlue")!
        case .workTimerIsActive:
            return UIColor(named: "AppRed")!
        case .pauseTimer:
            return UIColor(named: "AppRed")!
        }
    }
    
}
