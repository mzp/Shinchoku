//
//  ComplicationController.swift
//  Shinchoku WatchKit Extension
//
//  Created by mzp on 8/15/15.
//  Copyright © 2015 mzp. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    private lazy var image : CLKImageProvider? =
        UIImage(named: "mark.png").map{ CLKImageProvider(onePieceImage: $0) }

    private lazy var text : CLKSimpleTextProvider = CLKSimpleTextProvider(text: "進捗どうですか?")

    private lazy var modularSmall : CLKComplicationTemplate = {
        let template = CLKComplicationTemplateModularSmallSimpleImage()
        if let image = self.image {
            template.imageProvider = image
        }
        return template
    }()

    private lazy var modularLarge : CLKComplicationTemplate = {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        if let image = self.image {
            template.headerImageProvider = image
        }
        template.headerTextProvider = self.text
        template.body1TextProvider = CLKSimpleTextProvider(text: "だめですか...")

        return template
    }()

    private lazy var utilitarianSmall : CLKComplicationTemplate = {
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        template.textProvider = CLKSimpleTextProvider(text: "進捗")
        if let image = self.image {
            template.imageProvider = image
        }
        return template
    }()

    private lazy var utilitarianLarge : CLKComplicationTemplate = {
        let template = CLKComplicationTemplateUtilitarianLargeFlat()
        template.textProvider = self.text

        if let image = self.image {
            template.imageProvider = image
        }
        return template
    }()

    private lazy var circularSmall : CLKComplicationTemplate = {
        let template = CLKComplicationTemplateCircularSmallRingImage()
        template.fillFraction = 0.5
        if let image = self.image {
            template.imageProvider = image
        }
        return template
    }()

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        getPlaceholderTemplateForComplication(complication) { template in
            if let template = template {
                let entry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
                handler(entry)
            }
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .ModularSmall:
            handler(modularSmall)
        case .ModularLarge:
            handler(modularLarge)
        case .UtilitarianLarge:
            handler(utilitarianLarge)
        case .UtilitarianSmall:
            handler(utilitarianSmall)
        case .CircularSmall:
            handler(circularSmall)
        default:
            ()
        }
    }
    
}
