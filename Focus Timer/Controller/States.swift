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
    breakTimerIsActive,
    pauseTimer(secondsRemaind: TimeInterval, previousState: State)
    
    //MARK: текст и цвет кнопок, в зависим. от состояния
    
    var workAndPauseButtonTitle: String {
        switch self {
        case .initial:
            return "Начать работу"
        case .workTimerIsActive:
            return "Пауза"
        case .breakTimerIsActive:
            return "Пауза"
        case .pauseTimer( _):
            return "Возобновить"
        }
    }
    
    var workAndPauseButtonColor: UIColor {
        switch self {
        case .initial:
            return #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
        case .workTimerIsActive:
            return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
        case .breakTimerIsActive:
            return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
        case .pauseTimer( _):
            return #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
        }
    }
    
    var breakAndStopButtonTitle: String {
        switch self {
        case .initial:
            return "Перерыв"
        case .workTimerIsActive:
            return "Остановить"
        case .breakTimerIsActive:
            return "Остановить"
        case .pauseTimer( _):
            return "Остановить"
        }
    }
    
    var breakAndStopButtonColor: UIColor {
        switch self {
        case .initial:
            return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
        case .workTimerIsActive:
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .breakTimerIsActive:
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .pauseTimer( _):
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
}
