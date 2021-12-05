//
//  AudioNotifications.swift
//  Focus Timer
//
//  Created by Владислав on 02.12.2021.
//

import AudioToolbox

class AudioNotifications {
    static func playFinishTimer() {
        AudioServicesPlaySystemSound(SystemSoundID(1022))
    }
}
