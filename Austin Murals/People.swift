//
//  People.swift
//  Austin Murals
//
//  Created by Brandon Mahoney on 7/23/19.
//  Copyright © 2019 Brandon Mahoney. All rights reserved.
//

import Foundation


enum People: String {
    case buddha
    case cesarChavez
    case aliciaSilverstone
    case corettaScottKing
    case fredRogers
    case nataliePortman
    case paulMcCartney
    case carlLewis
    case umaThurman
    case aungSanSuuKyi
    case prince
    case albertEinstein
    case rosaParks
    case mohandasGandhi
    case benjaminFranklin
    
    
    var title: String {
        switch self {
            case .buddha: return "Buddha"
            case .cesarChavez: return "Cesar Chavez"
            case .aliciaSilverstone: return "Alicia Silverstone"
            case .corettaScottKing: return "Coretta Scott King"
            case .fredRogers: return "Fred Rogers"
            case .nataliePortman: return "Natalie Portman"
            case .paulMcCartney: return "Paul McCartney"
            case .carlLewis: return "Carl Lewis"
            case .umaThurman: return "Uma Thurman"
            case .aungSanSuuKyi: return "Aung San Suu Kyi"
            case .prince: return "Prince"
            case .albertEinstein: return "Albert Einstein"
            case .rosaParks: return "Rosa Parks"
            case .mohandasGandhi: return "Mohandas Gandhi"
            case .benjaminFranklin: return "Benjamin Franklin"
        }
    }
    
    var overlay: String {
        switch self {
        case .buddha: return "buddhaOverlay"
        case .cesarChavez: return "cesarChavezOverlay"
        case .aliciaSilverstone: return "aliciaSilverstoneOverlay"
        case .corettaScottKing: return "corettaScottKingOverlay"
        case .fredRogers: return "fredRogersOverlay"
        case .nataliePortman: return "nataliePortmanOverlay"
        case .paulMcCartney: return "paulMcCartneyOverlay"
        case .carlLewis: return "carlLewisOverlay"
        case .umaThurman: return "umaThurmanOverlay"
        case .aungSanSuuKyi: return "aungSanSuuKyiOverlay"
        case .prince: return "princeOverlay"
        case .albertEinstein: return "albertEinsteinOverlay"
        case .rosaParks: return "rosaParksOverlay"
        case .mohandasGandhi: return "mohandasGandhiOverlay"
        case .benjaminFranklin: return "benjaminFranklinOverlay"
        }
    }
}
